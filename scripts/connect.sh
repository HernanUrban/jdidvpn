#!/bin/bash
if [ -z "$CERT" ]
then
  echo $ANYCONNECT_PASSWORD|openconnect $ANYCONNECT_SERVER --user=$ANYCONNECT_USER -b --csd-wrapper=/root/csd-wrapper.sh --no-dtls
else
  echo $ANYCONNECT_PASSWORD|openconnect $ANYCONNECT_SERVER --user=$ANYCONNECT_USER --servercert=$CERT -b --csd-wrapper=/root/csd-wrapper.sh --no-dtls
fi

sleep 5

/usr/sbin/danted -f /etc/jdidvpn.conf -D

socat -d TCP4-LISTEN:3389,fork TCP4:$JUMP1:3389 &
socat -d TCP4-LISTEN:3390,fork TCP4:$JUMP2:3389 &

/bin/bash
