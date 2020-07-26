#!/bin/bash

ip1= $1
domain= $2

#Begin smb enumeration based on open ports 139 and 445
echo "======================================================="
echo "Starting SMB enumeration commands against $ip1"

#--------------------------------------
#------- Enumeration ------------------
#--------------------------------------
echo "Running nmblookup..."
nmblookup -A $ip1
nbtscan -r $ip1

echo "Running enum4linux, saving into file..."
enum4linux -a $ip1 > enum4linux.txt
echo "enum4linux complete."

echo "Listing shares with smbclient..."
smbclient -L \\$ip1

echo "Running nse enumeration scripts and smb security mode"
nmap --script "smb-enum*" -p 139,445 -oG nse_smbenum $ip1
nmap --script "smb-security-mode" -v -p 139,445 -oG smb_sec $ip1

#==========================================
#--------SMB null login--------------------
#==========================================
echo "Testing for null logins..."
"First running smbclient...."
echo "exit" | smbclient -L \\\\$ip1
echo"Now running rpcclient..."
rpcclient -U "" -N $ip1

echo "Check files for open shares, null logins, etc."
echo "END OF SMB ENUM SCRIPT"
echo "======================================================="



