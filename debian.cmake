# Debian packaging

if(NOT DISTRO MATCHES "Ubuntu")
    return()
endif()

# Separate packages for each component
set(CPACK_DEB_COMPONENT_INSTALL ON)
