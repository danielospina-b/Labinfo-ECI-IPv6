@setlocal enableextensions
@cd /d "%~dp0"
.\regjump.exe HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters

:: Line 1 and 2 sets the "Running path" to the current folder, so .\regjump.exe in the same folder is used