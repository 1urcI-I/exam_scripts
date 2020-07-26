#!/bin/bash

#Script for use in OSCP enumeration
#Runs multiple nmap scripts and others to enumerate the machines on the network
#Accepts list of target IPs and runs checks against those hosts

#---------------------------------------
echo "Beginning masscan of all ports"
#---------------------------------------
#Find open ports to begin manual scoping

masscan -p1-65535,U:1-65535 $1 --rate=800 -e tun0 > results/masscan.txt

echo "Beginning nmap scan, SYN, -A flag"
#Basic nmap SYN scan, high intensity, OS and service detection, no ping
nmap -T4 -A -Pn -vv -oG results/nmap_syn $1
echo "Beginning nmap scans, UDP flag"
#Basic UDP scan
nmap -sU -vv --top-port=200 --host-timeout=2m -oG results/nmap_udp $1

echo "nmap complete, begin port-specific enumeration..."
echo "================================================="
#Read results for further enumeration
#
#
#
#
#

#DNS enumeration
#If DNS is open on port 53, run dns enumeration scripts
#./dns_enum.sh $ip1 $domain

#If HTTP is available on port 80, run web enumeration scripts
./http_enum.sh $1

#If HTTPS is available on port 443, run web enumeration scripts
./https_enum.sh $1

#If FTP is open on port 21, run ftp checks
#./ftp_enum.sh

#If SMB is available on ports 139 and 445, run smb checks
#./smb_enum.sh $ip1 $domain

#If SNMP is available on ports 161 or 162, run SNMP checks
#./snmp_enum.sh

#IF SMTP is open on port 25, enumerate the service
#./smtp_enum.sh $ip1

