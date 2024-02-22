# Build for decompressor program

cmake_minimum_required(VERSION 3.28 FATAL_ERROR)

project(decompressor)

# decompressor
add_executable(decompressor)
target_sources(decompressor PRIVATE decompressor.cpp)
target_compile_features(decompressor PRIVATE cxx_std_17)

# libarchive
find_package(LibArchive REQUIRED)
target_link_libraries(decompressor PRIVATE LibArchive::LibArchive)
