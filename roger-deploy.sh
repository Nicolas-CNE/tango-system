#!/bin/bash
set -e

# Definir directorio destino
TANGO="${1:-/mnt/tango}"

echo "==> Desplegando Tango Linux RootFS en: $TANGO"

# 1. Crear jerarquía básica FHS
echo "==> Creando estructura de directorios FHS..."
mkdir -p "$TANGO"/{bin,boot,dev,etc,home,lib,lib64,media,mnt,opt,proc,root,run,sbin,srv,sys,tmp,usr,var}
mkdir -p "$TANGO"/usr/{bin,include,lib,local,sbin,share,src}
mkdir -p "$TANGO"/var/{cache,lib,local,lock,log,opt,run,spool,tmp}
chmod 1777 "$TANGO"/tmp "$TANGO"/var/tmp

# 2. Sincronizar índice global
echo "==> Sincronizando índice de Roger..."
roger sync

# 3. Lista de paquetes base incluyendo linux-firmware para la ISO
PACKAGES="base bash coreutils gcc glibc linux linux-firmware util-linux zstd yyjson"

# 4. Desplegar directo sobre el directorio $TANGO
echo "==> Desempaquetando base en $TANGO..."
for pkg in $PACKAGES; do
    echo " -> Procesando $pkg..."
    # Hacemos cd a $TANGO para que la extracción de Roger impacte dentro del RootFS
    (cd "$TANGO" && roger install "$pkg")
done

echo "==> ¡RootFS creado y poblado exitosamente en $TANGO!"
