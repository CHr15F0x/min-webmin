#/usr/bin/env bash

WEBMIN="min-webmin"

mkdir -p ${WEBMIN}
cp -R ${PWD}/* ${WEBMIN}
rm -f ${WEBMIN}/${0}
tar czf ${WEBMIN}.tar.gz ${WEBMIN}

rm -rf ${WEBMIN}
