#!/usr/bin/env python3
import os
import re

TARGET_DIRS = ["pkgs", "libs"]
defined_packages = set()
dependencies_map = {}

def parse_tangofile(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Extraer pkgname
    pkgname_match = re.search(r'pkgname=["\']?([^"\'\n\s]+)["\']?', content)
    pkgname = pkgname_match.group(1) if pkgname_match else None

    # Extraer contenido dentro de depends=(...)
    deps = []
    depends_match = re.search(r'depends=\((.*?)\)', content, re.DOTALL)
    if depends_match:
        raw_deps = depends_match.group(1)
        # Limpiar comillas, comas y saltos de línea
        tokens = re.findall(r'["\']?([^"\'\s]+)["\']?', raw_deps)
        deps = [t for t in tokens if t and not t.startswith("#")]

    return pkgname, deps

print("[*] Escaneando Tangofiles...")

for base_dir in TARGET_DIRS:
    if not os.path.exists(base_dir):
        continue
    for root, _, files in os.walk(base_dir):
        if "Tangofile" in files:
            filepath = os.path.join(root, "Tangofile")
            pkgname, deps = parse_tangofile(filepath)
            if pkgname:
                defined_packages.add(pkgname)
                dependencies_map[pkgname] = (filepath, deps)

missing_deps = {}

for pkg, (filepath, deps) in dependencies_map.items():
    for dep in deps:
        if dep not in defined_packages:
            if dep not in missing_deps:
                missing_deps[dep] = []
            missing_deps[dep].append(pkg)

print("\n" + "="*50)
print(f"Total de paquetes definidos: {len(defined_packages)}")
print("="*50)

if missing_deps:
    print("\n[!] ALERTA: Se encontraron dependencias FALTANTES:\n")
    for missing, required_by in missing_deps.items():
        print(f" ❌ Dependencia faltante: '{missing}'")
        print(f"    └─ Requerida por: {', '.join(required_by)}\n")
else:
    print("\n[✔] ¡Todo en orden! No hay dependencias huérfanas.")
