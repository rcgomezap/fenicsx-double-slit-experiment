FROM dolfinx/dolfinx:v0.9.0

# Install ipykernel if not already there
RUN pip install ipykernel matplotlib

# Add the complex mode activation to bashrc
RUN echo "source /usr/local/bin/dolfinx-complex-mode" >> /root/.bashrc