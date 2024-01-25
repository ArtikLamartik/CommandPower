@echo off

title CommandPower

setlocal EnableDelayedExpansion

mkdir "c:\CommandPower"
mkdir "c:\CommandPower\bin"
mkdir "c:\CommandPower\user"
mkdir "c:\CommandPower\home"
mkdir "c:\CommandPower\Sys32"
mkdir "c:\CommandPower\SecSys32"
mkdir "c:\CommandPower\SecSys32\CommandsLock"
echo ARTIK> "c:\CommandPower\SecSys32\CommandsLock\CommandLock1.txt"

:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 1                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 1                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"

:boot
cd /d "c:\CommandPower\home"
cls
color a
echo *******
echo *ATHOS*
echo *******
echo.
echo The System Is Booting!
echo You Will Have To Wait A Little Bit.
echo Loading
ping localhost -n 5 >nul
if exist "c:\CommandPower\user\user.txt" (
    for /f "usebackq delims=" %%a in ("c:\CommandPower\user\user.txt") do (
        set "user_name=%%a"
        cls
        goto home
    )
) else (
    cls
    goto log
)

:log
set /p user_name="Enter UserName: "
echo %user_name%> "c:\CommandPower\user\user.txt"
cls
echo UserName Is %user_name%
ping localhost -n 3 >nul
cls
goto home

:home
set input=Nothing
set title=not set
set message=not set
set /p input="%cd% ~ @%user_name% ~ Enter Command: "
if /i "%input%"=="exit" goto exit
if /i "%input:~0,4%"=="say:" goto say
if /i "%input:~0,5%"=="open:" goto open
if /i "%input:~0,5%"=="calc:" goto calc
if /i "%input:~0,5%"=="stop:" goto stop
if /i "%input:~0,4%"=="app:" goto apps
if /i "%input%"=="clrscr" goto clrscr
if /i "%input%"=="ipid" goto ipid
if /i "%input%"=="mkfolder" goto mkfolder
if /i "%input%"=="mkfolder/open" goto mkfolder/open
if /i "%input%"=="delfolder" goto delfolder
if /i "%input%"=="mkfile" goto mkfile
if /i "%input%"=="mkfile/open" goto mkfile/open
if /i "%input%"=="delfile" goto delfile
if /i "%input%"=="pause" goto pause
if /i "%input%"=="networks" goto networks
if /i "%input%"=="networks/all" goto all/networks
if /i "%input%"=="networks/sec" goto networks/sec
if /i "%input%"=="CPHR" goto CPHR
if /i "%input%"=="ctc" goto ctc
if /i "%input%"=="msg" goto msg
if /i "%input%"=="clock" goto clock
if /i "%input%"=="cfsm" goto cfsm
if /i "%input%"=="cp" goto cp
if /i "%input%"=="$" goto cp
if /i "%input%"=="gthome" goto gthome
if /i "%input%"=="$home" goto gthome
if /i "%input%"=="opnhome" goto opnhome
if /i "%input%"=="extdrv" goto extdrv
if /i "%input%"=="alld" goto alld
if /i "%input%"=="$ARTIK" goto artik
if /i "%input%"=="setings" goto setings
if /i "%input%"=="@@@" goto setings
if /i "%input%"=="chgu" goto chgu
if /i "%input%"=="delfol" goto delfol
goto error

:error
echo %input% is a Invalid Command!
goto home

:exit
exit

:pause
pause
goto home

:say
echo %input:~4%
goto home

:open
set "app=%input:~5%"
start "" "%app%"
goto home

:clrscr
cls
goto home

:networks
netsh wlan show networks
goto home

:all/networks
netsh wlan show profiles
goto home

:networks/sec
set /p "wifiname=Enter Wifi Name: "
netsh wlan show profiles "%wifiname%" key=clear
goto home

:ipid
ipconfig
goto home

:mkfolder
set /p "folder_name=Enter folder name: "
mkdir "%cd%\%folder_name%"
echo Folder created: "%cd%\%folder_name%"
goto home

:mkfolder/open
set /p "folder_name=Enter folder name: "
mkdir "%cd%\%folder_name%"
echo Folder created: "%cd%\%folder_name%"
start %cd%\%folder_name%
goto home

:delfolder
set /p "folder_name=Enter folder name to delete: "
if exist "%cd%\%folder_name%" (
    rmdir /s /q "%cd%\%folder_name%"
    echo Folder deleted: "%cd%\%folder_name%"
) else (
    echo Folder not found: "%cd%\%folder_name%"
)
goto home

:mkfile
set /p "file_name=Enter file name: "
echo. > "%cd%\%file_name%"
echo File created: "%cd%\%file_name%"
goto home

:mkfile/open
set /p "file_name=Enter file name: "
echo. > "%cd%\%file_name%"
echo File created: "%cd%\%file_name%"
start %cd%\%file_name%
goto home

:delfile
set /p "file_name=Enter file name to delete: "
if exist "%cd%\%file_name%" (
    del "%cd%\%file_name%"
    echo File deleted: "%cd%\%file_name%"
) else (
    echo File not found: "%cd%\%file_name%"
)
goto home

:cphr
start %userprofile%\Desktop\CP.bat
rmdir /s /q "c:\CommandPower"
exit

:calc
set /a ans=%input:~5%
echo %ans%
goto home

:stop
taskkill /F /IM "%input:~5%"
goto home

:ctc
echo    0 = Black       8 = Gray
echo    1 = Blue        9 = Light Blue
echo    2 = Green       A = Light Green
echo    3 = Aqua        B = Light Aqua
echo    4 = Red         C = Light Red
echo    5 = Purple      D = Light Purple
echo    6 = Yellow      E = Light Yellow
echo    7 = White       F = Bright White
set /p "text_color=Enter Text Color: "
color %text_color%
goto home

:msg
set /p "title=Enter Title: "
set /p "message=Enter Message: "
echo msg_popup=msgbox("%message%",,"%title%") >c:\CommandPower\Sys32\msg.vbs
start c:\CommandPower\Sys32\msg.vbs
goto home

:clock
start c:\CommandPower\Sys32\clock.bat
goto home

:cfsm
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 1                                          >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                    >>"%TempVBSFile%"
ECHO Wscript.Sleep 1                                          >>"%TempVBSFile%"
start /min wscript.exe "%TempVBSFile%"
goto home

:cp
set /p "path=Enter path: "
if /i "%path%"=="dt" path=%userprofile%\desktop
cd /d "%path%"
goto home

:apps
start c:\CommandPower\Sys32\APPS\%input:~4%\%input:~4%.bat
goto home

:gthome
cd /d "c:\CommandPower\home"
goto home

:opnhome
start c:\CommandPower\home
goto home

:extdrv
set /p "ed=Enter External Drive Code: "
cd /d "%ed%"
goto home

:alld
echo Files and Folders in This Folder
dir /s
goto home

:artik
for /f "usebackq delims=" %%a in ("c:\CommandPower\SecSys32\CommandsLock\CommandLock1.txt") do (
    if /i "%user_name%"=="%%a" (
        echo Hello, ARTIK
        goto home
    )
)
goto error

:setings
cls
echo Choose Seting
echo 0.Exit
echo 1.User
echo 2.Home
set /p "sc=What Seting: "
if /i "%sc%"=="exit" goto exit/setings
if /i "%sc%"=="0" goto exit/setings
if /i "%sc%"=="1" goto setings/user
if /i "%sc%"=="2" goto setings/home
goto setings

:exit/setings
cls
goto home

:setings/user
echo %user_name%
pause
cls
goto home

:setings/home
echo Location Of Home Is "c:\CommandPower\home"
cd /d "c:\CommandPower\home"
pause
cls
goto home

:chgu
set /p user_name="Enter New UserName: "
echo %user_name%> "c:\CommandPower\user\user.txt"
cls
goto home

:delfol
set /p del="Enter Folder: "
rmdir /s /q "%cd%\%del%"
echo Folder deleted: "%cd%\%del%"
goto home