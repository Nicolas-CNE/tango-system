#!/bin/bash
# generate_index.sh - Generador de ROGERINDEX para tango-packages

set -e

INDEX_FILE="ROGERINDEX"
echo "# ROGERINDEX - Repositorio Oficial de Tango Linux" > "$INDEX_FILE"
echo "# Generado automáticamente: $(date)" >> "$INDEX_FILE"
echo "" >> "$INDEX_FILE"

for dir in pkgs/*/; do
    if [ -f "${dir}Tangofile" ]; then
        # Cargar variables de la receta
        unset pkgname pkgver pkgrel arch depends
        source "${dir}Tangofile"

        echo "pkgname: $pkgname" >> "$INDEX_FILE"
        echo "version: $pkgver-$pkgrel" >> "$INDEX_FILE"
        echo "arch: $arch" >> "$INDEX_FILE"

        # Formatear dependencias separadas por coma
        if [ ${#depends[@]} -gt 0 ]; then
            deps=$(IFS=, ; echo "${depends[*]}")
            echo "depends: $deps" >> "$INDEX_FILE"
        fi

        echo "url: https://raw.githubusercontent.com/Nicolas-CNE/tango-packages/main/pkgs/${pkgname}/${pkgname}-${pkgver}-${pkgrel}-${arch}.tango.tar.zst" >> "$INDEX_FILE"
        echo "" >> "$INDEX_FILE"

        echo "[+] Registrado en índice: $pkgname ($pkgver-$pkgrel)"
    fi
done

echo "==> $INDEX_FILE generado exitosamente."
