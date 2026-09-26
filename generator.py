#!/usr/bin/env python3
import argparse
import os
import re
import sys
import tarfile
import urllib.request

REPOS = {
    "core": {
        "db_url": "https://geo.mirror.pkgbuild.com/core/os/x86_64/core.db.tar.gz",
        "mirror_base": "https://geo.mirror.pkgbuild.com/core/os/x86_64"
    },
    "extra": {
        "db_url": "https://geo.mirror.pkgbuild.com/extra/os/x86_64/extra.db.tar.gz",
        "mirror_base": "https://geo.mirror.pkgbuild.com/extra/os/x86_64"
    }
}

OUTPUT_PKGS_DIR = "./pkgs"
OUTPUT_LIBS_DIR = "./libs"
ROGERINDEX_FILE = "./ROGERINDEX"

ALPM_PACKAGES = {"pacman", "archlinux-keyring"}

KNOWN_LIBS = {
    "alsa-lib", "cairo", "dav1d", "fontconfig", "freetype2", "gdk-pixbuf2",
    "giflib", "glibc", "gmp", "gnutls", "gpm", "gtk3", "gtk4", "harfbuzz",
    "icu", "jbigkit", "lcms2", "m17n-lib", "ncurses", "nettle", "pango",
    "zlib", "zlib-ng", "zstd", "expat", "readline", "openssl", "pcre2",
    "yyjson", "tree-sitter", "ffmpeg", "mesa", "wayland"
}

def is_library(pkgname):
    if pkgname in KNOWN_LIBS:
        return True
    lib_prefixes = ("lib", "gst-plugin", "qt5-", "qt6-", "python-", "ruby-", "perl-", "lua-")
    return pkgname.startswith(lib_prefixes)

def parse_desc(content):
    data = {}
    current_key = None
    for line in content.splitlines():
        line = line.strip()
        if not line:
            continue
        if line.startswith("%") and line.endswith("%"):
            current_key = line[1:-1]
            data[current_key] = []
        elif current_key:
            data[current_key].append(line)
    return data

def resolve_dependencies(target_pkgs, all_packages, exclude_alpm=False):
    """Resuelve recursivamente todas las dependencias de los paquetes solicitados."""
    resolved = set()
    to_process = list(target_pkgs)

    while to_process:
        pkg = to_process.pop()
        if exclude_alpm and pkg in ALPM_PACKAGES:
            continue
            
        if pkg not in resolved and pkg in all_packages:
            resolved.add(pkg)
            deps = all_packages[pkg]["clean_deps"]
            for dep in deps:
                if exclude_alpm and dep in ALPM_PACKAGES:
                    continue
                if dep not in resolved:
                    to_process.append(dep)
    return resolved

def main():
    parser = argparse.ArgumentParser(description="Generador de Tangofiles y ROGERINDEX para Tango Linux.")
    parser.add_argument("--only", nargs="+", help="Generar Tangofiles para los paquetes especificados Y sus dependencias.")
    parser.add_argument("--all", action="store_true", help="Generar Tangofiles para TODOS los paquetes.")
    parser.add_argument("--excludealpm", action="store_true", help="Eliminar pacman y archlinux-keyring de la generación y de las dependencias.")
    args = parser.parse_args()

    os.makedirs(OUTPUT_PKGS_DIR, exist_ok=True)
    os.makedirs(OUTPUT_LIBS_DIR, exist_ok=True)

    all_packages = {}
    index_entries = []

    # 1. Cargar bases de datos de Arch a memoria
    for repo_name, repo_info in REPOS.items():
        db_url = repo_info["db_url"]
        mirror_base = repo_info["mirror_base"]
        tar_path = f"/tmp/{repo_name}.db.tar.gz"

        print(f"[*] Descargando {repo_name}.db desde {db_url}...")
        urllib.request.urlretrieve(db_url, tar_path)

        with tarfile.open(tar_path, "r:gz") as tar:
            packages = {}
            for member in tar.getmembers():
                if member.name.endswith("/desc"):
                    pkg_dir = member.name.split('/')[0]
                    packages[pkg_dir] = member

            for pkg_dir, desc_member in packages.items():
                f = tar.extractfile(desc_member)
                if not f:
                    continue
                
                content = f.read().decode('utf-8', errors='ignore')
                desc = parse_desc(content)

                pkgname = desc.get("NAME", [""])[0]
                pkgver = desc.get("VERSION", [""])[0]
                filename = desc.get("FILENAME", [""])[0]
                sha256 = desc.get("SHA256SUM", [""])[0]
                depends = desc.get("DEPENDS", [])

                if not pkgname or not filename:
                    continue

                clean_deps = [re.split(r'[<>=]', dep)[0] for dep in depends]
                pkg_sources_url = f"{mirror_base}/{filename}"

                all_packages[pkgname] = {
                    "pkgver": pkgver,
                    "filename": filename,
                    "sha256": sha256,
                    "clean_deps": clean_deps,
                    "url": pkg_sources_url
                }

                index_entry = f"pkgname: {pkgname}\nversion: {pkgver}\nurl: {pkg_sources_url}\nsha256: {sha256}\ndepends: {', '.join(clean_deps)}\n"
                index_entries.append(index_entry)

        if os.path.exists(tar_path):
            os.remove(tar_path)

    # 2. Determinar qué paquetes se van a generar físicamente
    pkgs_to_generate = set()
    if args.all:
        pkgs_to_generate = set(all_packages.keys())
        if args.excludealpm:
            pkgs_to_generate -= ALPM_PACKAGES
    elif args.only:
        pkgs_to_generate = resolve_dependencies(args.only, all_packages, exclude_alpm=args.excludealpm)
        print(f"[*] Paquetes a generar (incluyendo dependencias): {len(pkgs_to_generate)}")
        print(f"    -> {', '.join(sorted(pkgs_to_generate))}")

    # 3. Crear Tangofiles
    for pkgname in pkgs_to_generate:
        if pkgname not in all_packages:
            print(f"[!] Advertencia: El paquete '{pkgname}' no existe en las bases de datos.")
            continue

        data = all_packages[pkgname]
        
        # Filtrar dependencias de pacman/keyring si se pasó --excludealpm
        deps = data["clean_deps"]
        if args.excludealpm:
            deps = [d for d in deps if d not in ALPM_PACKAGES]

        base_dir = OUTPUT_LIBS_DIR if is_library(pkgname) else OUTPUT_PKGS_DIR
        pkg_target_dir = os.path.join(base_dir, pkgname)
        os.makedirs(pkg_target_dir, exist_ok=True)

        deps_str = " ".join([f'"{d}"' for d in deps])
        tangofile_content = f"""pkgname="{pkgname}"
pkgver="{data['pkgver']}"
pkgrel="1"
arch="x86_64"
depends=({deps_str})
sources=("{data['url']}")

build() {{
    echo "==> Extrayendo paquete fuente genérico..."
    for pkg in "$SRC_DIR"/*.pkg.tar.zst; do
        if [ -f "$pkg" ]; then
            tar -I zstd -xf "$pkg" -C "$PKG_DIR"
        fi
    done
    rm -rf "$PKG_DIR"/.PKGINFO "$PKG_DIR"/.BUILDINFO "$PKG_DIR"/.MTREE
}}

package() {{
    :
}}
"""
        with open(os.path.join(pkg_target_dir, "Tangofile"), "w") as tf:
            tf.write(tangofile_content)

    # 4. Escribir ROGERINDEX global
    print(f"[*] Escribiendo {ROGERINDEX_FILE}...")
    with open(ROGERINDEX_FILE, "w") as idx:
        idx.write("\n".join(index_entries))

    print(f"[+] ¡Listo! Proceso finalizado.")

if __name__ == "__main__":
    main()
