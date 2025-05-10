# 1. Start from your prebuilt notebook image
FROM maxkrischeu/my_uv_notebooks:latest

# 2. Use the non-root jovyan user (matches Binder’s defaults)
USER jovyan

# 3. Binder mounts your Git repo here
WORKDIR /home/jovyan/work

# 4. Tell Docker (and Binder) that Jupyter will listen on 8888
EXPOSE 8888

# 5. **Drop** any inherited ENTRYPOINT so CMD runs by itself
ENTRYPOINT []

# 6. Launch JupyterLab (or swap to "notebook" if you prefer)
CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", "--port=8888", "--no-browser", \
     "--NotebookApp.token=''", "--NotebookApp.password=''", \
     "--allow-root"]