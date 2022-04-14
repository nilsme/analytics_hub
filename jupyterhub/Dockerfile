# Set registry
ARG REGISTRY=localhost

# Select iamge
FROM ${REGISTRY}/fedora_hub_base

# Set environment
ENV TZ=Europe/Amsterdam
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PATH=/opt/python/conda/bin:$PATH

# Install Python + NodeJS with conda, Python packages and JupyterHub
RUN /opt/python/conda/bin/conda install --yes -c conda-forge \
      python \
      sqlalchemy \
      tornado \
      jinja2 \
      traitlets \
      requests \
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
    /opt/python/conda/bin/jupyter lab build

# Create a directory for config
RUN mkdir -p /srv/jupyterhub/

# Copy config
COPY ./jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

# Create admin group
RUN groupadd --gid 2000 jupyterhub-admins

# Expose standard port for jupyterhub
EXPOSE 8000

#CMD ["jupyterhub"]

ENTRYPOINT mount /mnt/nfs/home && jupyterhub
