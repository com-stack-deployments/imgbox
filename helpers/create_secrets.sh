source ./compose/.env.secrets
mkdir -p "${COMPOSE_FOLDER}/secrets/imgbox/swarmit/ingress/traefik" && echo  "${SEC_IMGBOX_SWARMIT_INGRESS_TRAEFIK_INGRESS_ADMIN}" > "${COMPOSE_FOLDER}/secrets/imgbox/swarmit/ingress/traefik/ingress_admin.secret"

