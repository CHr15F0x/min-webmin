#/usr/bin/env bash

WEBMIN="min-webmin"

mkdir -p ${WEBMIN}
cp -R ${PWD}/perl.tar.gz ${WEBMIN}
cp -R ${PWD}/install.sh ${WEBMIN}
cp -R ${PWD}/mod ${WEBMIN}
cp -R ${PWD}/setup-pre.sh ${WEBMIN}
cp -R ${PWD}/uninstall.sh ${WEBMIN}
cp -R ${PWD}/webmin-1.960-minimal-authentic.tar.gz ${WEBMIN}
cp -R ${PWD}/webmin.service ${WEBMIN}

tar czf ${WEBMIN}.tar.gz ${WEBMIN}

rm -rf ${WEBMIN}

echo "Done!"

