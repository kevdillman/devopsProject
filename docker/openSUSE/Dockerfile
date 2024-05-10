ARG TAG=15.5
FROM opensuse/leap:${TAG}

ENV TZ=US/Michigan

RUN zypper install -y \
        ccache \
        gcc-c++ \
        git \
        make \
        ninja \
        libxml2-devel \
        curl \
        tree \
        valgrind \
        zip \
        file \
        tar \
        libarchive-devel \
        rpm-build \
        gzip \
        && zypper clean

# Install cmake
ARG TARGETPLATFORM
RUN case "${TARGETPLATFORM}" in \
         "linux/amd64")  ARCHITECTURE="x86_64"   ;; \
         "linux/arm64")  ARCHITECTURE="aarch64"  ;; \
         *)  exit 1 ;; \
    esac; \
    curl --insecure -L "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-${ARCHITECTURE}.tar.gz" | tar xz --strip-components=1 -C /usr/local
