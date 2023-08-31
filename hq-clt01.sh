#!/bin/bash
#
#	hq-clt01
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
echo "Marking hq-clt01 with admin (if not working, use localadmin)"
echo -e "######################################################################################"$NC
echo ""
echo ""

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
		 echo -e $GREEN"OK - IF YOU CAN LOGIN WITH admin, LDAP authentication"$NC
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
echo "Client local users disabled"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
pause 'Press [ENTER] for a first stage...'
echo -e $YELLOW"Create user with adduser manager"$NC
echo ""
pause 'Press [ENTER] for a first stage...'
echo -e $YELLOW"Try to login with this user to GUI."$NC
pause 'Press [ENTER] key to continue...'
echo -e $GREEN"IF you can't login with manager, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
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
echo -e $YELLOW"Open Thunderbird, configured to admin@firmatpolska.pl; Send email to maja@firmatpolska.pl"$NC
echo ""
echo -e $GREEN"IF client configured and can send message ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "Mail security"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo ""

	echo
	if [ $( echo -e 'CLOSE\nCLOSE\nCLOSE' | nc -w 5 192.168.20.1 143 | grep -c OK ) = 1 ]
	then  
		 echo -e $GREEN"OK - IMAP port open"$NC
	else
		 echo -e $RED"FAILED - IMAP port closed"$NC
			echo "-----------------------------------------------------------------"
			echo -e 'CLOSE\nCLOSE\nCLOSE' | nc -w 5 192.168.20.1 143
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "Connection successful"$NC
	fi

echo ""
pause 'Press [ENTER] key to continue...'
echo ""

	if [ $( echo 'QUIT' | nc -w 5 192.168.20.1 25 | grep -c 220 ) = 1 ]
	then  
		 echo -e $GREEN"OK - SMTP port open"$NC
	else
		 echo -e $RED"FAILED - SMTP port closed"$NC
			echo "-----------------------------------------------------------------"
			echo 'QUIT' | nc -w 5 192.168.20.1 25
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "Connection successful"$NC
	fi

pause 'Press [ENTER] key to continue...'
echo ""

	if [ $( echo 'QUIT' | nc -w 5 192.168.20.1 587 | grep -c 220 ) = 1 ]
	then  
		 echo -e $GREEN"OK - SMTPS port open"$NC
	else
		 echo -e $RED"FAILED - SMTPS port"$NC
			echo "-----------------------------------------------------------------"
			echo 'QUIT' | nc -w 5 192.168.20.1 587
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "Connection successful"$NC
	fi

pause 'Press [ENTER] key to continue...'
echo ""

	echo -e 'QUIT\nQUIT\nQUIT' | nc -w 5 192.168.20.1 110 > tmp 2> tmp
	if [ $( cat tmp | grep -c refused ) = 1 ] || [ $( cat tmp | grep -c "timed out" ) = 1 ]
	then  
		 echo -e $GREEN"OK - POP3 port closed"$NC
	else
		 echo -e $RED"FAILED - POP3 port open"$NC
			echo "-----------------------------------------------------------------"
			echo -e 'QUIT\nQUIT\nQUIT' | nc -w 5 192.168.20.1 110
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "Connection NOT successful"$NC
	fi

pause 'Press [ENTER] key to continue...'
echo ""

	echo -e 'CLOSE\nCLOSE\nCLOSE' | nc -w 5 192.168.20.1 993 >tmp 2> tmp
	if [ $( cat tmp | grep -c refused ) = 1 ] || [ $( cat tmp | grep -c "timed out" ) = 1 ]
	then  
		 echo -e $GREEN"OK - 993 port closed"$NC
	else
		 echo -e $RED"FAILED - 993 port open"$NC
			echo "-----------------------------------------------------------------"
			echo -e 'CLOSE\nCLOSE\nCLOSE' | nc -w 5 192.168.20.1 993
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "Connection NOT successful"$NC
	fi

pause 'Press [ENTER] key to continue...'
echo ""

	echo -e 'QUIT' | nc -w 5 192.168.20.1 465 > tmp 2> tmp
	if [ $( cat tmp | grep -c refused ) = 1 ] || [ $( cat tmp | grep -c "timed out" ) = 1 ]
	then  
		 echo -e $GREEN"OK - 465 port closed"$NC
	else
		 echo -e $RED"FAILED - 465 port open"$NC
			echo "-----------------------------------------------------------------"
			echo -e 'QUIT' | nc -w 5 192.168.20.1 465
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "Connection NOT successful"$NC
	fi

pause 'Press [ENTER] key to continue...'
echo ""

	if [ $( sleep 5 | openssl s_client -connect 192.168.20.1:587 -starttls smtp 2> /dev/null | grep -c "issuer=C = PL, O = Firma Tradycyjna Polska Sp. z o.o., CN = Firma Tradycyjna Polska Sp. z o.o. Root CA" ) = 1 ]
	then  
		 echo -e $GREEN"OK - Certificate on SMTP issued by company's CA"$NC
	else
		 echo -e $RED"FAILED - Certificate on SMTP not issued by company's CA"$NC
			echo "-----------------------------------------------------------------"
			sleep 5 | openssl s_client -connect 192.168.20.1:587 -starttls smtp 2> /dev/null| grep "issuer="
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "issuer=C = PL, O = Firma Tradycyjna Polska Sp. z o.o., CN = Firma Tradycyjna Polska Sp. z o.o. Root CA"$NC
	fi

pause 'Press [ENTER] key to continue...'
echo ""

	if [ $( sleep 5 | openssl s_client -connect 192.168.20.1:143 -starttls imap 2> /dev/null | grep -c "issuer=C = PL, O = Firma Tradycyjna Polska Sp. z o.o., CN = Firma Tradycyjna Polska Sp. z o.o. Root CA" ) = 1 ]
	then  
		 echo -e $GREEN"OK - Certificate on IMAP issued by company's CA"$NC
	else
		 echo -e $RED"FAILED - Certificate on IMAP not issued by company's CA"$NC
			echo "-----------------------------------------------------------------"
			sleep 5 | openssl s_client -connect 192.168.20.1:143 -starttls imap 2> /dev/null| grep "issuer="
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Correct output:"
				echo -e "issuer=C = PL, O = Firma Tradycyjna Polska Sp. z o.o., CN = Firma Tradycyjna Polska Sp. z o.o. Root CA"$NC
	fi
pause 'Press [ENTER] key to continue...'
echo -e $CYAN"IT IS A TIME FOR JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "CIFS home share mount"
echo -e "######################################################################################"$NC
echo ""

	if [  $( mount |grep cifs | grep -c "/share") > 0 ]
	then  
		 echo -e $GREEN"OK - CIFS home share mount"$NC
	else
		 echo -e $RED"FAILED - CIFS home share mount"$NC
			echo "-----------------------------------------------------------------"
			mount |grep cifs
			echo "-----------------------------------------------------------------"
			echo -e $YELLOW"Correct output: User's home folder is a CIFS share"$NC
	fi
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "Cacti configured correctly"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo ""
echo -e $YELLOW"Firefox: http://192.168.10.2/cacti (user: admin)"$NC
echo -e $YELLOW"Can access, hq-noc, hq-intra, dmz-host CPU, memory, disk usage monitored, memory usage alert sent to admin?"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $GREEN"IF yes, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "Cacti security"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo ""
echo -e $YELLOW"Check SNMP version of the devices. (SNMPv3 with username and password is the best)"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $CYAN"IT IS A TIME FOR JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "DHCP IP"
echo -e "######################################################################################"$NC
echo ""

	if [  $( ip address  | grep 192.168.30 | grep -c "dynamic" ) = 1 ]
	then  
		 echo -e $GREEN"OK - DHCP IP"$NC
	else
		 echo -e $RED"FAILED - DHCP IP"$NC
			echo "-----------------------------------------------------------------"
			ip address
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Must IP from DHCP server."$NC
	fi
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "DHCP failover"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
pause 'Press [ENTER] for a first stage...'
echo -e $YELLOW"Create a SNAPSHOT of $(nmcli c show "Wired connection 1" | grep "dhcp_server_identifier" |cut -d "=" -f 2)"$NC
echo ""
pause 'Press [ENTER] for a next stage...'
echo -e $YELLOW"Shut down DHCP service on $(nmcli c show "Wired connection 1" | grep "dhcp_server_identifier" |cut -d "=" -f 2)"$NC
pause 'Press [ENTER] for a next stage...'
echo -e $YELLOW"Renew the IP of the client"$NC
pause 'Press [ENTER] key to continue...'
echo -e $GREEN"IF client IP renew working, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"REVERT THE SNAPSHOT!!"$NC
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "DDNS working"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo -e $CYAN"CREATE A SNAPSHOT NOW!"$NC
echo ""
pause 'Press [ENTER] for a first stage...'
echo ""
echo -e $YELLOW"See these outputs:"$NC
echo ""
ip a
echo ""
nslookup hq-clt01.firmatpolska.pl
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"You can see the IP in DNS result is the IP of the machine."$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"Type nslookup <the IP of hq-clt01> - you can see reverse record"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"Shutdown a client, generate new MAC, power on, ip a, nslookup hq-clt01.firmatpolska.pl, nslookup <ip of hq-clt01>"$NC
echo -e $GREEN"IF DNS updated with new IP, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "Internal site working with client cert authentication"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo ""
echo -e $YELLOW"Firefox: https://internal.firmatpolsa.pl"$NC
echo -e $YELLOW"Cert auth works, web and clients certs issued by Company's CA"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $GREEN"IF yes, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "www website HA test"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo ""
echo -e $YELLOW"Firefox: https://www.firmatpolsa.pl"$NC
echo -e $YELLOW"Inaccesable all frt server, enables only 1 and open the website, disable frt server and enable another"$NC
echo ""
pause 'Press [ENTER] for a next stage...'
echo ""
echo -e $YELLOW"Can access both times; display message appear"$NC
echo ""
echo -e $GREEN"IF both works, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo -e $YELLOW"Turn back all frt servers!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "www webiste backend round-robin"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"MANUAL CHECKING! MANUAL CHECKING! MANUAL CHECKING!"$NC
echo ""
echo ""
echo -e $YELLOW"Firefox: https://www.firmatpolsa.pl"$NC
echo -e $YELLOW"Reload a site few times (Ctrl+F5) Served by tag need to changes"$NC
echo ""
echo -e $GREEN"IF served by changed randomly, ITEM iS OK"$NC
echo -e $RED"BUT IF NOT, ITEM IS FAILED"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""

echo -e $PURPLE"######################################################################################"
echo "HA cluster deployment"
echo -e "######################################################################################"$NC
echo ""

echo -e $CYAN"JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT! JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo ""
echo -e $YELLOW"Browse http(s)://www.firmatpolska.pl, shut down frt and bck servers one-by-one, start with VRRP master and reload the website every time when one server shut down. Look the served by tag. Site need to work every time."$NC
echo ""
pause 'Press [ENTER] key to continue...'
echo -e $YELLOW"Best: Backend server servs website roud-robin. AND Backend server fail-over working AND frontend failover, load-balancing working"$NC
echo -e $CYAN"IT IS A TIME FOR JUDGEMENT!"$NC
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "FTP working"
echo -e "######################################################################################"$NC
echo ""
		echo "open -p 990 -u webmaster:Passw0rd! ftps://www.firmatpolska.pl" > ftpConn.txt
		echo "set net:max-retries 2" >> ftpConn.txt
		echo "set net:reconnect-interval-base 3" >> ftpConn.txt
		echo "ls -a > testconnect.txt" >> ftpConn.txt

		lftp -f ftpConn.txt

	if [  $( ls -l | grep -c testconnect.txt ) = 1 ]
	then  
		 echo -e $GREEN"OK - FTP working"$NC
	else
		 echo -e $RED"FAILED - FTP working"$NC
			echo "-----------------------------------------------------------------"
			lftp -f ftpConn.txt
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"FTP must connect."$NC
	fi
echo ""
pause 'Press [ENTER] key to continue...'
clear
echo ""
echo -e $PURPLE"######################################################################################"
echo "FTP rights"
echo -e "######################################################################################"$NC
echo ""
		echo "$(echo $RANDOM | md5sum | head -c 20; echo;)" > linux_the_best

		echo "open -p 990 -u webmaster:Passw0rd! ftps://www.firmatpolska.pl" > ftpConn.txt
		echo "set net:max-retries 2" >> ftpConn.txt
		echo "set net:reconnect-interval-base 3" >> ftpConn.txt
		echo "put linux_the_best" >> ftpConn.txt

		lftp -f ftpConn.txt

		mv linux_the_best linux_the_best_ftp
		sleep 20
		wget -q --no-check-certificate https://www.firmatpolska.pl/linux_the_best
		diff linux_the_best linux_the_best_ftp > /dev/null

	if [  $? -eq 0 ]
	then  
		 echo -e $GREEN"OK - FTP rights"$NC
	else
		 echo -e $RED"FAILED - FTP rights"$NC
			echo "-----------------------------------------------------------------"
					lftp -f ftpConn.txt
					mv linux_the_best linux_the_best_ftp
					sleep 20
					wget -q --no-check-certificate https://www.firmatpolska.pl/linux_the_best
					diff linux_the_best linux_the_best_ftp > /dev/null
				echo "-----------------------------------------------------------------"
				echo -e $YELLOW"Can upload to FTP and download the same file from webserver."$NC
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