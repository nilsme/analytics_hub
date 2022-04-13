# Set registry
ARG REGISTRY=localhost

FROM ${REGISTRY}/fedora_hub_base

# Set versions
ARG MINICONDA_VERSION

# Set environment
ENV TZ=Europe/Amsterdam
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PATH=/opt/python/conda/bin:$PATH

# Install Python + NodeJS with conda and Python-packages
RUN wget https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh \
      -O /tmp/miniconda.sh  && \
    bash /tmp/miniconda.sh -f -b -p /opt/python/conda && \
    /opt/python/conda/bin/conda install --yes -c conda-forge \
      python \
      sqlalchemy \
      tornado \
      jinja2 \
      traitlets \
      requests \
      pip \
      pycurl \
      nodejs \
      configurable-http-proxy \
      notebook \
      jupyterlab \
      jupyterlab-git \
      jupyterhub \
      conda-build \
      nb_conda_kernels \
      ipykernel \
      && \
    /opt/python/conda/bin/pip install --upgrade pip && \
    /opt/python/conda/bin/jupyter lab build && \
    rm /tmp/miniconda.sh

# Create a directory for config
RUN mkdir -p /srv/jupyterhub/

# Copy config
COPY ./jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

# Create admin group
RUN groupadd jupyterhub-admins

# Expose standard port for jupyterhub
EXPOSE 8000

CMD ["jupyterhub"]
