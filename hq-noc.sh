#!/bin/bash
#
#	hq-noc
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
echo "Marking hq-noc"
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
echo "A3 Basic settings"
echo -e "######################################################################################"$NC
echo ""

	if [  $( checkHostname  | grep -ic "^hq-noc") = 1 ]
	then  
		 echo -e $GREEN"OK - Check hostname"$NC
	else
		 echo -e $RED"FAILED - Check hostname"$NC
			echo "-----------------------------------------------------------------"
			checkHostname
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct hostname is: hq-noc"$NC
	fi

	if [  $( checkIP  | grep -ic "192.168.10.2/24") = 1 ] 
	then  
		 echo -e $GREEN"OK - Check ip address"$NC
	else
		 echo -e $RED"FAILED - Check ip address"$NC
			echo "-----------------------------------------------------------------"
			checkIP
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Must contain 192.168.10.2/24"$NC
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
echo "RAID array configured and mounted"
echo -e "######################################################################################"$NC
echo ""

	if [  $( cat /proc/mdstat | grep -c "level 5") = 1 ] && [  $( mount | grep -c "/share") = 1 ]
	then  
		 echo -e $GREEN"OK - RAID"$NC
	else
		 echo -e $RED"FAILED - RAID"$NC
			echo "-----------------------------------------------------------------"
			cat /proc/mdstat
			mount |grep "/share"
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output: One md device with raid 5 level and this device is mounted as /share"$NC
	fi
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "Syslog server working"
echo -e "######################################################################################"$NC
echo ""

	if [  $( netstat -lapn | grep 514 | grep -c syslog) > 0 ]
	then  
		 echo -e $GREEN"OK - Syslog server working"$NC
	else
		 echo -e $RED"FAILED - Syslog server working"$NC
			echo "-----------------------------------------------------------------"
			netstat -lapn
			echo "-----------------------------------------------------------------"
			echo -e $YELLOW"Correct output: syslog listening on port 514"$NC
	fi
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "Syslog file separationr"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"HALF MANUAL CHECKING! HALF MANUAL CHECKING! HALF MANUAL CHECKING!"$NC

	if [ $( ls -l /log | grep -c "dhcp.log" ) = 1 ] && [ $( ls -l /log | grep -c "mail.log" ) = 1 ] && [ $( ls -l /log | grep -c "dump.log" ) = 1 ]
	then  
		 echo -e $GREEN"OK - All log file exist"$NC
	else
		 echo -e $RED"FAILED - Not all log file exist"$NC
			echo "-----------------------------------------------------------------"
			ls -l /log
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "dhcp.log, mail.log, dump.log"$NC
	fi

echo -e $CYAN"IF THE PREVIOUS IT'S RED, NO POINT AND YOU CAN GO TO THE NEXT ITEM. OTHERWISE CONTINUE TESTING:"$NC
echo ""
pause 'Press [ENTER] key to continue...'

echo -e $YELLOW"See the following output:"$NC
    tail /log/dhcp.log
echo -e $YELLOW"Is this DHCP log from ONLY hq-intra?"$NC
echo ""
pause 'Press [ENTER] key to continue...'

echo -e $YELLOW"See the following output:"$NC
    tail /log/mail.log
echo -e $YELLOW"Is this a mail server log from dmz-host?"$NC
echo ""
pause 'Press [ENTER] key to continue...'

echo -e $YELLOW"See the following output:"$NC
	cat /log/dump.log |grep "Expert says:"
echo -e $YELLOW"The hash, which generated on hq-intra appear?"$NC
echo ""
pause 'Press [ENTER] key to continue...'

echo -e $GREEN"IF YOUR ANSWER FOR EVERY QUESTION YES, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "Overload the memory for Cacti alert"
echo -e "######################################################################################"$NC
echo ""
echo -e $YELLOW"The memory overload command will run in the next 6 minutes. You can continue marking on the next VM. $random_word"$NC

cat <(head -c 500m /dev/zero) <(sleep 360) | tail

################## Ending section ##################
echo ""
echo ""
echo -e $BLUE"######################################################################################"
echo "The marking of this VM is finished. The script is terminating."
echo -e "######################################################################################"$NC
echo ""
echo ""