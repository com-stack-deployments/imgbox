<p style="padding-bottom: 0rem;"><small>SWARM|it Infra</small></p>
<hr style="margin: 0px; margin-bottom: .25rem; border-top: 1px solid var(--theme);"/>
<h1 style="font-weight:700;margin:.5rem"><img style="margin:.5rem" width="48" height="48" src="https://logos.pub.deployment.center/logo/custom/company-comstack/infra-imgbox?format=svg"/>&nbsp;imgbox</h1>

## About

You are looking at a pre-configured  `compose-ready` deployment, which can be used with every standard `docker compose` or `docker-compose` client.

At ComStack we follow the idea: What is good for us and for our clients **cannot be bad** for you!

For this reason, we will publish all deployments - we create at ComStack - as `compose-ready` deployments, ready to be deployed **by yourself**.

## TL;DR

<div style="border: 1px solid white">

All our published deployments are deployed through 3 simple steps:
1. Clone this repo and change to the resulting directory
2. Change configuration items stored in file `.values`
3. Run `compose-up.sh` 


**That's all! Have Fun!**

</div>


Read on if you want to know more about our `compose-ready` deployment: **imgbox**


## Description
ComStack Images Box
## Provides
ComStack's internal container image registry
### Features
<details><summary>
This asset provides the following features
</summary>

| | |
|:--:|--|
|<img width="36" height="36" alt="registry" src="https://logos.pub.deployment.center/logo/custom/swarmit-asset/service-registry?format=svg"/><p><small>registry</small></p>|**Image registry<br/><small>Your self-hosted registry, for your container images</small>**|
|<img width="36" height="36" alt="registry-browser" src="https://logos.pub.deployment.center/logo/custom/swarmit-asset/service-registry-browser?format=svg"/><p><small>docker-registry-browser</small></p>|**Registry browser<br/><small>Browser your container images with you web-browser</small>**|
|<img width="36" height="36" alt="logs" src="https://logos.pub.deployment.center/logo/custom/swarmit-asset/service-dozzle?format=svg"/><p><small>dozzle</small></p>|**Container log aggregator<br/><small>Routing for all container logs</small>**|
|<img width="36" height="36" alt="http-code-pages" src="https://logos.pub.deployment.center/logo/custom/swarmit-asset/service-http-code-pages?format=svg"/><p><small>HTTP Status code pages</small></p>|**HTTP Error pages<br/><small>Throw HTTP errors with style</small>**|
|<img width="36" height="36" alt="traefik" src="https://logos.pub.deployment.center/logo/custom/swarmit-asset/service-traefik?format=svg"/><p><small>Traefik Proxy</small></p>|**Application proxy<br/><small>Modern open source reverse proxy and ingress controller that makes deploying services and APIs easy</small>**|
|<img width="36" height="36" alt="httpd" src="https://logos.pub.deployment.center/logo/custom/swarmit-asset/service-httpd?format=svg"/><p><small>Apache HTTP Server</small></p>|**Log analyzer GUI<br/><small>Analyze you ingress access.log from you web-browser</small>**|


</details>


### Contact
* [ComStack](https://www.comstack.de) *(Owner)*
* [Daniel Schlieder](mailto:daniel.schlieder@computerstack.de) *(Asset maintaner)*


### License
The software - provided through this asset -  is licensed under:

- [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0)
- [MIT License](None)
<hr style="margin: 2rem 0rem; border-top: 1px solid var(--theme);"/>


## Configuration


### Environment

All mandatory environment variables that need your attention or stored in `.values`

```bash
# Define the image tag to set, when image names are calulcated
# Set by: config/swarmit
export SWARMIT_IMAGES_IMAGE_TAG="swarmit-0725"
# Name of this swarmit asset
# Set by: internally/imgbox
export SWARMIT_INFRA="imgbox"
# Domain to set for deployment
# Set by: config/swarmit
export SWARMIT_INGRESS_BASE_DOMAIN="expample.com"
# Type of challenge you want to use for letsencrypt
# Set by: config/swarmit
export SWARMIT_INGRESS_LE_CHALLENGE_TYPE="http-challenge"
# Enable cert creation using letsencrypt
# Set by: config/swarmit
export SWARMIT_INGRESS_LE_ENABLE="True"
# Loglevel for Traefik
# Set by: config/swarmit
export SWARMIT_INGRESS_LOG_LEVEL="ERROR"
# Define what will be the ingress incoming port
# Set by: config/swarmit
export SWARMIT_INGRESS_PORT="443"
# Sets 'insecureSkipVerify' paraneter in Traefik
# Set by: config/swarmit
export SWARMIT_INGRESS_SKIP_SSL_VERIFY="False"

```

## Ingress Settings

|Param|Value|Desc|
|--|--|--|
|ingress-protocol|https://|Protocol to use for deployment|
|ingress-base-domain|expample.com|Domain to set for deployment|
|ingress-le-enable|True|Enable cert creation using letsencrypt|

## Service URLs

On successfull deployment, the following URLs will be accessible:
- https://registry.example.com
- https://images.example.com
- https://logs.example.com
- https://proxy.example.com/dashboard/
- https://webaccess.example.com
- https://goaccess.example.com

**Note:** It is up to you to make the shown URLs resolvable. The easiest way would be to provide the following row in you local hosts-table (`/etc/hosts`)

```
127.0.0.1		registry.example.com images.example.com logs.example.com proxy.example.com webaccess.example.com goaccess.example.com 
```

## Credentials

**Note:** All credentials, which are used in our `compose-ready` deployments, are set to one default password: `comstack1234`. In case you want to set your own 'very secret' secrets, read section [change secrets](#change-secrets).

This deployment (**imgbox**) uses the following credentials:

|Service|Username|Password|Note|
|--|--|--|--|
|traefik|admin|See note above|used to access traefik's dashboard|<hr style="margin: 2rem 0rem; border-top: 1px solid var(--theme);"/>

## Deployment

In this section you will be informed how to deploy this `compose-ready` deploy on your infrastructure.


### Clone this repo

```bash
$ git clone <BROWSER_URL> /target/folder/
```

### Configure your deployment

Change into `/target/folder` and open the file `.values` with your favourite editor to change the [environment](#environment) for your deployment.




### Deploy locally (bring it up!)

Now you can finally deploy the `compose-ready` deployment on your local target, using `docker-compose`

First you need to know, that our deployments are always split into several [compose projects](https://docs.docker.com/compose/how-tos/project-name/). To prevent you from calling `docker-compose up` several times, we provide a simple shell script for you.
This way we also ensure, that all required docker object (networks and volumes) are created and the correct `.env` is parsed with the adequate [compose project](https://docs.docker.com/compose/how-tos/project-name/).

Call the following to deploy our `compose-ready` deployment: **imgbox**:

```bash
$ cd /target/folder/
$ sh compose-up.sh
```

This should produce the following output:

```bash
$ cd /target/folder/
$ sh compose-up.sh 
creating secrets
creating networks
creating volumes
initializing volumes
initializing configs
initializing hooks
[+] Running 2/2
 ✔ Container images-registry-browser-1  Started                                   0.3s 
 ✔ Container images-registry-1          Started                                   0.3s 
[+] Running 1/1
 ✔ Container core-logs-1  Started                                                 0.3s 
[+] Running 4/4
 ✔ Container ingress-httpd-1            Started                                   0.4s 
 ✔ Container ingress-goaccess-1         Started                                   0.4s 
 ✔ Container ingress-http-code-pages-1  Started                                   0.4s 
 ✔ Container ingress-traefik-1          Started                                   0.5s 
 ```

### Un-deploy locally (bring it down!)

In case you want to remove all running services you previously deployed call the following:

```bash
$ cd /target/folder/
$ sh compose-down.sh
```
