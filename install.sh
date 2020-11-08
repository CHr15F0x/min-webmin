#/usr/bin/env bash

WEBMIN_PACKAGE=webmin-1.960-minimal.tar.gz
WEBMIN_SRC=${PWD}/webmin-1.960
SETUP_PRE=${PWD}/setup-pre.sh

INSTALL_DIR=/writable/webmin

tar -xvzf ${WEBMIN_PACKAGE}

cp ${SETUP_PRE} ${WEBMIN_SRC}

cd ${WEBMIN_SRC}

setup.sh ${INSTALL_DIR}
