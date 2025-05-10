######################################################################
# Binder-ready Dockerfile — just enough glue to run your own image
######################################################################

# ──────────────────────────────────────────────
# 1) Your fully-featured base image
FROM maxkrischeu/my_uv_notebooks:latest

# ──────────────────────────────────────────────
# 2) Add Binder’s runtime bits (as root)
USER root

#   • notebook ≥ 7 and jupyterhub ≥ 4 pull in
#     - jupyterhub-singleuser  (Binder launches this)
#     - jupyter_server         (Notebook/Lab back end)
RUN pip install --no-cache-dir \
      "notebook>=7" \
      "jupyterhub>=4"

# ──────────────────────────────────────────────
# 3) Drop back to the unprivileged user that
#    already exists in the upstream image.
#    Replace “jovyan” if your image uses another
#    default user (e.g. “manimuser”).
USER jovyan

# ──────────────────────────────────────────────
# 4) (Optional but tidy) Tell humans & Docker
#    which port the server will bind to.
EXPOSE 8888

# ──────────────────────────────────────────────
# 5) Nothing else!  Repo2docker/Binder will add
#    its own wrapper layer that
#      • sets the ENTRYPOINT
#      • calls `jupyterhub-singleuser`
#      • mounts your repo at /home/jovyan/work
######################################################################