FROM ghcr.io/maiolino-au/scrnaseq_tutorial:v0.0.1

# (Optional but recommended) Add metadata
LABEL org.opencontainers.image.title="My JupyDo Tool"
LABEL org.opencontainers.image.description="Custom image with GEfetch2R ready for JupyDo"

# 2. Install the core Jupyter components
# Ensure your base image has 'pip' or 'pip3' available
RUN pip3 install --no-cache-dir \
    'jupyterhub-singleuser==4.*' \
    'jupyterlab==4.*' \
    'notebook'

# 3. Create the standard 'jovyan' user
# This is crucial for security and volume permission handling
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

# 4. Set the default startup command
# This is the command JupyDo expects to launch the server.
CMD ["jupyterhub-singleuser", "--allow-root"]
