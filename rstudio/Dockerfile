# Set registry
ARG REGISTRY=localhost

FROM ${REGISTRY}/fedora_hub_base

# Set versions
ARG R_VERSION=4.1.1
ARG RSTUDIO_VERSION=2022.02.1-461

# Set environment
ENV TZ=Europe/Amsterdam
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PATH=/opt/python/conda/bin:$PATH

# Download R and compile R from source
RUN curl https://cran.rstudio.com/src/base/R-${R_VERSION:0:1}/R-${R_VERSION}.tar.gz \
    -o /tmp/R-${R_VERSION}.tar.gz && \
    tar -xzvf /tmp/R-${R_VERSION}.tar.gz -C /tmp && \
    cd /tmp/R-${R_VERSION} && \
    ./configure \
    --prefix=/opt/R/${R_VERSION} \
    --enable-memory-profiling \
    --enable-R-shlib \
    --with-blas \
    --with-lapack && \
    make && \
    make install && \
    rm /tmp/R-${R_VERSION}.tar.gz

# Link R
RUN ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R && \
    ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript

# Download and install rstudio server
RUN curl https://download2.rstudio.org/server/rhel8/x86_64/rstudio-server-rhel-${RSTUDIO_VERSION}-x86_64.rpm \
    -o /tmp/rstudio-server.rpm && \
    yum install -y /tmp/rstudio-server.rpm && \
    rm /tmp/rstudio-server.rpm

# Make Python visible to RStudio
RUN echo 'options(rstudio.python.installationPath = "/opt/python/conda/bin")' \
    >> /etc/rstudio/Rprofile.site

# Expose standard port for rstudio-server
EXPOSE 8787

# Start rstudio-server
ENTRYPOINT mount /mnt/nfs/home && /usr/lib/rstudio-server/bin/rserver --server-daemonize 0
