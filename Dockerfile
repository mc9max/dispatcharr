# syntax=docker/dockerfile:1
# =============================================================================
# Railway Template: Dispatcharr  (v1)
# Upstream: https://github.com/Dispatcharr/Dispatcharr  (AGPL-3.0, Django)
# Image:    ghcr.io/dispatcharr/dispatcharr@sha256:b7d695c5cc98b9abd64c74a94539c1ebffc23d965021613c820c67e25dea41a3
#           (pinned 2026-10-12 — upstream tags images by commit SHA, so the
#           digest is the pin; corresponds to upstream latest at v0.32.0+)
# =============================================================================
# Why this wrapper:
#   * Upstream already runs as root, which matches Railway's root-owned
#     persistent volume mounts — no USER change needed.
#   * All-in-one mode (DISPATCHARR_ENV=aio): Django + Postgres + Redis +
#     Celery workers + nginx in ONE container. A single-service template;
#     everything persists under /data (Postgres cluster, M3U/EPG files,
#     logos, cache, backups, recordings).
#   * Port 9191 is nginx (baked in). Railway's reverse proxy and external
#     healthcheck both target the EXPOSEd port.
#   * No in-container HEALTHCHECK: the base image ships no curl/wget, so
#     Railway's external healthcheck (healthcheckPath="/" in railway.json)
#     is the one that runs.
FROM ghcr.io/dispatcharr/dispatcharr@sha256:b7d695c5cc98b9abd64c74a94539c1ebffc23d965021613c820c67e25dea41a3

# All-in-one: web + workers + embedded postgres/redis in a single container.
ENV DISPATCHARR_ENV="aio" \
    REDIS_HOST="localhost" \
    CELERY_BROKER_URL="redis://localhost:6379/0" \
    DISPATCHARR_LOG_LEVEL="info" \
    DISPATCHARR_PORT="9191"

EXPOSE 9191

LABEL org.opencontainers.image.source="https://github.com/mc9max/dispatcharr"
LABEL org.opencontainers.image.description="Dispatcharr Railway template"
