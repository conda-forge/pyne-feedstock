#!/usr/bin/env bash
set -e

if [[ -n "$enable_moab" && "$enable_moab" != "nomoab" ]]; then
  export CONFIGURE_ARGS="--moab=${PREFIX} ${CONFIGURE_ARGS}"
fi

# pyne ships pre-assembled CRAM/decay sources only for x86_64
# (cram-linux-gnu.s and cram-apple-clang.s are both x86_64). On
# aarch64/arm64 the assembler rejects them, so disable fast-compile
# and fall back to the portable C/C++ sources via setup.py --slow.
case "${target_platform}" in
  linux-aarch64|osx-arm64)
    export CONFIGURE_ARGS="--slow ${CONFIGURE_ARGS}"
    ;;
esac

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
${PYTHON} ${PREFIX}/bin/nuc_data_make
