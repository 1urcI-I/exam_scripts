#!/bin/bash

#If port 53 is open on UDP, begin DNS enumeration


#Print first few lines of /etc/hosts to check IP to host mappings
echo "First 15 lines of /etc/hosts: "
head -n 15 /etc/hosts

#Check mail server and name server
echo "checking for mail and DNS servers, saving to file"
host -t ns $2 | cut -d " " -f 4 > nameservers.txt
host -t mx $2 | cut -d " " -f 6 > mailservers.txt

#reverse dns lookup
host $1

# check for subdomains/virtual hosts, i.e. forward lookup
#for sub in $(cat /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt); do host $sub.$domain; done

# Attempt zone transfers

echo "Beginning zone transfer attempts..."
echo "Loading DNS servers from local file"

for ns in $(cat nameservers.txt);host -l $2 $ns; done
for ns in $(cat nameservers.txt); nmap --script=dns-zone-transfer -p 53 $ns; done

dnsenum $domain
dnsrecon -d $2 -t axfr $1
echo "Zone transfer attempts complete."
echo "End of DNS enumeration script."



