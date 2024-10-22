@echo off
cd /d "%~dp0"
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	echo Adding route 192.168.0.0/16 via 192.168.1.1
	echo Adding route 104.104.104.140/32 via 192.168.10.10
	echo Adding route 172.16.31.0/24 via 192.168.1.2
    (
        route add 192.168.0.0 mask 255.255.0.0 192.168.1.1 -p
        route add 104.104.104.140 mask 255.255.255.255 192.168.10.10 -p
        route add 172.16.31.0 mask 255.255.255.0 192.168.1.2 -p
        echo.
        echo Current routing table:
        route print
    ) > route_add_result.txt 2>&1
    echo Operation completed. Results saved in route_add_result.txt
	route print
    pause
) ELSE (
    echo Requesting administrative privileges.
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit
)