@echo off
cls
ping localhost -n 3 >nul

:bootloader
if exist "%userprofile%\desktop\CommandPower\CommandPower.cp" (
    goto restartcp
) else if exist "%userprofile%\desktop\WinBatchBox.cp" (
    goto bootwbb
) else (
    echo You Don't Have Any OS
    pause
    exit
)

:restartcp
for /f "usebackq delims=" %%a in ("c:\CommandPower\Sys32\STOP.txt") do (
    if /i "true"=="%%a" (
        rmdir /s /q "c:\CommandPower"
        goto startcp
    )
)
goto startcp

:startcp
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
goto bootcp

:bootcp
set "cp_file=c:\CommandPower\Sys32\CommandPower.cp"
if not exist "%cp_file%" (
    echo Error: %cp_file% not found.
    goto home
)

echo.
echo 1. CommandPower
echo 2. WinBatchBox
set /p inp="Enter Number: "
if /i "%inp%"=="1" goto bootcp_commandpower
if /i "%inp%"=="2" goto bootcp_winbatchbox
goto home

:bootcp_commandpower
start "c:\CommandPower\CommandPower.bat"
exit

:bootcp_winbatchbox
set "wbb_file=%userprofile%\desktop\WinBatchBox.cp"
if not exist "%wbb_file%" (
    echo Error: %wbb_file% not found.
    goto home
)
set "temp_batch=%temp%\temp_batch_%random%.bat"
echo @echo off > "%temp_batch%"
echo cls >> "%temp_batch%"
echo echo Running %wbb_file% >> "%temp_batch%"
echo type "%wbb_file%" ^> "%%temp%%\temp_script.bat" >> "%temp_batch%"
echo start "WinBatchBox" cmd /c "%%temp%%\temp_script.bat" >> "%temp_batch%"
call "%temp_batch%"
del "%temp_batch%"
exit

:home
pause
exit
