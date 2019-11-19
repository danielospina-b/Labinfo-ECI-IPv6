# Script for Modifying DUID used for DHCPv6

This scripts are useful when IPv6 address reservation is needed, and OS reinstalls are common.

For more information about IPv6 and these concepts, refer to: Libro de Proyecto - Redes IPv6 al Servicio de la Red Empresarial.

## Windows

### script-duid.bat

This script modifies the DUID by extracting the MAC address and adding a custom time value, then using REG to modify the corresponding registry entry.

All MAC addresses are printed for checking purposes.

### IPv6-auto-X.ps1

These scripts are used in Labinfo, after disk copies are made and IPv6 needs to be configured.

It is needed to know the brand of the network adapter, this can be obtained looking at the description of the network interface using:

> ipconfig /all

To run this script, right click > run with PowerShell, the script automatically tries to get Administrator run privileges.

Then downloads the matching .bat script from the Labinfo GitLab Server and puts it in C:\Temp.

The .bat script is executed printing the final DUID value added to the registry, and finally adds the corresponding entry to the IP Prefix Policy Table.

## Linux

This script creates a new dhclient6.conf file used by the OS in the DHCP process with the needed configuration data.
