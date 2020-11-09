#/usr/bin/env bash

if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

WEBMIN_PACKAGE=${PWD}/webmin-1.960-minimal-authentic.tar.gz
WEBMIN_SRC=${PWD}/webmin-1.960-minimal-authentic
WEBMIN_UNINSTALL=${PWD}/uninstall.sh
SETUP_PRE=${PWD}/setup-pre.sh
MOD_DIR=${PWD}/mod
MODULES=( net.wbm mount.wbm proc.wbm )

DEST_DIR=/writable/user-data/webmin
CONFIG_DIR=${DEST_DIR}/etc
INSTALL_DIR=${DEST_DIR}/src

${WEBMIN_UNINSTALL}

rm -rf ${WEBMIN_SRC}

tar -xzf ${WEBMIN_PACKAGE}

cp ${SETUP_PRE} ${WEBMIN_SRC}

cd ${WEBMIN_SRC}

mkdir -p ${INSTALL_DIR}

${PWD}/setup.sh ${INSTALL_DIR}

cd ${WEBMIN_SRC}/..

rm -rf ${WEBMIN_SRC}

gunzip -f -k ${MOD_DIR}/*.gz

for i in ${MODULES[@]}; do
    perl ${INSTALL_DIR}/install-module.pl ${MOD_DIR}/${i} ${CONFIG_DIR}
done

rm -f ${MOD_DIR}/*.wbm

cp ${WEBMIN_UNINSTALL} ${DEST_DIR}
