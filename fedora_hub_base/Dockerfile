FROM fedora:35

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
    vim
