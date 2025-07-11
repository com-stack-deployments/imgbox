#!/bin/sh
echo "########################################################"
echo "Running hooks for service traefik"
echo "########################################################"
echo "Hook 'configure checkmk checks'"
CID="$(${DOCKERBIN} ps -q -f label=com.swarmit.asset=imgbox_swarmit_ingress_traefik)"
if [[ "${CID}" != "" ]]
then
    ${DOCKERBIN} cp /tmp/imgbox/hooks/imgbox_swarmit_ingress_traefik/configure_checkmk_checks ${CID}:/tmp/
    ${DOCKERBIN} exec -u "0:0" -t ${CID} sh /tmp/configure_checkmk_checks > /tmp/imgbox/hooks/imgbox_swarmit_ingress_traefik/configure_checkmk_checks.log 2>&1
    RC=${?}
    echo "Check output through file:"
    echo "$ cat /tmp/imgbox/hooks/imgbox_swarmit_ingress_traefik/configure_checkmk_checks.log" 
    echo "Hook has returned with RC ${RC}"
else
    echo "Service traefik has no container running!"
fi
echo "$(date)" >  "$(dirname '/tmp/imgbox/hooks/imgbox_swarmit_ingress_traefik/configure_checkmk_checks')/.once"

