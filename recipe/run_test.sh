#!/bin/sh
# setup env for tests
cd "${SRC_DIR}/tests"
export PATH="${PREFIX}/bin:${PATH}"

# run tests
test -f ${PREFIX}/lib/libpyne*
test -f ${PREFIX}/include/pyne/pyne.h
# exlcuding ENDF tests because CI no longer seems to be able to download the
# files.
nosetests -e="test_endf"
