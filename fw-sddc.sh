#!/bin/bash
#
#	fw-sddc
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

################## Command section ##################
## Command ##
## 01 Basic Configuration ##

	checkHostname(){
		hostname
		}

	checkIP(){
		ip addr | egrep 'inet.*global' 2>/dev/null
		}

	checkKeyBoard(){
		cat /etc/default/keyboard | grep XKBLAYOUT
		}

	checkLanguage(){
		echo $LANG
		}

	checkTimezone(){
		timedatectl | grep -i "zone"
		}
## Command ##


################## Marking start ##################
echo ""
echo ""
echo -e $BLUE"######################################################################################"
echo "Marking fw-sddc"
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
echo "A8 Basic settings"
echo -e "######################################################################################"$NC
echo ""

	if [  $( checkHostname  | grep -ic "^fw-sddc") = 1 ]
	then  
		 echo -e $GREEN"OK - Check hostname"$NC
	else
		 echo -e $RED"FAILED - Check hostname"$NC
			echo "-----------------------------------------------------------------"
			checkHostname
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct hostname is: fw-sddc"$NC
	fi

	if [  $( checkIP  | grep -ic "10.20.23.254/25") = 1 ] && [  $( checkIP  | grep -ic "193.224.23.2/24") = 1 ]
	then  
		 echo -e $GREEN"OK - Check ip address"$NC
	else
		 echo -e $RED"FAILED - Check ip address"$NC
			echo "-----------------------------------------------------------------"
			checkIP
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Must contain 10.20.23.254/25, 193.224.23.2/24"$NC
	fi	

	if [  $( checkKeyBoard | grep -ic "us" ) = 1 ]
	then  
		 echo -e $GREEN"OK - Check keyboard"$NC
	else
		 echo -e $RED"FAILED - Check keyboard"$NC
	fi

	if [  $( checkLanguage  | grep -ic "en_US.UTF-8" ) = 1 ]
	then  
		 echo -e $GREEN"OK - Check Language"$NC
	else
		 echo -e $RED"FAILED - Check Language"$NC
			echo "-----------------------------------------------------------------"
			checkLanguage
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"en_US.UTF-8"$NC
	fi

	if [  $( checkTimezone | grep -ic "Europe/Warsaw" ) = 1 ]
	then  
		echo -e $GREEN"OK - Check Timezone"$NC
	else
		echo -e $RED"FAILED - Check Timezone"$NC
			echo "-----------------------------------------------------------------"
			checkTimezone
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Time zone: Europe/Warsaw"$NC
	fi

echo -e $YELLOW"If every item before is GREEN, point for first aspect."$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "Firewall configuration"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT!"$NC
echo -e $YELLOW"Are your ready?"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $YELLOW"See the next output:"$NC
    cat /etc/nftables.conf
echo -e $YELLOW"Is INPUT and FORWARD policy DROP? Have some rules without everything allow from/to everywhere?"$NC
echo -e $YELLOW"Have PAT and port-forwarding? Only needed service port forwarded to inside?"$NC
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