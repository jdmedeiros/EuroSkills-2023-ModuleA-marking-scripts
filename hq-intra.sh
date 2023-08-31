#!/bin/bash
#
#	hq-intra
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
echo "Marking hq-intra"
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
echo "A2 Basic settings"
echo -e "######################################################################################"$NC
echo ""

	if [  $( checkHostname  | grep -ic "^hq-intra") = 1 ]
	then  
		 echo -e $GREEN"OK - Check hostname"$NC
	else
		 echo -e $RED"FAILED - Check hostname"$NC
			echo "-----------------------------------------------------------------"
			checkHostname
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct hostname is: hq-intra"$NC
	fi

	if [  $( checkIP  | grep -ic "192.168.10.1/24") = 1 ] 
	then  
		 echo -e $GREEN"OK - Check ip address"$NC
	else
		 echo -e $RED"FAILED - Check ip address"$NC
			echo "-----------------------------------------------------------------"
			checkIP
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Must contain 192.168.10.1/24"$NC
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
echo "LDAP server implemented"
echo -e "######################################################################################"$NC
echo ""

	if [  $( ldapsearch -x -b dc=firmatpolska,dc=pl |grep -c "result: 0 Success" ) = 1 ]
	then  
		 echo -e $GREEN"OK - LDAP server implemented"$NC
	else
		 echo -e $RED"FAILED - LDAP server implemented"$NC
			echo "-----------------------------------------------------------------"
			ldapsearch -x -b dc=firmatpolska,dc=pl
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "Query successful"$NC
	fi
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "LDAP objects exist"
echo -e "######################################################################################"$NC
echo ""

	if [ $( ldapsearch -x -b "uid=admin,cn=admins,ou=Network Admins,dc=firmatpolska,dc=pl" |grep -c -e "result: 0 Success" ) = 1 ] && [ $( ldapsearch -x -b "uid=maja,cn=management,ou=Management,dc=firmatpolska,dc=pl" |grep -c -e "result: 0 Success" ) = 1 ] && [ $( ldapsearch -x -b "uid=jan,cn=superusers,ou=Network Admins,dc=firmatpolska,dc=pl" |grep -c -e "result: 0 Success" ) = 1 ]
	then  
		 echo -e $GREEN"OK - LDAP objects exist"$NC
	else
		 echo -e $RED"FAILED - LDAP objects exist"$NC
			echo "-----------------------------------------------------------------"
			ldapsearch -x -b dc=firmatpolska,dc=pl
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "admin and jan exist in Network Admins OU, maja exist in Management OU, admins, superusers, management group exist"$NC
	fi
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "Log entry creating for the Syslog marking"
echo -e "######################################################################################"$NC
echo ""

random_word=$(echo $RANDOM | md5sum | head -c 20; echo;)

logger Expert says: $random_word

echo -e $YELLOW"Expert says: $random_word"$NC
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