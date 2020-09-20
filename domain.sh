#!/bin/bash

## Usage: domain.sh URL
##
## Shell script written by Steven Blakely with the goal of
## speeding up the lookup process of a customers domain
##
##


if [ $# -eq 0 ]; then
    echo 
    echo "Usage: domain.sh URL"
    echo "You can create your on alias in ~/.bashrc or"
    echo "~/.bash_profile to get to the script quickly"
    echo 
    exit 1
fi

clear

DOMAIN=$1

echo
echo ++++++++++++++++++++++++++++
echo ++++++++++++++++++++++++++++
echo ++++++++++++++++++++++++++++
echo ++++++++++++++++++++++++++++
echo ++++++++++++++++++++++++++++
echo
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo "++++ dig $DOMAIN ++++"
/usr/bin/dig $DOMAIN  | grep -v "HINFO"
echo
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo "++++ host $DOMAIN ++++"
host $DOMAIN
echo
WHO=$(whois $DOMAIN)
REGISTAR=$(echo "$WHO" | grep "Registrar:" | tail -1)
echo "$REGISTAR"
echo "$WHO" | grep "Registrant Name:"
echo "$WHO" | grep "Registrant Organization:"
echo "$WHO" | grep "Date" | grep -v Z
echo
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
HOST="$HOST $(host $DOMAIN | grep "has address" | cut -d' ' -f 4)"
for i in $HOST;
do
    echo "++++ host $i ++++"
    host $i
    echo
    WHOIP=$(whois $i)
    echo "$WHOIP" | grep "inetnum:"
    echo "$WHOIP" | grep "netname:"
    echo "$WHOIP" | grep "CIDR:"
    echo "$WHOIP" | grep "Organization:" | grep -v "network:"
    echo "$WHOIP" | grep "Customer:"
    echo "$WHOIP" | grep "OrgId:"
    echo "$WHOIP" | grep "ddress:" | head -n1
    echo "$WHOIP" | grep "ddress:" | grep uite
    echo "$WHOIP" | grep "City:" | head -n1
    echo "$WHOIP" | grep "StateProv:" | head -n1
    echo "$WHOIP" | grep "Country:" | head -n1
    echo
    
done

echo
echo "This shell script written by Steven Blakely."
echo

