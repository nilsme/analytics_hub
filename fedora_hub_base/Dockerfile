FROM fedora:35

# Set nfs server
ARG NFS_SERVER=hub_docker_nfs

# Set versions
ARG MINICONDA_VERSION

# Set environment
ENV TZ=Europe/Amsterdam
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PATH=/opt/python/conda/bin:$PATH

# Install system packages
RUN yum -y update && \
    yum -y install \
    # Install git
    git \
    # Install ldap client packages
    openldap-clients \
    # Install compilers
    gcc \
    gcc-c++ \
    gcc-gfortran \
    java-latest-openjdk \
    # Install system packages for compilers and R \
    readline-devel \
    libX11-devel \
    libICE-devel \
    libXt-devel \
    zlib-devel \
    cairo \
    cairo-devel \
    libcurl-devel \
    libsodium-devel \
    gsl-devel \
    jq \
    tesseract \
    libpng-devel \
    libtiff-devel \
    unixODBC-devel \
    sqlite-devel \
    postgresql-odbc \
    openssl-devel \
    # Install latex
    texlive \
    # Install auxiliary system packages
    wget \
    zip \
    unzip \
    vim \
    nfs-utils

# Install miniconda3 for Python support
RUN wget https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh \
    -O /tmp/miniconda.sh  && \
    bash /tmp/miniconda.sh -f -b -p /opt/python/conda && \
    /opt/python/conda/bin/conda update -n base -c conda-forge conda && \
    /opt/python/conda/bin/pip install --upgrade pip && \
    rm /tmp/miniconda.sh

# Create folder for nfs mount
RUN mkdir -p /mnt/nfs/home/

# Set new default /home for new users
RUN sed -i 's/HOME=\/home/HOME=\/mnt\/nfs\/home/g' /etc/default/useradd

# Mount nfs server on new home directory on reboot
RUN echo "${NFS_SERVER}:/ /mnt/nfs/home/  nfs      defaults    0       0" >> /etc/fstab
