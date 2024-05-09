# Fedora packaging

if(NOT DISTRO MATCHES "Fedora")
    return()
endif()

# Separate packages for each component
set(CPACK_RPM_COMPONENT_INSTALL ON)

# RPM component package names
set(CPACK_RPM_CLIENT_PACKAGE_NAME "${CPACK_PACKAGE_NAME}")

# Distribution version
cmake_host_system_information(RESULT DISTRO_VERSION_ID QUERY DISTRIB_VERSION_ID)
set(RPM_VERSION "fc${DISTRO_VERSION_ID}")

# Convert from processor type to Architecture
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
    set(SRCML_SYSTEM_ARCHITECTURE "aarch64")
else()
    set(SRCML_SYSTEM_ARCHITECTURE "x86_64")
endif()
