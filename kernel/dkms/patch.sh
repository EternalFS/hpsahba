#!/bin/bash
set -e

VERSION=${1:-5.4}

echo Patching for kernel ${VERSION}

wget https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/scsi/hpsa.h?h=linux-${VERSION}.y -O hpsa.h
wget https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/scsi/hpsa.c?h=linux-${VERSION}.y -O hpsa.c
wget https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/scsi/hpsa_cmd.h?h=linux-${VERSION}.y -O hpsa_cmd.h

for PATCH in `LANG=C ls ../${VERSION}`; do
    echo Applying ${PATCH}
    patch --no-backup-if-mismatch -Np3 < ../${VERSION}/${PATCH}
done
