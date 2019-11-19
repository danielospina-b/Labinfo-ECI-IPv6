if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
hostname
Invoke-WebRequest -Uri http://10.2.65.88/daniel.ospina-b/labinfo-eci-ipv6/raw/labinfo/DHCPv6-DUID/windows-auto/duid-auto-realtek.bat -OutFile C:\Temp\ipv6-script.bat; cmd.exe /c 'C:\Temp\ipv6-script.bat'; del 'C:\Temp\ipv6-script.bat';
pause