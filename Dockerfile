# binder/Dockerfile
##############################################################################
# 1. Start from a Jupyter image that already ships 'start.sh' & friends
##############################################################################
FROM docker.io/jupyter/minimal-notebook:python-3.12   # ↙ gives us NB_UID, start.sh …

##############################################################################
# 2. Become root (repo2docker resets us to jovyan later)
##############################################################################
USER root

# -- 2a. Manim’s native libraries -------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg \
        libcairo2-dev \
        libpango1.0-dev \
        texlive-latex-extra \
        texlive-fonts-extra \
    && rm -rf /var/lib/apt/lists/*

# -- 2b. Install uv ----------------------------------------------------------
# official one-liner ➜ downloads a tiny static binary to /usr/local/bin/uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh    [oai_citation:1‡Astral Docs](https://docs.astral.sh/uv/getting-started/installation/?utm_source=chatgpt.com)
ENV UV_SYSTEM_PYTHON=1                # install into the *system* interpreter

# -- 2c. Use uv to install Python deps --------------------------------------
# put heavy network traffic behind a build-cache so rebuilds stay fast
RUN --mount=type=cache,target=/root/.cache/uv \
    uv pip install --system \
        manim                      \
        myst-parser myst-nb        \
        jupytext                   \
        ipympl matplotlib          \
        # … any other libraries you need

##############################################################################
# 3. Hand control back to the jovyan user expected by Binder images
##############################################################################
USER ${NB_UID}