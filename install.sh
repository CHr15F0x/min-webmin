#/usr/bin/env bash

if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

WEBMIN_PACKAGE=${PWD}/webmin-1.960-minimal-authentic.tar.gz
WEBMIN_SRC=${PWD}/webmin-1.960-minimal-authentic
WEBMIN_UNINSTALL=${PWD}/uninstall-webmin.sh
SETUP_PRE=${PWD}/setup-pre.sh
INSTALL_DIR=/writable/webmin
MOD_DIR=${PWD}/mod
MODULES=( net.wbm mount.wbm proc.wbm )

${WEBMIN_UNINSTALL}

rm -rf ${WEBMIN_SRC}

tar -xzf ${WEBMIN_PACKAGE}

cp ${SETUP_PRE} ${WEBMIN_SRC}

cd ${WEBMIN_SRC}

${PWD}/setup.sh ${INSTALL_DIR}

cd ${WEBMIN_SRC}/..

rm -rf ${WEBMIN_SRC}

gunzip -f -k ${MOD_DIR}/*.gz

for i in ${MODULES[@]}; do
    perl ${INSTALL_DIR}/install-module.pl ${MOD_DIR}/${i} ${INSTALL_DIR}/etc
done

rm -f ${MOD_DIR}/*.wbm
