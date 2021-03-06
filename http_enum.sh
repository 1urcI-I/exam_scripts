#!/bin/bash

#Run http enumerations tasks against a given ip address



#==================================================
#______________________robots.txt__________________
#==================================================

echo "Grabbing robots.txt, if it exists..."
curl http://$1/robots.txt

#==================================================
#______________________Nikto_______________________
#==================================================

echo "Running nikto against the given ip..."
nikto -h $1 > results/http_nikto.txt
echo "Finished with nikto, check the file."

#==================================================
#_________________wfuzz for hosts_________________
#==================================================
echo "Running wfuzz to uncover virtual hosts..."
wfuzz -c -w /usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt -H "Host:FUZZ.$2" $1 > results/wfuzz_http_hosts.txt
echo "WFUZZ is done, checking your file for 200 or 300 responses"
grep ":   200      " results/wfuzz_http_hosts.txt
grep ":   300      " results/wfuzz_http_hosts.txt

#==================================================
#____________dirb against base url________________
#==================================================
echo "dirb with common.txt against base directory ONLY"
echo "You should run this again against any subdirectories, or other virtual hosts!!!"

dirb /usr/share/wordlists/dirb/common.txt http://$1 -wro results/http_dirb_common_base.txt

echo "End of HTTP Enumeration Script."
echo "==========================================================="
