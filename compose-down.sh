source "./compose/.values"
source "./compose/.env"

COMPOSE="$(which ${DOCKERBIN}-compose 2>/dev/null)"
if [[ -z "${COMPOSE}" ]]
then
    COMPOSE="$(which ${DOCKERBIN} 2>/dev/null)"
    if [[ -z "${COMPOSE}" ]]
    then
        echo "Cannot find ${DOCKERBIN}-compose, nor ${DOCKERBIN}"
        exit 1
    else
        COMPOSE="${COMPOSE} compose"
    fi
fi 

########### DEPLOYMENT REMOVAL START ################
cd ./compose/imgbox
cd ./swarmit
# Deploying Stack: ingress
cd ./ingress && source ./.env && ${COMPOSE} down && cd ..

# Deploying Stack: core
cd ./core && source ./.env && ${COMPOSE} down && cd ..

# Deploying Stack: images
cd ./images && source ./.env && ${COMPOSE} down && cd ..

cd ..

cd ..
cd ..