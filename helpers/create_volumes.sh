sudo mkdir -p ${COMPOSE_FOLDER}/volumes/imgbox/swarmit/hooks
${DOCKERBIN} volume create --opt device=${COMPOSE_FOLDER}/volumes/imgbox/swarmit/hooks --opt type=none --opt o=bind imgbox_swarmit_hooks
sudo mkdir -p ${COMPOSE_FOLDER}/volumes/imgbox/swarmit/images/registry/data
${DOCKERBIN} volume create --opt device=${COMPOSE_FOLDER}/volumes/imgbox/swarmit/images/registry/data --opt type=none --opt o=bind imgbox_swarmit_images_registry_data
sudo mkdir -p ${COMPOSE_FOLDER}/volumes/imgbox/swarmit/core/logs/data
${DOCKERBIN} volume create --opt device=${COMPOSE_FOLDER}/volumes/imgbox/swarmit/core/logs/data --opt type=none --opt o=bind imgbox_swarmit_core_logs_data
sudo mkdir -p ${COMPOSE_FOLDER}/volumes/imgbox/swarmit/ingress/httpd/www
${DOCKERBIN} volume create --opt device=${COMPOSE_FOLDER}/volumes/imgbox/swarmit/ingress/httpd/www --opt type=none --opt o=bind imgbox_swarmit_ingress_httpd_www

