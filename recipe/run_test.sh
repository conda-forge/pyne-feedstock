#!/bin/sh
# setup env for tests
cd tests
export PATH="${PREFIX}/bin:${PATH}"

# run tests
test -f ${PREFIX}/lib/libpyne*
test -f ${PREFIX}/include/pyne/pyne.h
nosetests
