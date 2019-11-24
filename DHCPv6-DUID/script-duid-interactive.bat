::## Author: Daniel Ospina GitHub: danielospina-b
@echo off
SETLOCAL EnableDelayedExpansion

:: Check for Administrator Rights
net session >nul 2>&1
if %errorLevel% == 0 (
	goto scriptStart
) else (
	echo This Script must be run as Administrator. Exiting...
	pause
	exit
)

:: Start Script - Print info for the user ::
:scriptStart
echo.
echo ######## IPv6 DUID Configuration Script ########
echo.
echo.

:: Print Every Adapter description and MAC Address, and prompt user to check it ::
for /f "usebackq tokens=2,3 delims=," %%a in (`getmac /fo csv /v /nh`) do (
	echo %%~a %%~b
	SET /P "CONFIRM= >>> Is this the correct network adapter (Y/[N])?: "
	IF /I "!CONFIRM!"=="Y" (
		SET MAC=%%~b
		GOTO :SETDUID
	)
	echo.
)
echo MAC Address not selected, exiting...
pause
exit

:SETDUID
echo.
echo Selected MAC Address: %MAC%

:: Remove dashes from MAC address and set the prefix ::
set MAC=%MAC:-=%
set PREFIJO=00010001EC10EC10

:: Ask user to cancel execution if something is wrong ::
echo Setting DUID as: %PREFIJO%%MAC%
echo.

:: Add to the registry the value (/v) of type (/t) binary with the DUID as data (/d) and without prompting confirmation (/f)::
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters /v Dhcpv6DUID /t REG_BINARY /d %PREFIJO%%MAC% /f

echo Please Restart Windows to Apply Changes
pause
