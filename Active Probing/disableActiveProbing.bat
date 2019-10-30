@echo off
echo Disabling Internet Connectivity Test (Active Probing) in Registry...
echo ===================================================
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet /v EnableActiveProbing /t REG_DWORD /d 0 /f
echo ===================================================
echo Done.
pause