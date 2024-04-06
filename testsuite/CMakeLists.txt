# @file CMakeLists.txt
#
# CMake file for decompressor test

# Assume that each .sh file is a separate test
file(GLOB TESTS "*.sh")
foreach(TEST ${TESTS})

    get_filename_component(TESTNAME "${TEST}" NAME_WLE)

    # Create a test for each script
    add_test(   NAME ${TESTNAME}
                COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/${TESTNAME}.sh
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )

endforeach()