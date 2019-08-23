# Windows Internet Test/Probe for IPv6 Registry Scripts

These scripts intend to fix the limited connectivity icon when using NAT64 as IPv6 transition solution.

![Imgur](https://imgur.com/YdvoZCX.png)

## Fix Probe by changing hosts

This script changes the default native IPv6 address to the equivalent NAT64 Prefix + IPv4 address, and changes the test hostname ipv6.msftconnecttest.com to the IPv4 one, www.msftconnecttest.com

It is also possible to change this settings to a custom server.

## Disable Internet Probing

This script disables the probe completely. The icon will always show connectivity when a Ethernet cable is connected.

## Start Registry Editor at this settings location

This script requires the RegJump utility in the same location, when executed it opens the registry editor at the Internet Connection Test settings.
