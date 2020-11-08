#/usr/bin/env bash

if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

INSTALL_DIR=/writable/webmin

# Clean prev install
${INSTALL_DIR}/etc/stop
(cd ${INSTALL_DIR} ; WEBMIN_CONFIG=${INSTALL_DIR}/etc WEBMIN_VAR=${INSTALL_DIR}/log LANG= "${INSTALL_DIR}/run-uninstalls.pl")
rm -rf ${INSTALL_DIR}
