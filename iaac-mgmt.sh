#!/bin/bash
#
#	iaac-mgmt
#
################## General section ##################
function pause(){
 read -p "$*"
}

#### COLORS ####
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

################## Marking start ##################
echo ""
echo ""
echo -e $BLUE"######################################################################################"
echo "Prapare the infrastructure for marking and marking Software Defined Data Center"
echo -e "######################################################################################"$NC
echo ""
echo ""

echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
################## Per aspect section ##################
echo ""
echo ""
echo -e $PURPLE"######################################################################################"
echo "Prepare the hosts file"
echo -e "######################################################################################"$NC
echo ""
ipPrefix="10.20.23."
frtN=10
bckN=100

read -p "Enter the number of servers [2-5]: " bck
frt=$bck

echo "Generating hosts file for $frt frontend servers and $bck backend servers..."

echo "all:" > hosts-ansible
echo "  hosts:" >> hosts-ansible

for i in $(seq 1 $bck)
do
  bckN=$((bckN+1))
  echo "    bck-srv0$i:" >> hosts-ansible
  echo "      ansible_host: $ipPrefix$bckN" >> hosts-ansible
  echo "      hostname: \"bck-srv0$i\"" >> hosts-ansible
done

for i in $(seq 1 $frt)
do
  frtN=$((frtN+1))
  echo "    frt-web0$i:" >> hosts-ansible
  echo "      ansible_host: $ipPrefix$frtN" >> hosts-ansible
  echo "      hostname: \"frt-web0$i\"" >> hosts-ansible
done

echo "  children:" >> hosts-ansible
echo "    backend:" >> hosts-ansible
echo "      hosts:" >> hosts-ansible

for i in $(seq 1 $bck)
do
  echo "        bck-srv0$i:" >> hosts-ansible
done

echo "    frontend:" >> hosts-ansible
echo "      hosts:" >> hosts-ansible

for i in $(seq 1 $frt)
do
  echo "        frt-web0$i:" >> hosts-ansible
done

mv /etc/ansible/hosts /etc/ansible/hosts_old
mv hosts-ansible /etc/ansible/hosts

echo "Done writing to file."

echo ""
pause 'Press [ENTER] key to continue...'
clear
echo -e $YELLOW"Revert all frt and bck servers to basic state! Turn on only $frt pcs front and backend server! Shut down all others!"$NC
echo ""
echo -e $YELLOW"Run ansible-playbook /etc/ansible/ping_all.yml"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo -e $PURPLE"######################################################################################"
echo "Playbooks runs without error"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo ""
echo -e $YELLOW"Another tty login as root and run 2 times ansible-playbook /ansible/*.yml command"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"Best: All playbook run without any error at first run. Second time all line is OK (no changed)."$NC
pause 'Press [ENTER] key to continue...'
echo -e $CYAN"IT IS A TIME FOR JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "1-hostname.yml setup hostname and timezone"
echo -e "######################################################################################"$NC
echo ""
echo -e $YELLOW"Pleae wait, test in progress..."$NC
      ansible-playbook iaac-mgmt.yml > ansible_output.txt
      if [ $? -gt 0 ]; then
        echo -e $RED"FAILED - 1-hostname.yml setup hostname and timezone"$NC
        cat ansible_output.txt | grep fatal
      else
        echo -e $GREEN"OK - 1-hostname.yml setup hostname and timezone"$NC
      fi
      rm ansible_output.txt
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "2-firewall.yml setup correct fw settings"
echo -e "######################################################################################"$NC
echo ""
echo -e $YELLOW"Pleae wait, I collect the firewall configurations..."$NC
mkdir -p /ansible/fw-configs/
rm /ansible/fw-configs/* 2> /dev/null
ansible-playbook iaac-mgmt_fw.yml > /dev/null
echo ""
echo -e $YELLOW"I am done. I found $(ls /ansible/fw-configs/ | grep wc -l) pcs firewall configs. Ready to shows the firewall configs."$NC
pause 'Press [ENTER] key to continue...'
clear
for fwconf in `ls /ansible/fw-configs/`; do
  echo -e "${BLUE}&&&&&&&&&&&&&&&&&&"
  echo -e "${YELLOW}$fwconf${NC}\n"
  cat "/ansible/fw-configs/$fwconf"
  echo -e "${BLUE}&&&&&&&&&&&&&&&&&&${NC}\n"
  echo -e $YELLOW"INPUT policy DROP, SSH only from 10.20.23.0/24 (or 25), bck only 80 and/or 443, frt only 443, (80), port 990 (and some FTP port) and ICMP allowed?"$NC
  pause 'Press [ENTER] key to continue...'
  clear
done
  echo -e $GREEN"If all frt and bck server's firewall configured correctly - ITEM is OK"$NC
  echo -e $RED"But if NOT - FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "Ansible code style"
echo -e "######################################################################################"$NC
echo ""
echo -e $CYAN"JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo ""
if [  $( cat /ansible/*.yml | grep -c "handlers:" ) > 0 ]
	then  
		echo -e $GREEN"Found handlers"$NC
	else
		echo -e $RED"NOT found any handlers"$NC
	fi
echo ""
if [  $( cat /ansible/*.yml | grep -c "#" ) > 0 ]
	then  
		echo -e $GREEN"Found comments"$NC
	else
		echo -e $RED"NOT found any comments"$NC
	fi
echo ""
if [  $( cat /ansible/*.yml | grep -c "template:" ) > 0 ]
	then  
		echo -e $GREEN"Found template using"$NC
	else
		echo -e $RED"NOT found any template"$NC
	fi
echo ""
echo -e $CYAN"IT IS A TIME FOR JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
################## Ending section ##################
echo ""
echo ""
echo -e $BLUE"######################################################################################"
echo "The marking of this VM is finished. The script is terminating."
echo -e "######################################################################################"$NC
echo ""
echo ""