# Dispatcharr

Your ultimate IPTV & stream management companion. Organize channels, build custom M3U playlists, manage EPG guide data, and restream to your players — through one web dashboard. Point it at your own legal stream sources and let it handle the rest.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/deploy/dispatcharr?utm_campaign=dispatcharr)

## Deploy and Host

One click. Railway provisions a single service with a 5 GB `/data` volume and starts the all-in-one container. Nothing to configure — open the public URL and create your admin account on the first-run setup page.

- **Runtime** — Python/Django + nginx, single container (all-in-one mode).
- **Memory** — give it room: the all-in-one runs Django, Postgres, Redis, and Celery workers in one container. 2 GB+ recommended.
- **Port** — 9191 (baked into the Docker wrapper).
- **Persistence** — everything lives on the `/data` volume: the Postgres cluster (`/data/db`), M3U/EPG sources, logos, cache, backups, and recordings. Survives redeploys and restarts.
- **Public URL** — auto-assigned by Railway on deploy.

## Why Deploy

- **Sticky by design.** Once your channels, playlists, and guide data live in one place, the dashboard becomes the daily driver for your whole TV setup.
- **Always-on workers.** EPG refreshes, stream health checks, and recordings run on Celery workers around the clock — the kind of sustained usage Railway is built for.
- **No database to manage.** Postgres and Redis are embedded in the all-in-one container; the template wires nothing external.
- **XC API compatible.** Works as an Xtream-Codes-compatible backend for TiviMate, IPTV Smarters, and similar players.

## Common Use Cases

- **Personal stream hub** — aggregate your own M3U playlists and EPG sources into one clean guide.
- **Custom live-TV channels** — build curated channel lists per room, per device, per family member.
- **DVR** — schedule recordings from your sources to the `/data/recordings` volume.
- **Player backend** — serve TiviMate/IPTV Smarters via the built-in XC-compatible API (`player_api.php`, `get.php`, `xmltv.php`).
- **Stream restreaming** — proxy and restream with per-user access control.

### Deployment Dependencies

- **Railway Hobby or above** — the all-in-one container runs several processes; 2 GB RAM is the comfortable minimum.
- **5 GB volume** included for the database, guide cache, and recordings — resize up in the Railway dashboard if you record a lot.

## First-run setup

Open your Railway public URL. The setup page creates the admin account. First-time setup is limited to local/private networks by default — Railway's proxy presents a private peer IP, so this normally just works. If the page blocks you, it shows the IP Dispatcharr sees: paste that IP into the `DISPATCHARR_SETUP_ALLOWED_IP` template variable, redeploy, create the admin, then clear the variable.

## Troubleshooting

- **Container takes a few minutes on first boot** — Postgres initializes, Django migrates, and static files collect. The healthcheck timeout is 300s for this reason.
- **Setup page says my IP is not allowed** — see First-run setup above.
- **Streams stutter** — bump the service memory in Railway; transcoding/proxying is CPU-hungry by nature.
- **Data vanished after a redeploy** — the `/data` volume must stay attached to the service; check the Volumes tab.

## License

Upstream [Dispatcharr](https://github.com/Dispatcharr/Dispatcharr) is AGPL-3.0 licensed. This template's wrapper Dockerfile and config are provided as-is. Use only with stream sources you have the rights to.
