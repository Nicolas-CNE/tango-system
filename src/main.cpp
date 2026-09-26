#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>
#include <cstdlib>
#include <filesystem>
#include <unistd.h>
#include <sys/wait.h>
#include "RogerSAT.hpp"
#include "cli.hpp"

namespace fs = std::filesystem;

bool verbose = false;
std::string root_dir = "/";

const std::string REPO_URL = "https://raw.githubusercontent.com/Nicolas-CNE/tango-packages/main/ROGERINDEX";
const std::string INDEX_PATH = "/tmp/ROGERINDEX";

std::string get_db_path() {
    fs::path p = fs::path(root_dir) / "var/lib/roger/installed";
    return p.string() + "/";
}

void log_verbose(const std::string& msg) {
    if (verbose) std::cout << "[VERBOSE] " << msg << "\n";
}

void ensure_db_dir() {
    std::string db_path = get_db_path();
    if (!fs::exists(db_path)) {
        fs::create_directories(db_path);
    }
}

std::string clean_path(std::string path) {
    while (path.rfind("./", 0) == 0) path = path.substr(2);
    while (!path.empty() && path.front() == '/') path = path.substr(1);
    if (!path.empty() && path.back() == '\r') path.pop_back();
    return path;
}

bool is_meta_or_dir(const std::string& path) {
    if (path.empty()) return true;
    if (path.back() == '/') return true;
    if (path.rfind(".tango-meta", 0) == 0 || path.find("/.tango-meta") != std::string::npos) return true;
    return false;
}

bool is_base_system_pkg(const std::string& pkg) {
    static const std::set<std::string> base_pkgs = {
        "glibc", "zstd", "bash", "coreutils", "gcc-libs", "linux-api-headers", "shadow"
    };
    DependencyResolverSAT sat;
    return base_pkgs.count(pkg) > 0 || sat.isProtected(pkg);
}

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

void update_ldconfig() {
    log_verbose("Actualizando la caché de librerías del sistema (ldconfig)...");
    bool ok = (root_dir == "/" || root_dir.empty()) ? exec_safe({"ldconfig"}) : exec_safe({"ldconfig", "-r", root_dir});
    if (!ok) {
        CLI::printWarning("No se pudo ejecutar ldconfig correctamente.");
    }
}

std::vector<std::string> inspect_archive_files(const std::string& archive_path) {
    std::vector<std::string> files;
    int pipefd[2];
    if (pipe(pipefd) == -1) return files;

    pid_t pid = fork();
    if (pid == 0) {
        dup2(pipefd[1], STDOUT_FILENO);
        close(pipefd[0]);
        close(pipefd[1]);
        execlp("tar", "tar", "-I", "zstd", "-tf", archive_path.c_str(), nullptr);
        _exit(127);
    }

    close(pipefd[1]);
    char buffer[512];
    std::string current_line;
    ssize_t bytes_read;

    while ((bytes_read = read(pipefd[0], buffer, sizeof(buffer) - 1)) > 0) {
        buffer[bytes_read] = '\0';
        for (ssize_t i = 0; i < bytes_read; ++i) {
            if (buffer[i] == '\n') {
                std::string cleaned = clean_path(current_line);
                if (!is_meta_or_dir(cleaned)) files.push_back(cleaned);
                current_line.clear();
            } else {
                current_line += buffer[i];
            }
        }
    }
    if (!current_line.empty()) {
        std::string cleaned = clean_path(current_line);
        if (!is_meta_or_dir(cleaned)) files.push_back(cleaned);
    }
    close(pipefd[0]);

    int status;
    waitpid(pid, &status, 0);
    return files;
}

std::map<std::string, std::string> build_system_file_map() {
    std::map<std::string, std::string> file_owner;
    std::string db_path = get_db_path();
    if (!fs::exists(db_path)) return file_owner;

    for (const auto& entry : fs::directory_iterator(db_path)) {
        if (entry.path().extension() == ".files") {
            std::string pkg = entry.path().stem().string();
            std::ifstream f(entry.path());
            std::string file;
            while (std::getline(f, file)) {
                std::string cleaned = clean_path(file);
                if (!is_meta_or_dir(cleaned)) file_owner[cleaned] = pkg;
            }
        }
    }
    return file_owner;
}

bool validate_transaction_safety(const std::vector<std::string>& pending_pkgs,
                                const std::map<std::string, std::vector<std::string>>& pkg_file_lists) {
    log_verbose("Verificando colisiones e integridad de archivos en el sistema...");
    auto system_files = build_system_file_map();

    for (const auto& pkg : pending_pkgs) {
        auto it = pkg_file_lists.find(pkg);
        if (it == pkg_file_lists.end()) continue;

        for (std::string file : it->second) {
            file = clean_path(file);
            if (is_meta_or_dir(file)) continue;

            if (system_files.count(file)) {
                std::string owner = system_files[file];
                if (owner != pkg && !is_base_system_pkg(owner)) {
                    bool in_tx = (std::find(pending_pkgs.begin(), pending_pkgs.end(), owner) != pending_pkgs.end());
                    if (!in_tx) {
                        CLI::printError("Conflicto de integridad: El paquete '" + pkg + 
                                        "' intenta sobreescribir '" + file + 
                                        "' perteneciente a '" + owner + "'.");
                        return false;
                    }
                }
            }
        }
    }
    return true;
}

void write_manifest_file(const std::string& manifest_path, const std::string& pkg, 
                         const PackageSpec& spec, const std::vector<std::string>& files) {
    std::ofstream mf(manifest_path);
    if (!mf.is_open()) return;

    mf << "pkgname: " << pkg << "\n";
    mf << "version: " << spec.version << "\n";
    mf << "target_root: " << root_dir << "\n";
    mf << "depends: ";
    for (size_t i = 0; i < spec.depends.size(); ++i) {
        mf << spec.depends[i] << (i + 1 < spec.depends.size() ? ", " : "");
    }
    mf << "\n\n[LIBRARIES]\n";
    for (const auto& f : files) {
        if (f.find(".so") != std::string::npos) mf << f << "\n";
    }
    mf << "\n[MANIFEST_FILES]\n";
    for (const auto& f : files) mf << f << "\n";
    mf.close();
}

std::map<std::string, PackageSpec> load_installed_packages() {
    std::map<std::string, PackageSpec> installed;
    ensure_db_dir();
    std::string db_path = get_db_path();
    if (!fs::exists(db_path)) return installed;

    for (const auto& entry : fs::directory_iterator(db_path)) {
        if (entry.path().extension() == ".meta") {
            std::ifstream file(entry.path());
            std::string line;
            PackageSpec pkg;

            while (std::getline(file, line)) {
                size_t colon = line.find(':');
                if (colon != std::string::npos) {
                    std::string key = line.substr(0, colon);
                    std::string val = line.substr(colon + 1);
                    val.erase(0, val.find_first_not_of(" \t"));
                    val.erase(val.find_last_not_of(" \t\r\n") + 1);

                    if (key == "pkgname") pkg.name = val;
                    else if (key == "version") pkg.version = val;
                    else if (key == "explicit") pkg.explicit_installed = (val == "1");
                    else if (key == "depends") {
                        std::stringstream ss(val);
                        std::string dep;
                        while (ss >> dep) {
                            if (!dep.empty() && dep.back() == ',') dep.pop_back();
                            if (!dep.empty()) pkg.depends.push_back(dep);
                        }
                    }
                }
            }
            if (!pkg.name.empty()) installed[pkg.name] = pkg;
        }
    }
    return installed;
}

DependencyResolverSAT load_index(const std::string& filepath) {
    DependencyResolverSAT sat;
    std::ifstream file(filepath);
    if (!file.is_open()) return sat;

    std::string line;
    PackageSpec current_pkg;

    auto push_current = [&]() {
        if (!current_pkg.name.empty()) {
            sat.addPackage(current_pkg);
            current_pkg = PackageSpec();
        }
    };

    while (std::getline(file, line)) {
        if (!line.empty() && line.back() == '\r') line.pop_back();
        if (line.empty() || line[0] == '#') { push_current(); continue; }

        size_t colon = line.find(':');
        if (colon != std::string::npos) {
            std::string key = line.substr(0, colon);
            std::string val = line.substr(colon + 1);

            key.erase(0, key.find_first_not_of(" \t"));
            key.erase(key.find_last_not_of(" \t") + 1);
            val.erase(0, val.find_first_not_of(" \t"));
            val.erase(val.find_last_not_of(" \t") + 1);

            if (key == "pkgname") { push_current(); current_pkg.name = val; }
            else if (key == "version") current_pkg.version = val;
            else if (key == "url") current_pkg.url = val;
            else if (key == "sha256") current_pkg.sha256 = val;
            else if (key == "depends") {
                current_pkg.depends.clear();
                std::stringstream ss(val);
                std::string dep;
                while (ss >> dep) {
                    dep.erase(std::remove(dep.begin(), dep.end(), ','), dep.end());
                    if (!dep.empty()) current_pkg.depends.push_back(dep);
                }
            }
        }
    }
    push_current();
    return sat;
}

void cmd_sync() {
    log_verbose("Descargando ROGERINDEX desde " + REPO_URL);
    if (exec_safe({"curl", "-sL", REPO_URL, "-o", INDEX_PATH})) {
        CLI::printSuccess("Sincronización completa. Índice actualizado.");
    } else {
        CLI::printError("Falló la sincronización del repositorio.");
    }
}

bool verify_checksum(const std::string& filepath, const std::string& expected_sha) {
    if (expected_sha.empty()) return true;
    std::string check_spec = expected_sha + "  " + filepath;
    
    int pipefd[2];
    if (pipe(pipefd) == -1) return false;

    pid_t pid = fork();
    if (pid == 0) {
        dup2(pipefd[0], STDIN_FILENO);
        close(pipefd[1]);
        close(pipefd[0]);
        execlp("sha256sum", "sha256sum", "-c", "--status", nullptr);
        _exit(127);
    }

    close(pipefd[0]);
    write(pipefd[1], check_spec.c_str(), check_spec.size());
    close(pipefd[1]);

    int status;
    waitpid(pid, &status, 0);
    return WIFEXITED(status) && WEXITSTATUS(status) == 0;
}

void cmd_install(const std::vector<std::string>& pkgs) {
    DependencyResolverSAT sat = load_index(INDEX_PATH);
    std::vector<std::string> to_install;
    std::set<std::string> explicit_pkgs(pkgs.begin(), pkgs.end());

    for (const auto& pkg : pkgs) {
        std::vector<std::string> sub_plan;
        if (!sat.resolveInstall(pkg, sub_plan)) {
            CLI::printError("No se pudieron resolver las dependencias para '" + pkg + "'");
            return;
        }
        for (const auto& p : sub_plan) {
            if (std::find(to_install.begin(), to_install.end(), p) == to_install.end()) {
                to_install.push_back(p);
            }
        }
    }

    ensure_db_dir();
    std::string db_path = get_db_path();
    std::vector<std::string> pending_execution;
    std::vector<std::string> deps_list;

    for (const auto& p : to_install) {
        std::string meta_path = db_path + p + ".meta";
        if (fs::exists(meta_path) && explicit_pkgs.find(p) == explicit_pkgs.end()) continue;
        
        pending_execution.push_back(p);
        if (explicit_pkgs.find(p) == explicit_pkgs.end()) {
            deps_list.push_back(p);
        }
    }

    if (pending_execution.empty()) {
        CLI::printInfo("Los paquetes solicitados ya están instalados.");
        return;
    }

    // RESUMEN Y CONFIRMACIÓN
    CLI::printTransactionSummary(pkgs, deps_list, 0, 0);
    if (!CLI::confirm("¿Desea proceder con la instalación?")) {
        CLI::printWarning("Operación cancelada por el usuario.");
        return;
    }

    // FASE 1: DESCARGA
    std::cout << "\n[1/3] Descargando paquetes...\n";
    size_t curr = 0;
    for (const auto& p : pending_execution) {
        curr++;
        CLI::showProgressBar(curr, pending_execution.size(), "Descargando: " + p);
        
        PackageSpec spec = sat.getPackageSpec(p);
        if (spec.url.empty()) continue;

        std::string archive_name = "/tmp/" + p + ".tango.tar.zst";
        if (!exec_safe({"curl", "-f", "-sL", spec.url, "-o", archive_name})) {
            CLI::printError("Falló la descarga del paquete " + p);
            return;
        }

        if (!verify_checksum(archive_name, spec.sha256)) {
            CLI::printError("Checksum SHA256 inválido para " + p);
            fs::remove(archive_name);
            return;
        }
    }

    // FASE 2: VERIFICACIÓN
    std::cout << "\n[2/3] Verificando colisiones e integridad de archivos...\n";
    std::map<std::string, std::vector<std::string>> pkg_file_map;

    for (const auto& p : pending_execution) {
        std::string archive_name = "/tmp/" + p + ".tango.tar.zst";
        if (fs::exists(archive_name)) {
            pkg_file_map[p] = inspect_archive_files(archive_name);
        }
    }

    if (!validate_transaction_safety(pending_execution, pkg_file_map)) {
        for (const auto& p : pending_execution) {
            fs::remove("/tmp/" + p + ".tango.tar.zst");
        }
        return;
    }

    // FASE 3: EXTRACCIÓN
    std::cout << "\n[3/3] Extrayendo e instalando paquetes en el sistema...\n";
    curr = 0;
    for (const auto& p : pending_execution) {
        curr++;
        CLI::showProgressBar(curr, pending_execution.size(), "Instalando:  " + p);

        PackageSpec spec = sat.getPackageSpec(p);
        std::string archive_name = "/tmp/" + p + ".tango.tar.zst";
        std::string meta_path = db_path + p + ".meta";
        std::string file_list = db_path + p + ".files";
        std::string manifest_path = db_path + p + ".manifest";

        if (!fs::exists(archive_name)) {
            std::ofstream meta(meta_path);
            meta << "pkgname: " << p << "\nversion: " << spec.version << "\nexplicit: " << (explicit_pkgs.count(p) ? "1" : "0") << "\ndepends: ";
            for (size_t i = 0; i < spec.depends.size(); ++i) meta << spec.depends[i] << (i + 1 < spec.depends.size() ? ", " : "");
            meta << "\n";
            meta.close();

            std::ofstream files(file_list); files.close();
            write_manifest_file(manifest_path, p, spec, {});
            continue;
        }

        const auto& files = pkg_file_map[p];
        std::ofstream f_list(file_list);
        for (const auto& f : files) f_list << f << "\n";
        f_list.close();

        if (exec_safe({"tar", "--exclude=./.tango-meta", "--exclude=.tango-meta", "-I", "zstd", "-Pxf", archive_name, "-C", root_dir})) {
            std::ofstream meta(meta_path);
            meta << "pkgname: " << p << "\nversion: " << spec.version << "\nexplicit: " << (explicit_pkgs.count(p) ? "1" : "0") << "\ndepends: ";
            for (size_t i = 0; i < spec.depends.size(); ++i) meta << spec.depends[i] << (i + 1 < spec.depends.size() ? ", " : "");
            meta << "\n";
            meta.close();

            write_manifest_file(manifest_path, p, spec, files);
        } else {
            CLI::printError("Falló la extracción del archivo para " + p);
            fs::remove(file_list);
        }

        fs::remove(archive_name);
    }

    update_ldconfig();
    CLI::printSuccess("¡Instalación completada con éxito!");
}

void cmd_delete(const std::vector<std::string>& pkgs) {
    ensure_db_dir();
    DependencyResolverSAT sat;
    std::string db_path = get_db_path();

    if (!CLI::confirm("¿Está seguro de que desea eliminar los paquetes seleccionados?")) {
        CLI::printWarning("Operación cancelada.");
        return;
    }

    for (const auto& pkg : pkgs) {
        std::string files_path = db_path + pkg + ".files";
        std::string meta_path = db_path + pkg + ".meta";
        std::string manifest_path = db_path + pkg + ".manifest";

        if (sat.isProtected(pkg)) {
            CLI::printError("El paquete '" + pkg + "' está protegido por el sistema y no se puede eliminar.");
            continue;
        }

        if (!fs::exists(meta_path)) {
            CLI::printError("El paquete '" + pkg + "' no está instalado.");
            continue;
        }

        std::ifstream files_file(files_path);
        std::string file_to_remove;
        std::set<fs::path> candidate_dirs;

        while (std::getline(files_file, file_to_remove)) {
            std::string cleaned = clean_path(file_to_remove);
            if (is_meta_or_dir(cleaned)) continue;
            
            fs::path p = fs::path(root_dir) / cleaned;
            std::error_code ec;
            auto status = fs::symlink_status(p, ec);
            if (!ec && fs::exists(status) && !fs::is_directory(status)) {
                fs::remove(p, ec);
                if (!ec) candidate_dirs.insert(p.parent_path());
            }
        }

        for (const auto& dir : candidate_dirs) {
            std::error_code ec;
            if (fs::exists(dir) && fs::is_empty(dir, ec) && dir != fs::path(root_dir)) {
                fs::remove_all(dir, ec);
            }
        }

        fs::remove(files_path);
        fs::remove(meta_path);
        fs::remove(manifest_path);
        CLI::printSuccess("Paquete '" + pkg + "' eliminado correctamente.");
    }

    update_ldconfig();
}

void cmd_bomb() {
    auto installed = load_installed_packages();
    DependencyResolverSAT sat;

    auto orphans = sat.findOrphans(installed);

    if (orphans.empty()) {
        CLI::printSuccess("No se encontraron paquetes huérfanos.");
        return;
    }

    std::cout << "Se encontraron las siguientes dependencias huérfanas:\n";
    for (const auto& orphan : orphans) std::cout << "  - " << orphan << "\n";

    cmd_delete(orphans);
}

void cmd_update() {
    cmd_sync();
    auto installed = load_installed_packages();
    DependencyResolverSAT sat = load_index(INDEX_PATH);

    std::vector<std::string> to_upgrade;
    for (const auto& [name, spec] : installed) {
        PackageSpec repo_spec = sat.getPackageSpec(name);
        if (!repo_spec.name.empty() && repo_spec.version != spec.version) {
            to_upgrade.push_back(name);
        }
    }

    if (to_upgrade.empty()) {
        CLI::printSuccess("Todos los paquetes están actualizados a la última versión.");
        return;
    }

    cmd_install(to_upgrade);
}

int main(int argc, char* argv[]) {
    int arg_start = 1;

    while (arg_start < argc) {
        std::string arg = argv[arg_start];
        if (arg == "--verbose") {
            verbose = true;
            arg_start++;
        } else if (arg == "--root" && arg_start + 1 < argc) {
            root_dir = argv[arg_start + 1];
            arg_start += 2;
        } else if (arg.rfind("--root=", 0) == 0) {
            root_dir = arg.substr(7);
            arg_start++;
        } else {
            break;
        }
    }

    if (!root_dir.empty() && root_dir.back() != '/') root_dir += "/";

    if (arg_start >= argc) {
        std::cout << "Uso: roger [--verbose] [--root <ruta>] <sync|install|delete|bomb|update> [paquetes...]\n";
        return 1;
    }

    std::string command = argv[arg_start];
    std::vector<std::string> targets;
    for (int i = arg_start + 1; i < argc; ++i) targets.push_back(argv[i]);

    if (command == "sync") cmd_sync();
    else if (command == "install" && !targets.empty()) cmd_install(targets);
    else if (command == "delete" && !targets.empty()) cmd_delete(targets);
    else if (command == "bomb") cmd_bomb();
    else if (command == "update") cmd_update();
    else std::cout << "Comando o parámetros no válidos: " << command << "\n";

    return 0;
}
