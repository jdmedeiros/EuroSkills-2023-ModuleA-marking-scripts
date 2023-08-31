#!/bin/bash
#
#	dmz-host
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
echo "Marking dmz-host"
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
echo "A4 Basic settings"
echo -e "######################################################################################"$NC
echo ""

	if [  $( checkHostname  | grep -ic "^dmz-host") = 1 ]
	then  
		 echo -e $GREEN"OK - Check hostname"$NC
	else
		 echo -e $RED"FAILED - Check hostname"$NC
			echo "-----------------------------------------------------------------"
			checkHostname
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct hostname is: dmz-host"$NC
	fi

	if [  $( checkIP  | grep -ic "192.168.20.1/24") = 1 ] 
	then  
		 echo -e $GREEN"OK - Check ip address"$NC
	else
		 echo -e $RED"FAILED - Check ip address"$NC
			echo "-----------------------------------------------------------------"
			checkIP
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Must contain 192.168.20.1/24"$NC
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
echo "DNS serves private forward and reverse records"
echo -e "######################################################################################"$NC
echo ""

	counter=0
    if [  $( nslookup 192.168.10.1 127.0.0.1 | grep -c "hq-intra" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup 192.168.10.1 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "name = hq-intra"$NC
    fi
    if [  $( nslookup 192.168.10.2 127.0.0.1 | grep -c "hq-noc" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup 192.168.10.2 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "name = hq-noc"$NC
    fi
    if [  $( nslookup 192.168.20.1 127.0.0.1 | grep -c "dmz-host" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup 192.168.20.1 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "name = dmz-host"$NC
    fi
    if [  $( nslookup 192.168.10.254 127.0.0.1 | grep -c "fw-hq" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup 192.168.10.254 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "name = fw-hq"$NC
    fi
    if [  $( nslookup 192.168.20.254 127.0.0.1 | grep -c "fw-hq" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup 192.168.20.254 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "name = fw-hq"$NC
    fi
    if [  $( nslookup 192.168.30.254 127.0.0.1 | grep -c "fw-hq" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup 192.168.30.254 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "name = fw-hq"$NC
    fi
    if [  $( nslookup hq-intra.firmatpolska.pl 127.0.0.1 | grep -c "192.168.10.1" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup hq-intra.firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Address: 192.168.10.1"$NC
    fi
    if [  $( nslookup hq-noc.firmatpolska.pl 127.0.0.1 | grep -c "192.168.10.2" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup hq-noc.firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Address: 192.168.10.2"$NC
    fi
    if [  $( nslookup dmz-host.firmatpolska.pl 127.0.0.1 | grep -c "192.168.20.1" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup dmz-host.firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Address: 192.168.20.1"$NC
    fi
    if [  $( nslookup fw-hq.firmatpolska.pl 127.0.0.1 | grep -c "192.168.*.254" ) > 0 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup fw-hq.firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Address: 192.168.10.254 or 192.168.20.254 or 192.168.30.254"$NC
    fi
    if [  $( nslookup fw-sddc.firmatpolska.pl 127.0.0.1 | grep -c "10.20.23.254" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup fw-sddc.firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Address: 10.20.23.254"$NC
    fi
    if [  $( nslookup iaac-mgmt.firmatpolska.pl 127.0.0.1 | grep -c "10.20.23.129" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup iaac-mgmt.firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Address: 10.20.23.129"$NC
    fi
    if [  $( nslookup www.firmatpolska.pl 127.0.0.1 | grep -c "Name:" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup www.firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Have answer"$NC
    fi
    if [  $( nslookup internal.firmatpolska.pl 127.0.0.1 | grep -c "192.168.20.1" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup intrnal.firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "CANAME or A record to dmz-host: 192.168.20.1"$NC
    fi
    if [  $( host -t mx firmatpolska.pl 127.0.0.1 | grep -c "mail is handled by" ) > 0 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		host -t mx firmatpolska.pl 127.0.0.1
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "MX record exists to dmz-host"$NC
    fi

    if [  $counter = 15 ]
	then  
		 echo -e $GREEN"OK - DNS serves private forward and reverse records"$NC
	else
		 echo -e $RED"FAILED - DNS serves private forward and reverse records"$NC
				echo -e $YELLOW"Correct output:"
				echo -e "Some records not exists."$NC
	fi
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