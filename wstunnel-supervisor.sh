#!/bin/bash

#we had some issues because in some platforms the loopback interface has an MTU greater than 1500, so the wstunnel has trouble with SSH. normally the eth0 interface has a common mtu
local_ip=$(ip ad | grep -oE "\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" | grep -E "(192|10|172).*$" | grep -E -v "^.*(255)$")

wstunnel -s $local_ip:80 -t $local_ip:22
