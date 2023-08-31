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
echo -e $YELLOW"Best: All playbook run without any error at first run. Second time all line changed or OK."$NC
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