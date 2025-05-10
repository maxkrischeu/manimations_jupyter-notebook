# 1. Pull in your pre-built notebook environment
FROM maxkrischeu/my_uv_notebooks:latest

# 2. Switch to the non-root user (if your image defaults to root)
#    so that file permissions line up with Binder's mount
USER jovyan

# 3. Binder will mount your repo here
WORKDIR /home/jovyan/work

# 4. Tell Docker (and Binder) which port Jupyter will listen on
EXPOSE 8888

# 5. Default command: launch JupyterLab (or Notebook) for Binder
CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--NotebookApp.token=''", \
     "--NotebookApp.password=''", \
     "--allow-root"]