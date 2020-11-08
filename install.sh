#/usr/bin/env bash

if [[ $(id -u) -ne 0 ]]; then
    echo "Please run as root"
    exit 1
fi

WEBMIN_PACKAGE=webmin-1.960-minimal.tar.gz
WEBMIN_SRC=${PWD}/webmin-1.960
SETUP_PRE=${PWD}/setup-pre.sh
INSTALL_DIR=/writable/webmin

rm -rf ${WEBMIN_SRC}
rm -rf ${INSTALL_DIR}

tar -xvzf ${WEBMIN_PACKAGE}

cp ${SETUP_PRE} ${WEBMIN_SRC}

cd ${WEBMIN_SRC}

${PWD}/setup.sh ${INSTALL_DIR}
