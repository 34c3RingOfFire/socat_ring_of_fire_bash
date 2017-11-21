#!/bin/bash

FIRST=${1:-12345}
NUM=${2:-10}

for ((THIS=FIRST; NUM;  NUM--)) ; do
    let NEXT=THIS+1
    echo "proxy from ${THIS} to ${NEXT}"
    (socat -u4v UDP4-LISTEN:${THIS},bind=0.0.0.0,reuseaddr,fork UDP4-DATAGRAM:localhost:${NEXT})&
    let THIS+=1
done

echo "closing the loop: proxy ${THIS} to ${FIRST}"
socat -u4v UDP4-LISTEN:${THIS},bind=0.0.0.0,reuseaddr,fork UDP4-DATAGRAM:localhost:${FIRST}
