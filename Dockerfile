FROM satijalab/seurat:5.0.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common dirmngr gpg curl build-essential \
    libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev \
    libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libharfbuzz-dev \
    libfribidi-dev make cmake gfortran libxt-dev liblapack-dev libblas-dev \
    sudo wget zlib1g-dev libbz2-dev liblzma-dev libncurses5-dev pandoc git && \
    rm -rf /var/lib/apt/lists/* # Clean up apt cache

# (Optional but recommended) Add metadata
LABEL org.opencontainers.image.title="My JupyDo Tool"
LABEL org.opencontainers.image.description="Custom image with GEfetch2R ready for JupyDo"


# Install JupyterLab
RUN apt update && apt install -y python3 python3-pip python3-venv
# create a virtual environment in which JupyterLab can be installed
RUN python3 -m venv /opt/venv
# Activate virtual environment and install JupyterLab
RUN /opt/venv/bin/pip install --upgrade pip && /opt/venv/bin/pip install jupyterlab
# 2. Install the core Jupyter components
# Ensure your base image has 'pip' or 'pip3' available
RUN pip3 install --no-cache-dir \
    'jupyterhub==4.*' \
    'jupyterlab==4.*' \
    'notebook'

RUN R -e "install.packages('IRkernel')" \
    R -e "IRkernel::installspec(user = FALSE)"

# 3. Create the standard 'jovyan' user
# This is crucial for security and volume permission handling
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

# Set the virtual environment as the default Python path
# ENV PATH="/opt/venv/bin:$PATH"
ENV PATH="/usr/local/bin:/home/jovyan/.local/bin:${PATH}"

# 4. Set the default startup command
# This is the command JupyDo expects to launch the server.
CMD ["jupyterhub-singleuser", "--allow-root"]
