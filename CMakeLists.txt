# Build for decompressor program

cmake_minimum_required(VERSION 3.28 FATAL_ERROR)

project(decompressor)

# decompressor
add_executable(decompressor)
target_sources(decompressor PRIVATE decompressor.cpp)
add_compile_options(decompressor PRIVATE -Wall -O3)
target_compile_features(decompressor PRIVATE cxx_std_17)

# libarchive
find_package(LibArchive REQUIRED)
target_link_libraries(decompressor PRIVATE LibArchive::LibArchive)

# run
add_custom_target(run
    COMMENT "decompressor"
    COMMAND $<TARGET_FILE:decompressor> <${CMAKE_CURRENT_SOURCE_DIR}/demo.zip
    DEPENDS decompressor
    USES_TERMINAL
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

# install
install (PROGRAMS $<TARGET_FILE:decompressor> TYPE BIN)

# check - use diff to check output
find_program(DIFF diff)
find_package(Git QUIET)
if (NOT DIFF STREQUAL "DIFF-NOTFOUND")
   message(STATUS "Check output uses diff: ${Diff}")
add_custom_target(check COMMAND $<TARGET_FILE:decompressor> <${CMAKE_CURRENT_SOURCE_DIR}/demo.zip | ${DIFF} ${CMAKE_SOURCE_DIR}/decompressor.cpp -)
elseif(GIT_FOUND)
    message(STATUS "Check output uses git diff: ${GIT}")
    add_custom_target(check
    COMMAND $<TARGET_FILE:decompressor> <${CMAKE_SOURCE_DIR}/demo.zip | ${GIT_EXECUTABLE} diff --no-index
    ${CMAKE_SOURCE_DIR}/decompressor.cpp -
    )
else()
    message(STATUS "Check output is not implemented due to missing diff utilities")
endif()
