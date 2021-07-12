#/usr/bin/env bash

if [ $(id -u) -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

INSTALL_DIR=/writable/user-data/protogw-all/webmin

if grep -q -P "model name\s+:\s+Intel\(R\) Core" /proc/cpuinfo || grep -q -P "model name\s+:\s+AMD Ryzen" /proc/cpuinfo; then
    SYSTEMD_DIR=/etc/systemd/system
else
    SYSTEMD_DIR=/writable/system-data/etc/systemd/system
fi

echo "Uninstalling previous instance of webmin..."

pkill -9 miniserv.pl
systemctl stop webmin.service

rm -f ${SYSTEMD_DIR}/webmin.service

systemctl daemon-reload

#### ${INSTALL_DIR}/etc/stop
(cd ${INSTALL_DIR}/src ; WEBMIN_CONFIG=${INSTALL_DIR}/etc WEBMIN_VAR=${INSTALL_DIR}/log LANG= "${INSTALL_DIR}/src/run-uninstalls.pl")
rm -rf ${INSTALL_DIR}

echo "
+----------------------------------------------+
| Finished uninstalling webmin.                |
+----------------------------------------------+
"
