#!/usr/bin/env python3
import os

missing_pkgs = [
    "iproute2", "procps-ng", "tar", "zstd", "shadow", "util-linux",
    "openssl", "binutils", "patch", "flex", "bison", "m4", "gawk",
    "pkgconf", "sed", "grep", "bc", "libcap", "readline", "mpfr", "mpc"
]

for pkg in missing_pkgs:
    pkg_dir = f"pkgs/{pkg}"
    os.makedirs(pkg_dir, exist_ok=True)
    tangofile_path = os.path.join(pkg_dir, "Tangofile")
    
    content = f'''pkgname="{pkg}"
pkgver="1.0"
pkgrel="1"
arch="x86_64"
depends=("glibc")
sources=()

build() {{
    :
}}

package() {{
    :
}}
'''
    with open(tangofile_path, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"[+] Creado paquete stub: {pkg_dir}/Tangofile")

print("\n[*] Estructuras creadas exitosamente.")
