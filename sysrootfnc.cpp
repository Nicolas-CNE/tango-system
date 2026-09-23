#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <filesystem>
#include <unistd.h>
#include <sys/wait.h>

namespace fs = std::filesystem;

bool exec_safe(const std::vector<std::string>& args) {
    if (args.empty()) return false;
    
    pid_t pid = fork();
    if (pid == 0) {
        std::vector<char*> c_args;
        for (const auto& arg : args) {
            c_args.push_back(const_cast<char*>(arg.c_str()));
        }
        c_args.push_back(nullptr);

        execvp(c_args[0], c_args.data());
        _exit(127);
    } else if (pid > 0) {
        int status;
        waitpid(pid, &status, 0);
        return WIFEXITED(status) && WEXITSTATUS(status) == 0;
    }
    return false;
}

void init_fhs(const std::string& target) {
    std::cout << "==> Inicializando jerarquía FHS en: " << target << "\n";
    std::vector<std::string> dirs = {
        "/bin", "/boot", "/dev", "/etc", "/home", "/lib", "/lib64", 
        "/media", "/mnt", "/opt", "/proc", "/root", "/run", "/sbin", 
        "/srv", "/sys", "/tmp", "/usr", "/var",
        "/usr/bin", "/usr/include", "/usr/lib", "/usr/local", "/usr/sbin", "/usr/share", "/usr/src",
        "/var/cache", "/var/lib", "/var/local", "/var/lock", "/var/log", "/var/opt", "/var/run", "/var/spool", "/var/tmp",
        "/var/lib/roger/installed"
    };

    for (const auto& dir : dirs) {
        fs::create_directories(target + dir);
    }
    fs::permissions(target + "/tmp", fs::perms::owner_all | fs::perms::group_all | fs::perms::others_all, fs::perm_options::replace);
    fs::permissions(target + "/var/tmp", fs::perms::owner_all | fs::perms::group_all | fs::perms::others_all, fs::perm_options::replace);
}

// Función para encontrar el tarball real descargado en /tmp
std::string find_downloaded_archive(const std::string& pkg_name) {
    // 1. Intentar encontrar por patrón en /tmp (ej: bash-5.3.20-1-x86_64.tango.tar.zst)
    for (const auto& entry : fs::directory_iterator("/tmp")) {
        if (entry.is_regular_file()) {
            std::string filename = entry.path().filename().string();
            if (filename.rfind(pkg_name + "-", 0) == 0 && filename.find(".tango.tar.zst") != std::string::npos) {
                return entry.path().string();
            }
        }
    }
    
    // 2. Intentar nombre directo como fallback (ej: /tmp/bash.tango.tar.zst)
    std::string direct_path = "/tmp/" + pkg_name + ".tango.tar.zst";
    if (fs::exists(direct_path)) {
        return direct_path;
    }

    return "";
}

bool deploy_package(const std::string& target, const std::string& pkg) {
    std::cout << " -> Sincronizando e instalando '" << pkg << "' para el target " << target << "...\n";

    // Usamos el nuevo comando download para que preserve los tarballs en /tmp/
    if (!exec_safe({"roger", "download", pkg})) {
        std::cerr << "[ERROR] Falló la descarga de: " << pkg << "\n";
        return false;
    }

    std::string archive = find_downloaded_archive(pkg);

    if (archive.empty()) {
        if (pkg == "base") return true;
        std::cerr << "[ERROR] No se encontró el tarball descargado para " << pkg << " en /tmp.\n";
        return false; 
    }

    // Extraer en el RootFS objetivo
    std::cout << " -> Desempaquetando " << archive << " en " << target << "...\n";
    if (!exec_safe({"tar", "-I", "zstd", "-Pxf", archive, "-C", target})) {
        std::cerr << "[ERROR] Falló la extracción de " << archive << " en " << target << "\n";
        return false;
    }

    // Limpiar tarball de /tmp manualmente después de extraer
    fs::remove(archive);

    return true;
}

int main(int argc, char* argv[]) {
    std::string target = "/mnt/tango";
    std::vector<std::string> packages_to_deploy;

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "--root" && i + 1 < argc) {
            target = argv[++i];
        } else {
            packages_to_deploy.push_back(arg);
        }
    }

    if (packages_to_deploy.empty()) {
        // Paquetes base por defecto
        packages_to_deploy = {"base", "bash", "coreutils", "gcc", "glibc", "linux", "util-linux", "zstd", "yyjson"};
    }

    init_fhs(target);

    // Sincronizar repositorio con el roger original
    exec_safe({"roger", "sync"});

    std::cout << "==> Desplegando Tango Linux en " << target << "...\n";
    for (const auto& pkg : packages_to_deploy) {
        if (!deploy_package(target, pkg)) {
            std::cerr << "[ERROR CRÍTICO] Abortando despliegue de RootFS.\n";
            return 1;
        }
    }

    std::cout << "\n==> ¡Despliegue de RootFS completado con éxito en " << target << "!\n";
    return 0;
}
