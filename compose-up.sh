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
########### CREATE SECRETS ##################
echo "creating secrets"
sh "./helpers/create_secrets.sh" > "/dev/null"
########### CREATE NETWORKS #################
echo "creating networks"
sh "./helpers/create_networks.sh" > "/dev/null"
########### CREATE VOLUMES ##################
echo "creating volumes"
sh "./helpers/create_volumes.sh" > "/dev/null"
echo "initializing volumes"
find "volumes/" -type f \
    -not -name "acme.json" \
    -exec \
    bash -c '\
        source ./compose/.values; \
        source ./compose/.env; \
        python helpers/repl.py ./compose/.env.secrets {}; \
        python helpers/repl.py ./compose/.env {}; \
        ' \
        \;
########### INIT CONFIGS ###################
echo "initializing configs"

find "configs/" -type f \
    -not -name "*.config.bin" \
    -not -name "*.env" \
    -exec \
    bash -c '\
        ASSETENV=$(echo '"{}"' | sed -e "s/.config$/.env/"); \
        source ./compose/.values; \
        source ./compose/.env; \
        python helpers/repl.py ./compose/.env.secrets {}; \
        python helpers/repl.py ./compose/.env {}; \
        python helpers/repl.py $ASSETENV {}; \
        ' \
        \;
########### INIT HOOKS ###################
echo "initializing hooks"
find "hooks/" -type f \
    -not -name ".hook.env" \
    -exec \
    bash -c '\
        ASSETENV=$(dirname '"{}"')"/.hook.env"; \
        source ./compose/.values; \
        source ./compose/.env; \
        python helpers/repl.py ./compose/.env.secrets {}; \
        python helpers/repl.py ./compose/.env {}; \
        python helpers/repl.py $ASSETENV {}; \
        ' \
        \;   
find "helpers/" -type f \
    -name "*_hooks.sh" \
    -not -name "*.env" \
    -exec \
    bash -c '\
        source ./compose/.values; \
        source ./compose/.env; \
        python helpers/repl.py ./compose/.env.secrets {}; \
        python helpers/repl.py ./compose/.env {}; \
        ' \
        \;     
########### DEPLOYMENT START ################
cd ./compose/imgbox
cd ./swarmit
# Deploying Stack: images
cd ./images && source ./.env && ${COMPOSE} up -d && cd ..

# Deploying Stack: core
cd ./core && source ./.env && ${COMPOSE} up -d && cd ..

# Deploying Stack: ingress
cd ./ingress && source ./.env && ${COMPOSE} up -d && cd ..

cd ..

cd ..
cd ..