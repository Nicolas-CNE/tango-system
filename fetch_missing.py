#!/usr/bin/env python3
import json
import os
import urllib.request
import urllib.parse

# Mapeo de nombres requeridos a nombres reales de paquetes en Arch Linux
ALIAS_MAP = {
    "libgif": "giflib"
}

MISSING_PKGS = [
    "acl",
    "at-spi2-core",
    "fribidi",
    "glib2",
    "hicolor-icon-theme",
    "libepoxy",
    "libgccjit",
    "libgif",
    "libice",
    "libxcb",
    "sqlite",
    "tree-sitter"
]

ARCH_API_URL = "https://archlinux.org/packages/search/json/?"

def get_package_info(pkg_name):
    target_name = ALIAS_MAP.get(pkg_name, pkg_name)
    query = urllib.parse.urlencode({"name": target_name})
    url = f"{ARCH_API_URL}{query}"
    
    req = urllib.request.Request(url, headers={'User-Agent': 'TangoLinux-Fetcher/1.0'})
    try:
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode())
            results = data.get("results", [])
            
            for pkg in results:
                if pkg.get("pkgname") == target_name and pkg.get("arch") in ["x86_64", "any"]:
                    repo = pkg.get("repo").lower()
                    pkgver = pkg.get("pkgver")
                    pkgrel = pkg.get("pkgrel")
                    arch = pkg.get("arch")
                    
                    filename = f"{target_name}-{pkgver}-{pkgrel}-{arch}.pkg.tar.zst"
                    download_url = f"https://geo.mirror.pkgbuild.com/{repo}/os/{arch}/{filename}"
                    
                    return {
                        "name": target_name,
                        "ver": pkgver,
                        "rel": pkgrel,
                        "arch": arch,
                        "url": download_url
                    }
    except Exception as e:
        print(f"[!] Error al buscar {target_name}: {e}")
    return None

def create_tangofile(info):
    pkg_dir = os.path.join("pkgs", info["name"])
    os.makedirs(pkg_dir, exist_ok=True)
    
    tangofile_path = os.path.join(pkg_dir, "Tangofile")
    
    content = f'''pkgname="{info['name']}"
pkgver="{info['ver']}"
pkgrel="{info['rel']}"
arch="{info['arch']}"
depends=()
sources=("{info['url']}")

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
    with open(tangofile_path, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"[+] Tangofile generado para: {info['name']} ({info['ver']}-{info['rel']})")

def main():
    print("[*] Consultando API de Arch Linux...\n")
    for pkg in MISSING_PKGS:
        info = get_package_info(pkg)
        if info:
            create_tangofile(info)
        else:
            print(f"[❌] No se encontró paquete para: {pkg}")

if __name__ == "__main__":
    main()
