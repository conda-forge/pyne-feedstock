#!/bin/sh
# setup env for tests
cd tests
export PATH="${PREFIX}/bin:${PATH}"

# It takes too long to download data files for CI
rm -f test_endf.py xs/test_data_source.py test_fortran.py test_data_nofile.py \
      test_materials_library.py

# run tests
test -f ${PREFIX}/lib/libpyne*
test -f ${PREFIX}/include/pyne/pyne.h
test -f ${PREFIX}/lib/python*/site-packages/pyne/nuc_data.h5
${PYTHON} -c "from pyne.pyne_config import pyne_conf; print(pyne_conf.NUC_DATA_PATH)"
./ci-run-tests.sh python3
