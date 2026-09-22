#!/usr/bin/env python3
import os
import re
import urllib.request
import urllib.parse

MIRRORS = [
    "https://geo.mirror.pkgbuild.com/core/os/x86_64/",
    "https://geo.mirror.pkgbuild.com/extra/os/x86_64/"
]

# PAQUETES PROTEGIDOS (Kernel custom, herramientas propias y meta-paquetes sin fuentes)
BLACKLIST = ["linux", "initramfs-tools", "base", "base-devel"]

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

def fetch_mirror_packages():
    packages = {}
    pattern = re.compile(r'href="([^"]+\.pkg\.tar\.zst)"')
    
    for mirror in MIRRORS:
        print(f"[*] Escaneando mirror: {mirror}")
        try:
            req = urllib.request.Request(mirror, headers={'User-Agent': 'Mozilla/5.0'})
            html = urllib.request.urlopen(req, timeout=10).read().decode('utf-8')
            matches = pattern.findall(html)
            
            for pkg_filename in matches:
                clean_filename = urllib.parse.unquote(pkg_filename)
                m = re.match(r'^(.+?)-([0-9].*?)-([0-9]+)-(x86_64|any)\.pkg\.tar\.zst$', clean_filename)
                if m:
                    pkgname, ver, rel, _ = m.groups()
                    full_url = mirror + pkg_filename
                    packages[pkgname] = {
                        'filename': pkg_filename,
                        'version': ver,
                        'release': rel,
                        'url': full_url
                    }
        except Exception as e:
            print(f"[!] Error leyendo {mirror}: {e}")
            
    return packages

def update_tangofile(tangofile_path, upstream_info):
    with open(tangofile_path, 'r') as f:
        content = f.read()

    # Preservar pkgname y depends originales
    pkgname_match = re.search(r'pkgname="([^"]+)"', content)
    depends_match = re.search(r'depends=\(([^\)]*)\)', content)
    
    pkgname = pkgname_match.group(1) if pkgname_match else os.path.basename(os.path.dirname(tangofile_path))
    depends_str = depends_match.group(1) if depends_match else ""

    # Reconstruir Tangofile estandarizado de forma limpia
    clean_tangofile = f'''pkgname="{pkgname}"
pkgver="{upstream_info["version"]}"
pkgrel="{upstream_info["release"]}"
arch="x86_64"
depends=({depends_str})
sources=("{upstream_info["url"]}")

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
'''

    with open(tangofile_path, 'w') as f:
        f.write(clean_tangofile)

def main():
    print("=== Sincronizador Limpio de Tangofiles ===")
    upstream_pkgs = fetch_mirror_packages()
    
    updated_count = 0
    search_dirs = [os.path.join(BASE_DIR, 'pkgs'), os.path.join(BASE_DIR, 'libs')]
    
    for s_dir in search_dirs:
        if not os.path.exists(s_dir):
            continue
        for pkg_folder in os.listdir(s_dir):
            if pkg_folder in BLACKLIST:
                print(f"[!] {pkg_folder} protegido por BLACKLIST. Omitiendo...")
                continue
                
            folder_path = os.path.join(s_dir, pkg_folder)
            tangofile = os.path.join(folder_path, 'Tangofile')
            
            if os.path.isdir(folder_path) and os.path.exists(tangofile):
                if pkg_folder in upstream_pkgs:
                    up_info = upstream_pkgs[pkg_folder]
                    print(f"[+] Reestructurando {pkg_folder} -> {up_info['version']}-{up_info['release']}")
                    update_tangofile(tangofile, up_info)
                    updated_count += 1

    print(f"\n[✓] {updated_count} Tangofiles totalmente estandarizados.")

if __name__ == '__main__':
    main()
