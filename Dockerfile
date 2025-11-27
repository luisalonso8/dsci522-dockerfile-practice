# trigger build
# Use the Jupyter minimal-notebook image required by the assignment
FROM --platform=linux/amd64 quay.io/jupyter/minimal-notebook:afe30f0c9ad8

USER root

# Copy environment and lock files into the container
COPY environment.yml /tmp/environment.yml
COPY conda-lock.yml /tmp/conda-lock.yml

# Install conda-lock (needed to create environment from lockfile)
RUN conda install -n base -c conda-forge conda-lock -y

# Create the environment from the Linux lockfile
RUN conda-lock install --name dsci522-env /tmp/conda-lock.yml

# Make the environment active by default
ENV CONDA_DEFAULT_ENV=dsci522-env
ENV PATH="/opt/conda/envs/dsci522-env/bin:$PATH"

# Switch back to notebook user
USER ${NB_UID}

# Start JupyterLab (minimal-notebook provides this script)
CMD ["start-notebook.sh"]
