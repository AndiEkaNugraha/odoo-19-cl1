FROM odoo:19.0

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wkhtmltopdf \
        ca-certificates \
        wget \
        fontconfig \
        libxrender1 \
        libxext6 \
        xfonts-75dpi \
        xfonts-base \
    && pip install --no-cache-dir --break-system-packages qifparse \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install "fsspec[s3]"

USER odoo