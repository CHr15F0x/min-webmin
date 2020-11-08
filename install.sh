#/usr/bin/env bash

if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

WEBMIN_PACKAGE=${PWD}/webmin-1.960-minimal.tar.gz
WEBMIN_SRC=${PWD}/webmin-1.960
WEBMIN_UNINSTALL=${PWD}/uninstall-webmin.sh
SETUP_PRE=${PWD}/setup-pre.sh
INSTALL_DIR=/writable/webmin

${WEBMIN_UNINSTALL}

rm -rf ${WEBMIN_SRC}

tar -xzf ${WEBMIN_PACKAGE}

cp ${SETUP_PRE} ${WEBMIN_SRC}

cd ${WEBMIN_SRC}

${PWD}/setup.sh ${INSTALL_DIR}

cd ${WEBMIN_SRC}/..

# Clean src
rm -rf ${WEBMIN_SRC}
