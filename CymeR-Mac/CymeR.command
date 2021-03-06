#!/bin/bash

##Set some paths
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentDIR="$(dirname "$DIR")"
grandparentDIR="$(dirname "$parentDIR")"
greatgrandparentDIR="$(dirname "$grandparentDIR")"

##Start the docker machine
docker-machine start cymer

##Allow docker commands to be used in the terminal
eval "$(docker-machine env cymer)"

##Expose local xquartz socket via socat on a TCP port
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

##Set pre-DISPLAY variable
export DISPLAY1="$(/sbin/ifconfig vboxnet0 | grep 'inet' | cut -d' ' -f2)"

##Set DISPLAY variable
export DISPLAY="$DISPLAY1:0"

##Launch CymeR
docker run -it --rm -e DISPLAY=$DISPLAY -v $parentDIR/CymeR-Workspace:/home/developer/knime-workspace -v $parentDIR/Scripts:/home/developer/Scripts -v $parentDIR/CymeR-Data:/home/developer/Data:rw -v $parentDIR/Templates:/home/developer/Templates:rw bmuchmore/cymer

##Remove the container once CymeR quits
docker rm -f `docker ps --no-trunc -aq`

