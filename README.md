# Synapse

Docker compose and configuration for Synapse.

### Setting up

Generate config files with
`docker run -it --rm --env SYNAPSE_CONFIG_DIR=/config --env SYNAPSE_SERVER_NAME=queerreferat.ac --env SYNAPSE_REPORT_STATS=no -v synapse_data:/data -v ./config:/config  matrixdotorg/synapse generate`

Then, fill `.env` with

- `PGSQL_PASSWORD`
- `AUTHENTIK_CLIENT_ID`
- `AUTHENTIK_CLIENT_SECRET`
- `SYNAPSE_FORM_SECRET`
- `SYNAPSE_MACAROON_KEY`
- `SYNAPSE_REG_SHARED_SECRET`

and run `sh gen-config.sh >config.homeserver.yml`
(which is basically just a template substitution).
The new file should be identical to the old one, except that it

- disables federation
- adds Authentik as SSO login
- tells Synapse that it is reachable under `matrix.queerreferat.ac`
