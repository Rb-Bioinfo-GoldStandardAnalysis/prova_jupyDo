FROM ghcr.io/maiolino-au/scrnaseq_tutorial

# 3. Create the standard 'jovyan' user
# This is crucial for security and volume permission handling
RUN useradd -m jovyan
ENV HOME=/home/jovyan
WORKDIR $HOME
USER jovyan

# 4. Set the default startup command
# This is the command JupyDo expects to launch the server.
CMD ["jupyterhub-singleuser", "--allow-root"]
