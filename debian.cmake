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
