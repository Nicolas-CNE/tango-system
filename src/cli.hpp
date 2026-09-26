#ifndef CLI_HPP
#define CLI_HPP

#include <string>
#include <vector>
#include <cstddef>

namespace CLI {

    // Convierte bytes a formato legible (B, KiB, MiB, GiB)
    std::string formatSize(size_t bytes);

    // Solicita confirmación (Y/n) al usuario
    bool confirm(const std::string& prompt_msg = "¿Desea continuar?");

    // Renderiza una barra de progreso elegante en la consola
    void showProgressBar(size_t current, size_t total, const std::string& prefix = "");

    // Imprime el resumen de paquetes a instalar/eliminar con sus pesos
    void printTransactionSummary(
        const std::vector<std::string>& explicit_pkgs,
        const std::vector<std::string>& deps_pkgs,
        size_t total_download_bytes,
        size_t total_install_bytes
    );

    // Salidas de log formateadas y estilizadas
    void printSuccess(const std::string& msg);
    void printError(const std::string& msg);
    void printWarning(const std::string& msg);
    void printInfo(const std::string& msg);

} // namespace CLI

#endif // CLI_HPP
