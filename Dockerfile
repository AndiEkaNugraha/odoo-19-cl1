FROM odoo:19.0

USER root

ENV DEBIAN_FRONTEND=noninteractive

# Add Odoo official apt repository
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    gnupg \
    wget \
    && wget -qO - https://nightly.odoo.com/odoo.key | gpg --dearmor -o /usr/share/keyrings/odoo-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/odoo-archive-keyring.gpg] https://nightly.odoo.com/19.0/nightly/deb/ ./" \
        > /etc/apt/sources.list.d/odoo.list

# Install wkhtmltopdf + fonts (Odoo-compatible)
RUN apt-get update && apt-get install -y --no-install-recommends \
    wkhtmltopdf \
    fontconfig \
    fonts-dejavu \
    fonts-liberation \
    xfonts-75dpi \
    xfonts-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Python deps
RUN pip install --no-cache-dir --break-system-packages \
    qifparse \
    "fsspec[s3]"

USER odoo