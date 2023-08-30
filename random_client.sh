#!/bin/bash
#
#	random-client
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
echo "Marking random client"
echo -e "######################################################################################"$NC
echo ""
echo ""

echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "Check GUI on a random client"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo -e $GREEN"IF GUI installed and running, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "LDAP auth cache"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo -e $RED"CREATE A SNAPSHOT ON hq-intra NOW!"$NC
echo ""
pause 'Press [ENTER] for a first stage...'
echo -e $YELLOW"Login with jan to this client."$NC
echo ""
pause 'Press [ENTER] for a first stage...'
echo -e $YELLOW"Disable NIC of hq-intra"$NC
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"Login with jan again on the client."$NC
pause 'Press [ENTER] key to continue...'
echo -e $GREEN"IF you can login second time with jan, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
echo -e $RED"ENABLE NIC of hq-intra!!!"$NC
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