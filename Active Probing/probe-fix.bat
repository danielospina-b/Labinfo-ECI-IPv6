@echo off
echo Modifying Internet Connectivity Test in Registry...
echo ===================================================
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet /v ActiveDnsProbeContentV6 /t REG_SZ /d 64:ff9b::836b:ffff /f
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet /v ActiveWebProbeHostV6 /t REG_SZ /d www.msftconnecttest.com /f
echo ===================================================
echo All registry entries have been modified.
pause