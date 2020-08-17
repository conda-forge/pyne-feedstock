#!/usr/bin/env bash
set -e

if [[ -n "$enable_moab" && "$enable_moab" != "nomoab" ]]; then
  export CONFIGURE_ARGS="--moab=${PREFIX} ${CONFIGURE_ARGS}"
fi

if [[ -n "$enable_dagmc" && "$enable_dagmc" != "nodagmc" ]]; then
  export CONFIGURE_ARGS="--dagmc=${PREFIX} ${CONFIGURE_ARGS}"
fi
# Install PyNE
export VERBOSE=1
${PYTHON} setup.py install \
  --build-type="Release" \
  --prefix="${PREFIX}" \
  --hdf5="${PREFIX}" \
  ${CONFIGURE_ARGS} \
  --clean \
  -j "${CPU_COUNT}"

# Create data library
cd build
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${PREFIX}/lib"
${PYTHON} ${PREFIX}/bin/nuc_data_make
