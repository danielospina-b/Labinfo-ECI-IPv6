@echo off
::## Author: Daniel Ospina GitHub: danielospina-b

:: Change next line if at runtime the MAC Address is not correct ::
set ADAPTER=Realtek
:: use a unique word of the network adapter description (like brand name).
:: use "ipconfig /all" to see network adapter descriptions.

:: Print info for the user
echo.
echo ######## IPv6 DUID Configuration Script ########
echo.
echo This file contains comments, in case the script does not work as expected...
echo.

:: Get MAC Address based on the ADAPTER variable ::
for /f "usebackq tokens=3 delims=," %%a in (`getmac /fo csv /v ^| find "%ADAPTER%"`) do set MAC=%%~a
echo MAC Address to be used: %MAC%
echo.

:: Remove dashes from MAC address and set the prefix ::
set MAC=%MAC:-=%
set PREFIJO=00010001ec10ec10

:: Ask user to cancel execution if something is wrong ::
echo Setting DUID as: %PREFIJO%%MAC%
echo If MAC Address is incorrect please press CTRL+C now to prevent changes in Windows Registry.
pause

:: Add to the registry the value (/v) of type (/t) binary with the DUID as data (/d) and without prompting confirmation (/f)::
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters /v Dhcpv6DUID /t REG_BINARY /d %PREFIJO%%MAC% /f

echo Please Restart Windows to Apply Changes
pause