#!/bin/sh
# setup env for tests
cd tests
export PATH="${PREFIX}/bin:${PATH}"

# It takes too long to download data files for CI
rm -f test_endf.py xs/test_data_source.py

# run tests
test -f ${PREFIX}/lib/libpyne*
test -f ${PREFIX}/include/pyne/pyne.h
nosetests
