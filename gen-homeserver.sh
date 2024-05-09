set -o nounset
. ./.env
cat <<EOD
# Configuration file for Synapse.
#
# This is a YAML file: see [1] for a quick introduction. Note in particular
# that *indentation is important*: all the elements of a list or dictionary
# should have the same indentation.
#
# [1] https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html
#
# For more information on how to configure Synapse, including a complete accounting of
# each option, go to docs/usage/configuration/config_documentation.md or
# https://matrix-org.github.io/synapse/latest/usage/configuration/config_documentation.html
server_name: "queerreferat.ac"
public_baseurl: "https://matrix.queerreferat.ac/"
pid_file: /data/homeserver.pid
listeners:
  - port: 8008
    tls: false
    type: http
    x_forwarded: true
    resources:
      # disable federation for now
      - names: [client]
        compress: true
database:
  name: psycopg2
  args:
    user: synapse
    password: "$PGSQL_PASSWORD"
    database: synapse
    host: db
    # copied from example, no idea what values are appropriate
    cp_min: 5
    cp_max: 10
log_config: "/config/queerreferat.ac.log.config"
media_store_path: /data/media_store
registration_shared_secret: "$SYNAPSE_REG_SHARED_SECRET"
# evaluate whether to flip this
report_stats: false
macaroon_secret_key: "$SYNAPSE_MACAROON_KEY"
form_secret: "$SYNAPSE_FORM_SECRET"
signing_key_path: "/config/queerreferat.ac.signing.key"
trusted_key_servers:
  - server_name: "matrix.org"

oidc_providers:
  - idp_id: authentik
    idp_name: Authentik
    discover: true
    issuer: "https://sso.queerreferat.ac/application/o/synapse"
    client_id: "$AUTHENTIK_CLIENT_ID"
    client_secret: "$AUTHENTIK_CLIENT_SECRET"
    scopes:
      - openid
      - profile
      - email
    user_mapping_provider:
      config:
        localpart_template: "{{ user.preferred_username }}"
        display_name_template: "{{ user.name }}"

# vim:ft=yaml
EOD
