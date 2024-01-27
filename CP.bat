@echo off

cls
ping localhost -n 3 >nul

:restart
for /f "usebackq delims=" %%a in ("c:\CommandPower\Sys32\STOP.txt") do (
    if /i "true"=="%%a" (
        rmdir /s /q "c:\CommandPower"
        goto start
    )
)
goto start

:start
mkdir "c:\CommandPower"
mkdir "c:\CommandPower\bin"
mkdir "c:\CommandPower\user"
mkdir "c:\CommandPower\home"
mkdir "c:\CommandPower\Sys32"
mkdir "c:\CommandPower\SecSys32"
mkdir "c:\CommandPower\SecSys32\CommandsLock"
echo ARTIK> "c:\CommandPower\SecSys32\CommandsLock\CommandLock1.txt"
echo false> "c:\CommandPower\Sys32\STOP.txt"

set sourceFolder=%userprofile%\Desktop\CommandPower
set destinationFolder=c:\CommandPower\Sys32
robocopy "%sourceFolder%" "%destinationFolder%" /e
cls
goto boot

:boot
start c:\CommandPower\Sys32\CommandPower.bat
exit
