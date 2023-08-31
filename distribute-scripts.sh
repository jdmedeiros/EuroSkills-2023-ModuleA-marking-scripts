#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

#gpg onlyforexperts -o marking.tar
tar xvf marking.tar

hosts=("192.168.20.1" "192.168.30.254" "10.20.23.254" "hq-clt01.firmatpolska.pl" "192.168.10.1" "192.168.10.2" "10.20.23.129" "193.224.23.3" "193.224.23.3" "hq-clt01.firmatpolska.pl")
files=("dmz-host.sh" "fw-hq.sh" "fw-sddc.sh" "hq-clt01.sh" "hq-intra.sh" "hq-noc.sh" "iaac-mgmt*" "ra-clt01.sh" "random_client.sh" "random_client.sh")

for i in ${!hosts[@]}; do
  cHost=${hosts[$i]}
  cFile=${files[$i]}
  echo -e "${NC}Copying $cFile to $cHost..."
  scp -o "ConnectTimeout 6" $cFile "root@${cHost}:" &> /dev/null
  if [ $? -gt 0 ]; then
    echo -e "${RED}Copy operation to $cHost failed."
  else
    echo -e "${GREEN}Success!"
  fi
done
echo -e "${NC}"

