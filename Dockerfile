# Local development image: Quarto + Python toolchain for rendering the site.
FROM python:3.12-slim

# Pinned for reproducible local builds. Bump to match CI when upgrading Quarto.
ARG QUARTO_VERSION=1.6.40
# Provided automatically by BuildKit ("amd64" or "arm64") -- matches Quarto's asset names.
ARG TARGETARCH

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    && curl -fsSL -o /tmp/quarto.deb \
        "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${TARGETARCH}.deb" \
    && apt-get install -y --no-install-recommends /tmp/quarto.deb \
    && rm -f /tmp/quarto.deb \
    && apt-get purge -y curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /site

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 4444

# Clear any stale preview lock (from an unclean prior exit) before starting.
CMD ["sh", "-c", "rm -rf .quarto/preview && exec quarto preview --host 0.0.0.0 --port 4444 --no-browser"]
