@echo off
::## Author: Daniel Ospina GitHub: danielospina-b

:: Change next line if at runtime the MAC Address is not correct ::
set ADAPTER=Realtek

echo Printing all MAC Addresses in PC...
getmac /v
echo =================================================================
echo.

:: Get MAC Address based on the ADAPTER variable, and prompts the user to check it ::
for /f "usebackq tokens=3 delims=," %%a in (`getmac /fo csv /v ^| find "%ADAPTER%"`) do set MAC=%%~a
echo Please check the MAC Address is Correct: %MAC%
echo.
echo =================================================================
echo If it is not correct, edit the script in line 5 to match an unique word of the network adapter. Using the command "getmac /fo csv /v", where each line is a network adapter. Usually words like "Intel" or "Realtek" are good enough.
echo =================================================================
echo.

:: Remove dashes from MAC address and set the prefix ::
set MAC=%MAC:-=%
set PREFIJO=00010001ec10ec10

:: Ask user to cancel execution if something is wrong ::
echo Setting DUID as: %PREFIJO%%MAC%
echo if MAC Address is Wrong please press CTRL+C now to prevent changes in Windows Registry 
pause

:: Add to the registry the value (/v) of type (/t) binary with the DUID as data (/d) and without prompting confirmation (/f)::
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters /v Dhcpv6DUID /t REG_BINARY /d %PREFIJO%%MAC% /f

echo Please Restart Windows to Apply Changes
pause