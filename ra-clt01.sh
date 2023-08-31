#!/bin/bash
#
#	ra-clt01
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
echo "Marking ra-clt01 with maja (if not working, use localadmin)"
echo -e "######################################################################################"$NC
echo ""
echo ""

echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "VPN connect automatically"
echo -e "######################################################################################"$NC
echo ""
echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo -e $CYAN"CREATE A SNAPSHOT NOW!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"Restart the VM!"$NC
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"See the next output:"$NC
ping 192.168.10.1 -c 4
echo -e $GREEN"OK - IF PING OK"$NC
echo -e $RED"FAILED - IF packet loss 100%"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "Remote Access VPN"
echo -e "######################################################################################"$NC
echo ""
echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo -e $YELLOW"See the next output:"$NC
echo ""
pause 'Press [ENTER] key to continue...'
ip a
echo -e $YELLOW"Have a tunnel or tap interface and it is up or ens interface has virtual secondary IP?"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"Run some traceroute:"$NC
traceroute -T -m 10 -n 192.168.10.1
traceroute -T -m 10 -n 192.168.20.1
traceroute -T -m 10 -n 10.20.23.129
echo -e $YELLOW"Are you seen 2 hop in the 1-2 line and 3 hop in the 3 line?"$NC
pause 'Press [ENTER] key to continue...'
echo -e $GREEN"IF say YES for all question, the ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "Remote Access VPN security"
echo -e "######################################################################################"$NC
echo ""
echo -e $CYAN"JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo ""
echo -e $YELLOW"Check the VPN configuration: Autheticate with certificate? Who issued the certificate? (Try on new tty line ipsec status command or /etc/openvpn/openvpn.cnf file)"$NC
pause 'Press [ENTER] key to continue...'
echo -e $CYAN"IT IS A TIME FOR JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "LDAP authentication"
echo -e "######################################################################################"$NC
echo ""

	if [  $( getent passwd | grep -c "^admin:" ) = 1 ] && [ $( getent passwd | grep -c "^jan:" ) = 1 ] && [ $( getent passwd | grep -c "^maja:" ) = 1 ] && [  $( cat /etc/passwd | grep -c "^admin:" ) = 0 ] && [ $( cat /etc/passwd | grep -c "^jan:" ) = 0 ] && [ $( cat /etc/passwd | grep -c "^maja:" ) = 0 ]
	then  
		 echo -e $GREEN"OK - IF YOU CAN LOGIN WITH maja, LDAP authentication"$NC
	else
		 echo -e $RED"FAILED - LDAP authentication"$NC
			echo "-----------------------------------------------------------------"
			getent passwd
			echo "-----------------------------------------------------------------"
			echo -e $YELLOW"You can see admin, maja and jan here. AND (press ENTER)"$NC
            echo "-----------------------------------------------------------------"
            pause 'Press [ENTER] key to continue...'
			cat /etc/passwd
			echo "-----------------------------------------------------------------"
			echo -e $YELLOW"You CAN'T see admin, maja and jan here."$NC
	fi
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "Thunderbird configured, can send and receive messages"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo ""
echo -e $YELLOW"Open Thunderbird, configured to maja@firmatpolska.pl; Send email to admin@firmatpolska.pl"$NC
echo ""
echo -e $GREEN"IF client configured and can send message ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "DNS public records"
echo -e "######################################################################################"$NC
echo ""

	counter=0
    if [  $( nslookup fw-hq.firmatpolska.pl | grep -c "192.168.*.254" ) > 0 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup fw-hq.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Private IP address."$NC
    fi
    if [  $( nslookup dmz-host.firmatpolska.pl | grep -c "Address: 192.168.20.1" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup dmz-host.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Private IP address.."$NC
    fi
    if [  $( nslookup fw-sddc.firmatpolska.pl | grep -c "10.20.23.254" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup fw-sddc.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Private IP address."$NC
    fi
    if [  $( nslookup www.firmatpolska.pl | grep -c "10.20.23." ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup www.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Private IP address."$NC
    fi

echo ""
echo -e $YELLOW"Shut down the VPN connection and press ENTER!"$NC
echo ""
pause 'Press [ENTER] key to continue...'


    if [  $( nslookup fw-hq.firmatpolska.pl | grep -c "Address: 193.224.23.1" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup fw-hq.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Public IP address."$NC
    fi
    if [  $( nslookup dmz-host.firmatpolska.pl | grep -c "Address: 193.224.23.1" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup dmz-host.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Public IP address."$NC
    fi
    if [  $( nslookup fw-sddc.firmatpolska.pl | grep -c "Address: 193.224.23.2" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup fw-sddc.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Public IP address."$NC
    fi
    if [  $( nslookup ra-clt01.firmatpolska.pl | grep -c "193.224.23.3" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup ra-clt01.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Public IP address."$NC
    fi
    if [  $( nslookup www.firmatpolska.pl | grep -c "Address: 193.224.23.2" ) = 1 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		nslookup www.firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "Public IP address."$NC
    fi
    if [  $( host -t mx firmatpolska.pl | grep -c "mail is handled by" ) > 0 ]
    then
        counter=$((counter+1))
    else
        echo -e $RED"FAILED"$NC
		echo "-----------------------------------------------------------------"
		host -t mx firmatpolska.pl
		echo "-----------------------------------------------------------------"
		echo -e $YELLOW"Correct output:"
		echo -e "MX record exists to dmz-host"$NC
    fi

    if [  $counter = 10 ]
	then  
		 echo -e $GREEN"OK - DNS public records"$NC
	else
		 echo -e $RED"FAILED - DNS public records"$NC
		echo -e "Some records not looks good."$NC
	fi
echo ""

echo -e $YELLOW"Turn back the VPN connection!"
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "www webiste working"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo ""
echo -e $YELLOW"Firefox: https://www.firmatpolsa.pl"$NC
echo -e $YELLOW"Website must appear"$NC
echo ""
pause 'Press [ENTER] for a next stage...'
echo ""
echo -e $YELLOW"Disable RA VPN"$NC
echo -e $YELLOW"Reload a webpage: Website must appear, certificate issued by Company's CA"$NC
echo -e $YELLOW"Display message: Linux - Because there is more than one way. This site was served by"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $GREEN"IF both works, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo -e $YELLOW"START the RA service!"$NC
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