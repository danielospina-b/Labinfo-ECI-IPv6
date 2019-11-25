@echo off
echo Hostname: %COMPUTERNAME%
echo.
::## Author: Daniel Ospina GitHub: danielospina-b

:: Change next line if at runtime the MAC Address is not correct ::
set ADAPTER=Wireless

:: Get MAC Address based on the ADAPTER variable, and prompts the user to check it ::
for /f "usebackq tokens=3 delims=," %%a in (`getmac /fo csv /v ^| find "%ADAPTER%"`) do set MAC=%%~a

:: Remove dashes from MAC address and set the prefix ::
set MAC=%MAC:-=%
set PREFIJO=00010001ec10ec10

:: Ask user to cancel execution if something is wrong ::
echo Setting DUID as: %PREFIJO%%MAC%

:: Add to the registry the value (/v) of type (/t) binary with the DUID as data (/d) and without prompting confirmation (/f)::
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters /v Dhcpv6DUID /t REG_BINARY /d %PREFIJO%%MAC% /f
echo.

:: Set IPv6 Prefix Policy
echo Setting IPv6 Prefix Policy...
netsh interface ipv6 add prefixpolicy fd00:3c1:102::/64 38 1 store=persistent
pause