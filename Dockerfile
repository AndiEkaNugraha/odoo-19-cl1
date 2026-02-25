FROM odoo:19.0

USER root

# Install dependencies + wkhtmltopdf recommended version
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    fontconfig \
    libxrender1 \
    libxext6 \
    libjpeg62-turbo \
    xfonts-75dpi \
    xfonts-base \
    && wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && apt install -y ./wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && rm wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install python packages
RUN pip install --no-cache-dir --break-system-packages \
    qifparse \
    "fsspec[s3]"

USER odoo