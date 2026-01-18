@echo off
title PC Info Utility
color 0a

:menu
cls
echo ===================================
echo       PC INFO UTILITY
echo ===================================
echo Commands:
echo /os        - Show Operating System info
echo /cpu       - Show CPU info
echo /memory    - Show RAM info
echo /drives    - List all drives
echo /gpu       - Show GPU info (limited)
echo /network   - Show network info
echo /username  - Show current user
echo /hostname  - Show computer name
echo /uptime    - Show system uptime
echo /docs      - List all endpoints
echo /help      - Show this menu
echo /exit      - Exit
echo ===================================
set /p cmd=Type a command: 

rem Convert command to lowercase
set cmd=%cmd:~0,1%%cmd:~1%
if "%cmd%"=="/os" goto os
if "%cmd%"=="/cpu" goto cpu
if "%cmd%"=="/memory" goto memory
if "%cmd%"=="/drives" goto drives
if "%cmd%"=="/gpu" goto gpu
if "%cmd%"=="/network" goto network
if "%cmd%"=="/username" goto username
if "%cmd%"=="/hostname" goto hostname
if "%cmd%"=="/uptime" goto uptime
if "%cmd%"=="/help" goto menu
if "%cmd%"=="/docs" goto docs
if "%cmd%"=="/exit" goto exit
echo Unknown command. Type /help for commands.
pause
goto menu

:os
cls
echo > You typed: %cmd%
echo --- OPERATING SYSTEM INFO ---
ver
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"
echo.
pause
goto menu

:cpu
cls
echo > You typed: %cmd%
echo --- CPU INFO ---
echo Processor: %PROCESSOR_IDENTIFIER%
echo Cores: %NUMBER_OF_PROCESSORS%
echo.
pause
goto menu

:memory
cls
echo > You typed: %cmd%
echo --- MEMORY INFO ---
systeminfo | findstr /C:"Total Physical Memory"
echo.
pause
goto menu

:drives
cls
echo > You typed: %cmd%
echo --- DRIVES INFO ---
for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%D:\ (
        set "drive=%%D:"
        call :get_drive_info %%D
    )
)
echo.
pause
goto menu

:get_drive_info
set drv=%1
echo Drive %drv%:\
for /f "tokens=3" %%a in ('dir %drv%\ ^| find "bytes free"') do set free=%%a
echo   Free Space: %free%
goto :eof

:gpu
cls
echo > You typed: %cmd%
echo --- GPU INFO ---
echo GPU info not available in pure CMD mode.
echo.
pause
goto menu

:network
cls
echo > You typed: %cmd%
echo --- NETWORK INFO ---
ipconfig /all
echo.
pause
goto menu

:username
cls
echo > You typed: %cmd%
echo --- CURRENT USER ---
whoami
echo.
pause
goto menu

:hostname
cls
echo > You typed: %cmd%
echo --- COMPUTER NAME ---
hostname
echo.
pause
goto menu

:uptime
cls
echo > You typed: %cmd%
echo --- SYSTEM UPTIME ---
net stats workstation | find "Statistics since"
echo.
pause
goto menu

:docs
cls
echo > You typed: %cmd%
echo --- ALL ENDPOINTS ---
echo /os        - Show Operating System info
echo /cpu       - Show CPU info
echo /memory    - Show RAM info
echo /drives    - List all drives
echo /gpu       - Show GPU info (limited)
echo /network   - Show network info
echo /username  - Show current user
echo /hostname  - Show computer name
echo /uptime    - Show system uptime
echo /docs      - List all endpoints
echo /help      - Show menu
echo /exit      - Exit the program
echo.
pause
goto menu

:exit
cls
exit
