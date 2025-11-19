FROM satijalab/seurat:5.0.0

RUN apt-get update && apt-get install -y \
    curl \
    software-properties-common \
    dirmngr \
    gpg \
    curl \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    make \
    cmake \
    gfortran \
    libxt-dev \
    liblapack-dev \
    libblas-dev \
    sudo \
    wget \
    nano \
    pandoc \
    git

RUN rm -rf /var/lib/apt/lists/*

# Install JupyterLab
RUN apt-get update && apt-get install -y \
    python3-pip python3-dev curl libzmq3-dev

RUN python3 -m pip install --no-cache-dir \
    "jupyterhub==4.*" \
    "jupyter-server==2.*" \
    "jupyterlab==4.*"

# Utente non-root
RUN useradd -m -u 1000 -s /bin/bash jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME

ENV PATH="/opt/venv/bin:/usr/local/bin:${PATH}"

ENV JUPYTERHUB_SINGLEUSER_APP=jupyter_server.serverapp.ServerApp

USER jovyan

CMD ["python3", "-m", "jupyterhub.singleuser"]
