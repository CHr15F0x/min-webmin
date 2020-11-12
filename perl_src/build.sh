#!/usr/bin/env bash

set -e

PERL_SRC="perl-5.32.0"
PERL_INSTALL_DIR="/writable/user-data/protogw-all/perl"
MORE_MODULES=( "Socket" "Net::SSLeay" )

rm -rf ${PERL_INSTALL_DIR}
mkdir -p ${PERL_INSTALL_DIR}

tar xzf ${PERL_SRC}.tar.gz

cd ${PERL_SRC}

sh Configure -de "-Dprefix='${PERL_INSTALL_DIR}'"
make
#### make test
make install

cd ..

for i in ${MORE_MODULES[@]}; do
    ${PERL_INSTALL_DIR}/bin/perl -MCPAN -e "install ${i}"
done

rm -rf ${PERL_INSTALL_DIR}/man

mv ${PERL_INSTALL_DIR} ${PWD}

tar czf perl.tar.gz perl

echo "Done!"
