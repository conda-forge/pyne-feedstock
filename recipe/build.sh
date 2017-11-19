#!/usr/bin/env bash
set -e

if [ "$(uname)" == "Darwin" ]; then
  skiprpath="-DCMAKE_SKIP_RPATH=TRUE"
  export CPU_COUNT=1
  cflags="${CMAKE_C_FLAGS} -v -Wpedantic -Wall -Wextra"
else
  skiprpath=""
  cflags="${CMAKE_C_FLAGS}"
fi
export FC=gfortran

# Install PyNE
export VERBOSE=1
${PYTHON} setup.py install \
  --build-type="Release" \
  --prefix="${PREFIX}" \
  --hdf5="${PREFIX}" \
  --moab="${PREFIX}" \
  -DMOAB_INCLUDE_DIR="${PREFIX}/include" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}" \
  -DCMAKE_C_FLAGS="${cflags}" \
  ${skiprpath} \
  --clean \
  -j "${CPU_COUNT}"

# Create data library
cd build
if [ "$(uname)" == "Darwin" ]; then
  export DYLD_FALLBACK_LIBRARY_PATH="${DYLD_FALLBACK_LIBRARY_PATH}:${PREFIX}/lib"
else
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${PREFIX}/lib"
fi
${PYTHON} ${PREFIX}/bin/nuc_data_make