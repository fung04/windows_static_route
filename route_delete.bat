@echo off
cd /d "%~dp0"
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Deleting route 192.168.0.0/16
    echo Deleting route 104.104.104.140/32
    echo Deleting route 172.16.31.0/24
    (
        route delete 192.168.0.0 mask 255.255.0.0
        route delete 104.104.104.140 mask 255.255.255.255
        route delete 172.16.31.0 mask 255.255.255.0
        echo.
        echo Current routing table after deletions:
        route print
    ) > route_delete_result.txt 2>&1
    echo Operation completed. Results saved in route_delete_result.txt
    route print
    pause
) ELSE (
    echo Requesting administrative privileges.
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit
)