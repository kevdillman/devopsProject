# Debian packaging

if(NOT DISTRO MATCHES "Ubuntu")
    return()
endif()

# Separate packages for each component
set(CPACK_DEB_COMPONENT_INSTALL ON)

# Distribution version, e.g., ubuntu24.04
cmake_host_system_information(RESULT DISTRO_VERSION_ID QUERY DISTRIB_VERSION_ID)
cmake_host_system_information(RESULT DISTRO_ID QUERY DISTRIB_ID)
set(DEBIAN_VERSION "${DISTRO_ID}${DISTRO_VERSION_ID}")

# Convert from processor type to Architecture
if(CMAKE_SYSTEM_PROCESSOR EQUAL "aarch64")
    set(DECOMPRESSOR_SYSTEM_ARCHITECTURE "arm64")
else()
    set(DECOMPRESSOR_SYSTEM_ARCHITECTURE "amd64")
endif()

# Debian release, not part of major-minor-patch
set(CPACK_DEBIAN_PACKAGE_RELEASE 1)
