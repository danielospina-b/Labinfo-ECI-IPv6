#!/bin/sh
## Author: Daniel Ospina GitHub: danielospina-b

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Print info for the user
echo "\n········ IPv6 DUID Configuration Script ········"
echo "\nThis file contains comments, in case the script does not work as expected...\n"

# Prints a list of all MAC Addresses using ip addr show, then picks the first one
echo "Printing all MAC Addresses..."
echo "============================="
ip addr show | grep -Po 'link/ether \K.*$' | awk '{print $1;}'
echo "=============================\n"

# grep gets the line that shows the MAC Address from a 'ethernet' interface 
# and awk gets the first line ("NR==1")  and the first column ("print $1;")
MAC_ADDRESS=$(ip addr show | grep -Po 'link/ether \K.*$' | awk 'NR==1{print $1;}')
# If the script does not use the correct MAC address 
# change 'NR==1' to 'NR=2' to use the second MAC addres from the list...

echo MAC Address used in DUID: $MAC_ADDRESS

# Removes previous dhcp6 client configuration file and creates a new file with the new DUID value.
rm -rf /etc/dhcp/dhclient6.conf
touch /etc/dhcp/dhclient6.conf
echo interface "eno1" { >> /etc/dhcp/dhclient6.conf
echo "    " send dhcp6.client-id 00:01:00:01:ec:10:ec:10:$MAC_ADDRESS\; >> /etc/dhcp/dhclient6.conf
echo } >> /etc/dhcp/dhclient6.conf

# Print Results
echo "New DHCP6 Client DUID value : 00:01:00:01:ec:10:ec:10:\e[4m$MAC_ADDRESS\e[24m"
echo "\nDone."
