# Fedora packaging

if(NOT DISTRO MATCHES "Fedora")
    return()
endif()

# Separate packages for each component
set(CPACK_RPM_COMPONENT_INSTALL ON)
