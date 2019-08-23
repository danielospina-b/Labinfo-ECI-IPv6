# Script for Modifying DUID used for DHCPv6

This scripts are useful when IPv6 address reservation is needed, and OS reinstalls are common.

## Windows

This script modifies the DUID by extracting the MAC address and adding a custom time value, then using REG to modify the corresponding registry entry.

All MAC addresses are printed for checking purposes.

## Linux

This script creates a new dhclient6.conf file used by the OS in the DHCP process with the needed configuration data.
