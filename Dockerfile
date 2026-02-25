FROM odoo:19.0

USER root

# Environment best practice
ENV DEBIAN_FRONTEND=noninteractive \
    WKHTMLTOPDF_VERSION=0.12.6.1-3

# Install system dependencies + wkhtmltopdf
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    fontconfig \
    libxrender1 \
    libxext6 \
    libjpeg-turbo8 \
    xfonts-75dpi \
    xfonts-base \
    fonts-dejavu \
    fonts-liberation \
    && wget -q https://github.com/wkhtmltopdf/packaging/releases/download/${WKHTMLTOPDF_VERSION}/wkhtmltox_${WKHTMLTOPDF_VERSION}.bookworm_amd64.deb \
    && apt-get install -y ./wkhtmltox_${WKHTMLTOPDF_VERSION}.bookworm_amd64.deb \
    && rm wkhtmltox_${WKHTMLTOPDF_VERSION}.bookworm_amd64.deb \
    && apt-get purge -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Python dependencies (explicit, deterministic)
RUN pip install --no-cache-dir --break-system-packages \
    qifparse \
    "fsspec[s3]"

# Back to non-root user
USER odoo