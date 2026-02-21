cmake_minimum_required(VERSION 3.10)

project(main)

set(odr_name odr_shared)
add_library(${odr_name} SHARED ../main.cpp)
target_compile_definitions(${odr_name} PRIVATE -DSHARED)