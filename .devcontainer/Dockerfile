# Dolfinx image
FROM dolfinx/dolfinx:v0.9.0

# Install additional required python packages
RUN pip install ipykernel matplotlib nbconvert notebook

# Add the complex mode activation to bashrc
RUN echo "source /usr/local/bin/dolfinx-complex-mode" >> /root/.bashrc