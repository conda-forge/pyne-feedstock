mkdir build
cd build

cmake -G "NMake Makefiles JOM"              ^
    -DCMAKE_BUILD_TYPE=Release              ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DMOAB_INCLUDE_DIR="%LIBRARY_PREFIX%/include" ^
    ..

if errorlevel 1 exit 1

cmake --build . --target install

if errorlevel 1 exit 1