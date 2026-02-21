cmake_minimum_required(VERSION 3.10)

project(main)

set(odr_name odr_test)
add_executable(${odr_name} main.cpp)

include(ExternalProject)
ExternalProject_Add(
    shared_demo
    PREFIX          shared
    SOURCE_DIR      ${CMAKE_CURRENT_SOURCE_DIR}/shared
    CMAKE_ARGS      -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
                    -DANDROID_ABI=${ANDROID_ABI}
                    -DANDROID_PLATFORM=${ANDROID_PLATFORM}
                    -DANDROID_STL=c++_shared
    BUILD_COMMAND   ${MAKE} ${MAKEFLAGS}
    INSTALL_COMMAND ""
)
target_link_libraries(${odr_name} PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/shared/src/shared_demo-build/libodr_shared.so)
# target_link_options(${odr_name} PRIVATE -Wl,--exclude-libs,libc++_static.a) # -Wl,--exclude-libs,ALL
add_dependencies(${odr_name} shared_demo)
