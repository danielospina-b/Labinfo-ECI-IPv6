#!/bin/sh
## Author: Daniel Ospina GitHub: danielospina-b

# Set here the ADAPTER to extract MAC address
ADAPTER=eno1

# Make sure script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Print info for the user
echo "\n········ IPv6 DUID Configuration Script ········"
echo "\nThis file contains comments, in case the script does not work as expected...\n"

# Prints a list of all Adapters and its MAC Addresses using ip addr show
echo "Printing all adapters and MAC Addresses..."
echo "============================="
ip addr show | grep -B 1 -P 'link/ether \K.*$' | awk '{print $2;}'
echo "============================="
echo "Set the correct adapter name in line 5 of this script"
echo "=============================\n"

# ip addr show output is sent to grep to find the adapter name and the next line
# that output is sent again to grep to get the MAC address, which lies after link/ether
# and awk parses the result and gets the first word/column ("print $1;")
MAC_ADDRESS=$(ip addr show | grep -A 1 $ADAPTER: | grep -Po 'link/ether \K.*$' | awk '{print $1;}')

# Print the results to the user
echo Selected adapter: $ADAPTER
echo MAC Address used in DUID: $MAC_ADDRESS

# Removes previous dhcp6 client configuration file and creates a new file with the new DUID value.
rm -rf /etc/dhcp/dhclient6.conf
touch /etc/dhcp/dhclient6.conf
echo interface $ADAPTER { >> /etc/dhcp/dhclient6.conf
echo "    " send dhcp6.client-id 00:01:00:01:ec:10:ec:10:$MAC_ADDRESS\; >> /etc/dhcp/dhclient6.conf
echo } >> /etc/dhcp/dhclient6.conf

# Print Results
echo "New DHCP6 Client DUID value : 00:01:00:01:ec:10:ec:10:\e[4m$MAC_ADDRESS\e[24m\n"

echo "Setting IP Prefix Policy..."

# Prefix Policy is controlled by /etc/gai.conf
# Default policy lines are added plus labinfo prefix
tee -a /etc/gai.conf << END > /dev/null
label ::1/128       0
label ::/0          1
label fd00:3c1:102::/64 1 ## <<<<< Labinfo prefix
label 2002::/16     2
label ::/96         3
label ::ffff:0:0/96 4
label fec0::/10     5
label fc00::/7      6
label 2001:0::/32   7

precedence  ::1/128       50
precedence  ::/0          40
precedence fd00:3c1:102::/64 38 ## <<<<< Labinfo prefix
precedence  2002::/16     30
precedence ::/96          20
precedence ::ffff:0:0/96  10
END

echo "\nDone."
