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

BASE_DIR=/writable/user-data/protogw-all
WEBMIN_DIR=${BASE_DIR}/webmin
CONFIG_DIR=${WEBMIN_DIR}/etc
INSTALL_DIR=${WEBMIN_DIR}/src

if grep -q -P "model name\s+:\s+Intel\(R\) Core\(TM\) i7-7500U" /proc/cpuinfo; then
    SYSTEMD_DIR=/etc/systemd/system
else
    SYSTEMD_DIR=/writable/system-data/etc/systemd/system
fi

echo "Installing webmin..."

mkdir -p ${WEBMIN_DIR}

tar xzf ${PWD}/perl.tar.gz
mv perl ${BASE_DIR}

export PERL5LIB=${BASE_DIR}/perl/lib
export PERLLIB=${PERL5LIB}

${WEBMIN_UNINSTALL}

rm -rf ${WEBMIN_SRC}

tar xzf ${WEBMIN_PACKAGE}

cp ${SETUP_PRE} ${WEBMIN_SRC}

cd ${WEBMIN_SRC}

mkdir -p ${INSTALL_DIR}

${PWD}/setup.sh ${INSTALL_DIR}

cd ${WEBMIN_SRC}/..

rm -rf ${WEBMIN_SRC}

gunzip -f -k ${MOD_DIR}/*.gz

MODULES=`ls -1 ${MOD_DIR}/*.wbm`
for i in ${MODULES}; do
    ${BASE_DIR}/perl/bin/perl ${INSTALL_DIR}/install-module.pl ${i} ${CONFIG_DIR}
done

rm -f ${MOD_DIR}/*.wbm

cp ${WEBMIN_UNINSTALL} ${WEBMIN_DIR}

cp ${PWD}/webmin.service ${SYSTEMD_DIR}
systemctl daemon-reload
systemctl enable webmin.service
systemctl start webmin.service

echo "
+----------------------------------------------+
| Finished installing webmin.                  |
+----------------------------------------------+
"
systemctl status --no-pager webmin.service
