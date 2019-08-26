#!/bin/sh
## Author: Daniel Ospina GitHub: danielospina-b

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#Look for MAC Address using ip addr show
#If the script fails change 'link/ether' to match the output of the line that shows the mac address
#In short, grep gets the line that show MAC Address and awk gets the first "word" that line
MAC_ADDRESS=$(ip addr show | grep -Po 'link/ether \K.*$' | awk '{print $1;}')
# TODO Fix VMWare interfaces
echo MAC Address used in DUID: $MAC_ADDRESS
rm -rf /etc/dhcp/dhclient6.conf
touch /etc/dhcp/dhclient6.conf
echo interface "eno1" { >> /etc/dhcp/dhclient6.conf
echo "    " send dhcp6.client-id 00:01:00:01:ec:10:ec:10:$MAC_ADDRESS\; >> /etc/dhcp/dhclient6.conf
echo } >> /etc/dhcp/dhclient6.conf
echo DHCP is now using DUID : 00:01:00:01:ec:10:ec:10:$MAC_ADDRESS
echo Done.
