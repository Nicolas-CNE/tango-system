#include <iostream>
#include <vector>
#include <string>
#include <filesystem>

namespace fs = std::filesystem;

// Gestiona o preserva un enlace simbólico de la raíz hacia /usr
void setup_symlink(const fs::path& target_root, const std::string& symlink_name, const std::string& rel_target) {
    fs::path link_path = target_root / symlink_name;
    fs::file_status status = fs::symlink_status(link_path);

    // Si ya existe como enlace simbólico, se detecta y se preserva
    if (fs::is_symlink(status)) {
        std::cout << "  [PRESERVADO] Enlace simbólico detectado: " << symlink_name << " -> " << fs::read_symlink(link_path).string() << "\n";
        return;
    }

    // Si existe como directorio físico
    if (fs::exists(status)) {
        if (fs::is_directory(status) && fs::is_empty(link_path)) {
            std::cout << "  [CORRECCIÓN] Reemplazando directorio vacío en raíz por enlace: " << symlink_name << "\n";
            fs::remove(link_path);
        } else if (fs::is_directory(status)) {
            std::cout << "  [ADVERTENCIA] " << symlink_name << " es un directorio físico con archivos. Se mantendrá.\n";
            return;
        }
    }

    // Crear el enlace si no existía
    try {
        fs::create_symlink(rel_target, link_path);
        std::cout << "  [CREADO] Enlace simbólico: " << symlink_name << " -> " << rel_target << "\n";
    } catch (const std::exception& e) {
        std::cerr << "  [ERROR] Falló la creación del enlace " << symlink_name << ": " << e.what() << "\n";
    }
}

void init_fhs(const std::string& target_str) {
    fs::path target(target_str);
    std::cout << "==> Inicializando estructura FHS Merged-Usr en: " << target_str << "\n";

    // 1. Crear directorios reales dentro de /usr PRIMERO
    std::vector<std::string> usr_dirs = {
        "/usr", "/usr/bin", "/usr/include", "/usr/lib", "/usr/lib64", 
        "/usr/local", "/usr/sbin", "/usr/share", "/usr/src"
    };
    for (const auto& d : usr_dirs) {
        fs::create_directories(target.string() + d);
    }

    // 2. Establecer o preservar enlaces simbólicos esenciales
    setup_symlink(target, "bin", "usr/bin");
    setup_symlink(target, "lib", "usr/lib");
    setup_symlink(target, "lib64", "usr/lib64");
    setup_symlink(target, "sbin", "usr/sbin");

    // 3. Crear el resto de directorios físicos estándar
    std::vector<std::string> root_dirs = {
        "/boot", "/dev", "/etc", "/home", "/media", "/mnt", "/opt", 
        "/proc", "/root", "/run", "/srv", "/sys", "/tmp", "/var",
        "/var/cache", "/var/lib", "/var/local", "/var/lock", "/var/log", 
        "/var/opt", "/var/run", "/var/spool", "/var/tmp",
        "/var/lib/roger/installed"
    };

    for (const auto& d : root_dirs) {
        fs::create_directories(target.string() + d);
    }

    // Permisos 1777 (Sticky Bit) para directorios temporales
    try {
        fs::permissions(target / "tmp", 
            fs::perms::owner_all | fs::perms::group_all | fs::perms::others_all, 
            fs::perm_options::replace);
        fs::permissions(target / "var/tmp", 
            fs::perms::owner_all | fs::perms::group_all | fs::perms::others_all, 
            fs::perm_options::replace);
    } catch (const std::exception& e) {
        std::cerr << "  [ADVERTENCIA] No se pudieron aplicar permisos 1777 en /tmp: " << e.what() << "\n";
    }
}

int main(int argc, char* argv[]) {
    std::string target = "/mnt/tango";

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if ((arg == "--root" || arg == "-r") && i + 1 < argc) {
            target = argv[++i];
        } else if (arg.rfind("--root=", 0) == 0) {
            target = arg.substr(7);
        }
    }

    init_fhs(target);

    std::cout << "==> ¡Estructura de RootFS creada con éxito en " << target << "!\n";
    return 0;
}
