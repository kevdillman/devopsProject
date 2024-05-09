# Build for decompressor program

cmake_minimum_required(VERSION 3.28 FATAL_ERROR)

project(decompressor)

# decompressor
add_executable(decompressor)
target_sources(decompressor PRIVATE decompressor.cpp)
add_compile_options(decompressor PRIVATE -Wall -O3)
target_compile_features(decompressor PRIVATE cxx_std_17)

# libarchive
# Homebrew ships libarchive keg only, include dirs have to be set manually
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    execute_process(
        COMMAND brew --prefix libarchive
        OUTPUT_VARIABLE LIBARCHIVE_PREFIX
        OUTPUT_STRIP_TRAILING_WHITESPACE
        COMMAND_ERROR_IS_FATAL ANY
    )
    set(LibArchive_INCLUDE_DIR "${LIBARCHIVE_PREFIX}/include")
endif()

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
install (TARGETS decompressor COMPONENT CLIENT)

# packaging
include(CPackComponent)
cpack_add_component(CLIENT
                    DISPLAY_NAME "decompressor"
                    DESCRIPTION "Decompresses a single file or compressed directory"
                    REQUIRED
                    INSTALL_TYPES CLIENT)

# configure packaging for debian product
set(CPACK_DEB_COMPONENT_INSTALL ON)

# general package information
set(CPACK_PACKAGE_NAME "decompressor")
set(CPACK_PACKAGE_CONTACT "Kevin Dillman")

# strip generated package to reduce size
set(CPACK_STRIP_FILES ON)

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

# testing
include(CTest)
add_subdirectory(testsuite)

# leave after all cpack configuration
include(CPack)
