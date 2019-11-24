# Script for Modifying DUID used for DHCPv6

This scripts are useful when IPv6 address reservation is needed, and OS reinstalls are common.

All scripts are commented if modification is needed.

## Windows

This script modifies the DUID by extracting the MAC address and adding a custom time value, then using REG to modify the corresponding registry entry.

Two versions are provided:

- An interactive script where user selects the correct MAC address and checks for Administrator privileges.
- A simple script which should be modified manually to work depending on the computer.

## Linux

This script creates a new dhclient6.conf file used by the OS in the DHCP process with the needed configuration data.
