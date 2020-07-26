#!/bin/bash

# Run some SNMP enumeration commands against the ip address
echo "Beginning SNMP Enumeration..."

echo "Running onesixtyone against $ip1 using 800+ common community strings" 
onesixtyone -c /usr/share/wordlists/SecLists/Discovery/SNMP/common-snmp-community-strings-onesixtyone.txt $ip1

echo "running snmpwalk against public community string, version 1"
echo "use higher version if needed"
snmpwalk -c public -v1 $ip1

#run common enumeration of known Wondows MIB trees

echo "Enumerating windows users"
snmpwalk -c public -v1 $ip1 1.3.6.1.4.1.77.1.2.25
echo "Enumerating running processes"
snmpwalk -c public -v1 $ip1 1.3.6.1.2.1.25.4.2.1.2
echo "Enumerating Open TCP ports"
snmpwalk -c public -v1 $ip1 1.3.6.1.2.1.6.13.1.3
echo "Enumerating Installed software"
snmpwalk -c public -v1 $ip1 1.3.6.1.2.1.25.6.3.1.2

echo "SNMP enumeration complete."
echo "=================================================="
