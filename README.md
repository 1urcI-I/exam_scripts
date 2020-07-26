Runs several scripts against network to perform basic enumeration and vulnerabilty testing

1) Create directory structure, each ip getting a directory to output files

2) run masscan & nmap against the individual IPs

3) Grep the enumeration scripts, create list of ports to run vulnerabilty scripts against

4) Perform vulnerabilty scans against the open ports in order of available attack surface

5) Run more detailed enumeration to find other open ports (-p- scan)

6) Brute forcing scripts

7) 
