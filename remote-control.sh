#!/bin/bash
#
# Author      : Gaston Gonzalez
# Date        : 17 December 2016
# Description : Provides remote control management of Dell C6100 servers via the IP over KVM port.

USER=root
PASS=root
MGMT_IP=$1

usage() {
  echo "Usage: <Mangagement IP Addres> <Remote Command>"
  echo "  <Management IP Address>"
  echo "  <Remote Command> - [on|off|reboot]"  
  echo 
  echo "Example: ./remote-control.sh 192.168.5.101 on"
}

if [ $# -ne 2 ]; then
  usage
  exit 1
fi

case $2 in
  off)
    echo "Powering off node: $MGMT_IP"
    RC_CMD=0
    ;;
  on)
    echo "Powering on node: $MGMT_IP"
    RC_CMD=1
    ;;
  reboot)
    echo "Rebooting node: $MGMT_IP"
    RC_CMD=2
    ;;
  *)
    echo "Unsupported remote command."
    usage
  ;;
esac

LOGIN_ENDPOINT=https://$MGMT_IP/rpc/WEBSES/create.asp
RC_ENDPOINT=https://$MGMT_IP/rpc/hostctl.asp

curl --silent -X POST \
        -H "Content-Type: application/x-www-form-urlencoded" \
	-d "WEBVAR_USERNAME=root&WEBVAR_PASSWORD=root" \
	--insecure \
	$LOGIN_ENDPOINT | grep SESSION_COOKIE | awk '{print "SessionCookie="$4}' | sed "s/'//g" > session.cookie

curl --silent -X POST \
	-H "Cookie: $(<session.cookie)" \
        -H "Content-Type: application/x-www-form-urlencoded" \
	-d "WEBVAR_POWER_CMD=$RC_CMD" \
	--insecure \
	$RC_ENDPOINT
