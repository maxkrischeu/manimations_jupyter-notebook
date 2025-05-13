FROM docker.io/manimcommunity/manim:v0.19.0

# 1) Become root so we can install into the system Python
USER root

# 2) Install MyST Parser, MyST-NB & Jupytext (with the 'myst' extra)
RUN pip install mystmd

RUN pip install jupyterlab_myst

RUN pip install ipywidgets

# 3) Switch back to the manimuser that the base image expects
USER manimuser:manimuser

# 4) Copy in your notebooks/source
COPY --chown=manimuser:manimuser . /manim