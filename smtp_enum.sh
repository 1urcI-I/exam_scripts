#!/bin/bash

ip1= $1

#Attempt to verify usernames with VRFY command and usernames
nc $ip1 25
for name in $(cat /usr/share/wordlists/SecLists/Usernames/top-usernames-shortlist.txt); do echo "VRFY $name"; done
echo exit
echo quit

echo "Done guessing names"
echo "SMTP Enumeration checks complete"
echo "======================================"
