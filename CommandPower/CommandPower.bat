@echo off

cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %Apply%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
call :isAdmin
if %errorlevel% == 0 (
    goto start
) else (
    echo.
)

:isAdmin
fsutil dirty query %systemdrive% >nul
exit /b %errorlevel%

:start

title CommandPower

setlocal EnableDelayedExpansion

mkdir "c:\CommandPower"
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
set ATHOS=CommandPower 1.0.3
set input=Nothing
set title=not set
set message=not set
set /p input="%cd% ~ @%user_name% ~ Enter Command: "
echo %input%>> "C:\CommandPower\Sys32\history.txt"
if /i "%input%"=="exit" goto exit
if /i "%input:~0,4%"=="say:" goto say
if /i "%input:~0,5%"=="open:" goto open
if /i "%input:~0,5%"=="calc:" goto calc
if /i "%input:~0,5%"=="stop:" goto stop
if /i "%input:~0,4%"=="app:" goto apps
if /i "%input:~0,5%"=="wait:" goto wait
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
if /i "%input%"=="editxt" goto editxt
if /i "%input%"=="CPHR" goto CPHR
if /i "%input%"=="ctc" goto ctc
if /i "%input%"=="msg" goto msg
if /i "%input%"=="cfsm" goto cfsm
if /i "%input%"=="cp" goto cp
if /i "%input%"=="$" goto cp
if /i "%input%"=="gthome" goto gthome
if /i "%input%"=="$home" goto gthome
if /i "%input%"=="opnhome" goto opnhome
if /i "%input%"=="alld" goto alld
if /i "%input%"=="$ARTIK" goto artik
if /i "%input%"=="settings" goto settings
if /i "%input%"=="@@@" goto settings
if /i "%input%"=="chgu" goto chgu
if /i "%input%"=="history" goto history
if /i "%input%"=="clrhistory" goto clrhistory
if /i "%input%"=="help" goto help
if /i "%input%"=="$edit" goto edit
if /i "%input%"=="shutc" goto shutc
if /i "%input%"=="restc" goto restc
if /i "%input%"=="?" goto help
goto error

:error
echo %input% is a Invalid Command!
goto home

:exit
exit

:pause
pause
goto home

:wait
ping localhost -n %input:~5% >nul
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

:editxt
set /p "filename=Enter filename: "
start notepad "%cd%\%filename%"
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

:history
type "C:\CommandPower\Sys32\history.txt"
goto home

:clrhistory
del "C:\CommandPower\Sys32\history.txt"
echo. > "C:\CommandPower\Sys32\history.txt"
goto home

:apps
setlocal

set "cp_file=c:\CommandPower\Sys32\APPS\%input:~4%\%input:~4%.cp"
if not exist "%cp_file%" (
    echo Error: %cp_file% not found.
    goto home
)
set "temp_batch=%temp%\temp_batch_%random%.bat"
echo @echo off > "%temp_batch%"
echo cls >> "%temp_batch%"
echo echo Running %cp_file% >> "%temp_batch%"
echo type "%cp_file%" ^> "%%temp%%\temp_script.bat" >> "%temp_batch%"
echo start "CommandPower" cmd /c "%%temp%%\temp_script.bat" >> "%temp_batch%"
call "%temp_batch%"
del "%temp_batch%"
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
        echo %ATHOS%
        goto home
    )
)
goto error

:settings
cls
echo Choose Setting
echo 0.Exit
echo 1.User
echo 2.Home
echo 3.Version
set /p "sc=What Setting: "
if /i "%sc%"=="exit" goto exit/settings
if /i "%sc%"=="0" goto exit/settings
if /i "%sc%"=="1" goto settings/user
if /i "%sc%"=="2" goto settings/home
if /i "%sc%"=="3" goto settings/version
goto settings

:exit/settings
cls
goto home

:settings/user
echo %user_name%
pause
cls
goto home

:settings/home
echo Location Of Home Is "c:\CommandPower\home"
cd /d "c:\CommandPower\home"
pause
cls
goto home

:settings/version
echo %ATHOS%
pause
cls
goto home

:chgu
set /p user_name="Enter UserName: "
echo %user_name%> "c:\CommandPower\user\user.txt"
cls
goto home

:shutc
shutdown /s /f /t 0
goto home

:restc
shutdown /r /f /t 0
goto home

:help
echo exit (It Will Exit The Program)
echo say:#something you want# (It Will Print Things To The Screen)
echo start:#something you want to open# (It Will Open Any App That You Want)
echo calc:#something you want to calculate# (It Will Calculate Things)
echo stop:#something you want to stop# (It Will Stop Any App That You Want)
echo app:#CP App Store Apps# (It Will Open Any CP App Store Apps)
echo wait:#seconds# (It Will Wait For That Amount Of Seconds)
echo clrscr (It Will Clear The Screen)
echo ipid (It Will Show The Ip Stuff)
echo mkfolder (Makes Folder In The Zone You Are)
echo mkfolder/open (Makes Folder And Opens It In The Zone You Are)
echo delfolder (It Will Delete A Folder In The Zone You Are)
echo mkfile (Makes File In The Zone You Are)
echo mkfile/open (Makes File And Opens It In The Zone You Are)
echo delfile (It Will Delete A File In The Zone You Are)
echo pause (It Will Pause The CommandPower)
echo networks (It Will Show The Available Networks In The Aria)
echo networks\all (It Will Show All The Networks You Have Been Connected)
echo networks\sec (It Will Show The Things About A Network)
echo ctc (Change Text Color)
echo msg (It Sends A Message To A Network)
echo cfsm (Change Full Screen Mode)
echo "cp" or "$" (Change Path)
echo "gthome" or "$home" (Goes To Home)
echo opnhome (Opens Home)
echo alld (Shows The Files And Folders In A Folder Or Drive)
echo editxt (It Will Edit .txt Files)
echo "settings" or "@@@" (It Goes To Settings)
echo chgu (Change User)
echo shutc (It Will Shutdown The Computer)
echo restc (It Will Restart The Computer)
echo history (It Will Show The CommandPower History)
echo clrhistory (It Will Clear The CommandPower History)
echo "help" or "?" (It Helps A Lot)
goto home

:edit
for /f "usebackq delims=" %%a in ("c:\CommandPower\SecSys32\CommandsLock\CommandLock1.txt") do (
    if /i "%user_name%"=="%%a" (
        start notepad %userprofile%\Desktop\CommandPower\CommandPower.bat
        goto home
    )
)
goto error
