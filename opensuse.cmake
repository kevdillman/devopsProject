# openSUSE packaging

if(NOT DISTRO MATCHES "openSUSE Leap")
    return()
endif()

# Separate packages for each component
set(CPACK_RPM_COMPONENT_INSTALL ON)

# RPM component package names
set(CPACK_RPM_CLIENT_PACKAGE_NAME "${CPACK_PACKAGE_NAME}")

# Distribution version
cmake_host_system_information(RESULT DISTRO_VERSION_ID QUERY DISTRIB_VERSION_ID)
cmake_host_system_information(RESULT DISTRO_ID QUERY DISTRIB_ID)
set(RPM_VERSION "${DISTRO_ID}${DISTRO_VERSION_ID}")

# Convert from processor type to Architecture
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
    set(DECOMPRESSOR_SYSTEM_ARCHITECTURE "aarch64")
else()
    set(DECOMPRESSOR_SYSTEM_ARCHITECTURE "x86_64")
endif()

# RPM release, not part of major-minor-patch
set(CPACK_RPM_PACKAGE_RELEASE 1)

# RPM component file names
set(CPACK_RPM_FILE_NAME "${CPACK_RPM_CLIENT_PACKAGE_NAME}-${PROJECT_VERSION}-${CPACK_RPM_PACKAGE_RELEASE}.${RPM_VERSION}.${DECOMPRESSOR_SYSTEM_ARCHITECTURE}.rpm")
