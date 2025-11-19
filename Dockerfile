FROM ghcr.io/maiolino-au/scrnaseq_tutorial:v0.0.1

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
