# 1. Base image
FROM maxkrischeu/my_uv_notebooks:latest


# 4. Expose the port that Jupyter will use
EXPOSE 8888

# 5. Default command: launch Jupyter Notebook on all interfaces,
#    no browser, tokenless (so Binder can manage auth), as root if needed
CMD ["jupyter", "notebook", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--NotebookApp.token=''", \
     "--NotebookApp.password=''", \
     "--allow-root"]