######################################################################
# Binder-ready Dockerfile
#  – keeps everything that is already in maxkrischeu/my_uv_notebooks
#  – installs the minimal “Binder glue”
######################################################################

# ─────────────────────────────────────────────────────────────
# 1) Your fully-featured base image
FROM maxkrischeu/my_uv_notebooks:latest

# ─────────────────────────────────────────────────────────────
# 2) Become root long enough to install the Binder bits
USER root

# NOTE:  notebook >= 7 pulls in jupyter_server
#        jupyterhub >= 4 brings in jupyterhub-singleuser
RUN pip install --no-cache-dir \
      "notebook>=7" \
      "jupyterlab>=4" \
      "jupyterhub>=4"

# ─────────────────────────────────────────────────────────────
# 3) Drop back to the non-root user that already exists
#    (adjust if your image uses a different one)
USER jovyan

# ─────────────────────────────────────────────────────────────
# 4) Expose the port that Jupyter will listen on (convention)
EXPOSE 8888

# ─────────────────────────────────────────────────────────────
# 5) Nothing else!  
#    repo2docker will inject its own ENTRYPOINT and run
#    `jupyterhub-singleuser --ip=0.0.0.0 --port=8888 …`
######################################################################