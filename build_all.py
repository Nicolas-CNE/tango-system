#!/usr/bin/env python3
import os
import subprocess
import sys

# Lista de paquetes gigantes a omitir para no saturar disco/red
SKIP_PACKAGES = {
    "0ad", "0ad-data", "linux-firmware", "cuda", "texlive-fontsextra",
    "chromium", "firefox", "libreoffice-fresh", "unreal-engine"
}

TARGET_DIRS = ["./pkgs", "./libs"]
BUILD_SCRIPT = os.path.abspath("./tango-build")

def main():
    if not os.path.exists(BUILD_SCRIPT):
        print(f"[ERROR] No se encontró el ejecutable en: {BUILD_SCRIPT}")
        sys.exit(1)

    for base_dir in TARGET_DIRS:
        if not os.path.exists(base_dir):
            continue

        print(f"\n=== Procesando directorio: {base_dir} ===")
        for entry in sorted(os.listdir(base_dir)):
            if entry in SKIP_PACKAGES:
                print(f"[*] Salteando paquete pesado excluido: {entry}")
                continue

            pkg_path = os.path.join(base_dir, entry)
            if os.path.isdir(pkg_path) and os.path.exists(os.path.join(pkg_path, "Tangofile")):
                print(f"[*] Generando paquete Tango para: {entry}...")
                
                try:
                    res = subprocess.run(
                        [BUILD_SCRIPT],
                        cwd=pkg_path,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        text=True
                    )
                    if res.returncode != 0:
                        print(f"  [X] Falló build de {entry}: {res.stderr.strip()[:100]}")
                    else:
                        print(f"  [OK] {entry} empaquetado.")
                except Exception as e:
                    print(f"  [X] Error en {entry}: {e}")

if __name__ == "__main__":
    main()
