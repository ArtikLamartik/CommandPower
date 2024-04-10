@echo off
setlocal enabledelayedexpansion
set "sdeb=0"
:startup_debug
if "%sdeb%"=="1" (
	echo ==============Info==============
	echo - Start-Up debugging enabled
	prompt $g
	pause
	echo on
)
goto prepare

:prepare
title Shell
color 1f
set "text=0"
goto isAdmin

:welcome
echo ==========Welcome to Win BatchBox==========
echo - To see new features - enter command "whatnew"
echo - Compile date: 4 April 2024, 20:52
echo - Is Admin: %admin%
echo.
goto shell

:isAdmin
	net session >nul 2>&1
	if %errorLevel% == 0 (
		set "admin=True"
		set "prmpt=#"
		title Win BatchBox - Admin
		goto welcome
	) else (
		title Win BatchBox
		set "admin=False"
		set "prmpt=$"
		goto welcome
	)
	
:shell
set command=
echo [%cd%]%prmpt%
set /p "command=>"
if /i "%command%"=="|" (
	echo =============Error!=============
	echo - Piping allowed only for "command1|command2"
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Invalid pipe: "%command%" >> error.log
	goto shell
)
if /i "%command%"==">" (
	echo =============Error!=============
	echo - ">" allowed only for "echo hi > file2" for overwrite or "echo hi >> file2" for adding
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Invalid redirection: "%command%" >> error.log
	goto shell
)
if /i "%command%"=="<" (
	echo =============Error!=============
	echo - "<" allowed only for i don't know
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Invalid input: "%command%" >> error.log
	goto shell
)
if /i "%command%"=="||" (
	echo =============Error!=============
	echo - Piping allowed only for "command1||command2"
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Invalid conditional pipe: "%command%" >> error.log
	goto shell
)
if /i "%command%"=="&" (
	echo =============Error!=============
	echo - Piping allowed only for "command1 & command2"
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Invalid conditional pipe: "%command%" >> error.log
	goto shell
)
if /i "%command%"=="&&" (
	echo =============Error!=============
	echo - Piping allowed only for "command1 && command2"
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Invalid conditional pipe: "%command%" >> error.log
	goto shell
)
if /i "%command%"=="echo on" (
	echo =============Error!=============
	echo - Disallowed command!
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Disallowed command: %command% >> error.log
	goto shell
)
if /i "%command%"=="goto" (
	echo =============Error!=============
	echo - Goto allowed only for "goto test1"
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Invalid "goto" using: "%command%" >> error.log
	goto shell
)
if /i "%command%"=="goto " (
	echo =============Error!=============
	echo - Goto allowed only for "goto test1"
	echo - Error logged in error.log
	echo.
	echo %date% %time% - Invalid "goto" using: "%command%" >> error.log
	goto shell
)
if /i "%command%"=="exit" goto eof
if /i "%command%"=="end" goto eof
if /i "%command%"=="start_sdeb" goto start_sdeb
if /I "%command%" == "isadmin" (
	echo - Rights: %admin%
	echo.
	goto shell
)
if /i "%command%"=="help" (
	echo ====================================
	echo            Win BatchBox Help
	echo ====================================
	echo All built-in commands of Win BatchBox
	echo Some of them are Windows 7+ exclusive
	echo.
	echo ===================Main=================
	echo - Help: Help page
	echo - IsAdmin:  Check administrator rights
	echo - Ver: Version of the Shell and system
	echo - Getcwd: get current directory
	echo - Blankfile: create a blank file
	echo - Randnum: get a random number
	echo - Hello: Hello world
	echo - Matrix: matrix effect
	echo - Whatnew: new in this version
	echo - Exit or end: exit shell. Proper exit
	echo - Debug_on: enable debug
	echo - Debug_off: disable debug
	echo - Verify_on: enable file write verification
	echo - Verify_off: disable file write verification
	echo - Windir: opens Windows system directory
	echo - Temp or tmp: open temp folder
	echo - Crash: crash system or just BSOD
	echo - Textfile: create and edit text file
	echo - Fbsod: fake bsod
	echo - Pctest: perfomance test
	echo - Exp_rest: restart explorer
	echo - Copytext: just fun command
	echo Cmdhist: command history
	rem echo - Start_sdeb: enable Start-Up debug. This is only for developers. Last session will be erased
	echo Guessnumber: guess number game
	echo timer: timer, nothing special
	echo To get Command Prompt help - enter "Help.exe"
	echo.
	echo =================Aliases================
	echo - Clear: clear screen. Alias to "cls"
	echo - Ls: lists content of directory. Alias to "dir"
	echo - Cmd: run Command prompt. Alias to "cmd.exe"
	echo - Powershell: run Powershell. Alias to "powershell.exe"
	echo.
	echo ============User rights mark============
	echo # - administrator rights
	echo $ - regular user rights
	echo.
	goto shell
)
if /i "%command%"=="ver" (
	echo ===========Win BatchBox v2.6.9.7==========
	echo - Creator: WinXP655
	echo - Compile date: 4 April 2024, 20:52
	echo - License: MIT public license
	echo - Download last version: https://github.com/WinXP655/WinBatchBox/releases
	echo - Shell is incompatible: Windows 9x, NT lower Win2000, Linux
	ver
	echo.
	goto shell
)
if /i "%command%"=="clear" (
	cls
	echo.
	goto shell
)
if /i "%command%"=="cls" (
	cls
	echo.
	goto shell
)
if /i "%command%"=="ls" (
	echo ============Listing=============
	dir
	echo.
	goto shell
)
if /i "%command%"=="getcwd" (
	echo %cd%
	echo.
	goto shell
)
if /i "%command%"=="blankfile" (
	echo. > blank
	type blank > blank
	echo ==============Info==============
	echo - Blank file created!
	echo.
	goto shell
)
if /i "%command%"=="cmd" (
	echo ========Opening Cmd.exe=========
	call cmd
	exit
)
if /i "%command%"=="cmd.exe" (
	echo ========Opening Cmd.exe=========
	call cmd
	exit
)
if /i "%command%"=="powershell" (
	echo =====Opening Powershell.exe=====
	call powershell
	exit
)
if /i "%command%"=="powershell.exe" (
	echo =====Opening Powershell.exe=====
	call powershell
	exit
)
if /i "%command%"=="windir" (
	echo ======Opening %systemroot%======
	start %windir%
	echo.
	goto shell
)
if /i "%command%"=="temp" (
	echo ==========Opening %temp%========
	start %temp%
	echo.
	goto shell
)
if /i "%command%"=="tmp" (
	echo ==========Opening %temp%========
	start %temp%
	echo.
	goto shell
)
if /i "%command%"=="randnum" (
	echo Random number: %random%
	echo.
	goto shell
)
if /i "%command%"=="hello" (
	echo Hello, world!
	echo.
	goto shell
)
if /i "%command%"=="crash" (
	echo ========Crashing system=========
	echo - Info: You have some time to kill shell process before crashing system!
	ping localhost -n 8 >nul
	taskkill /f /im svchost.exe
	powershell wininit
	echo.
	echo =============Error!=============
	echo - Unable to crash system
	echo.
	goto shell
)
if /i "%command%"=="matrix" (
	color 0a
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
	ping localhost -n 1 >nul
	pause
	color 1f
	echo.
	goto shell
)
if /i "%command%"=="debug_on" (
	if "%sdeb%"=="1" (
		echo %date% %time% - Start-Up debug already enabled >> error.log
		goto shell
	)
	prompt $g
	echo ==============Info==============
	echo - Debug enabled
	echo on
	goto shell
)
if /i "%command%"=="debug_off" (
	if "%sdeb%"=="0" (
		echo %date% %time% - Start-Up debug already disabled >> error.log
		goto shell
	)
	set "sdeb=0"
	prompt $g
	echo ==============Info==============
	echo - Debug disabled
	echo off
	goto shell
)
if /i "%command%"=="verify_on" (
	verify on
	echo ==============Info==============
	echo - File writing verification enabled
	echo.
	goto shell
)
if /i "%command%"=="verify_off" (
	verify off
	echo ==============Info==============
	echo - File writing verification disabled
	echo.
	goto shell
)
if /i "%command%"=="pause" (
	echo =============Pause==============
	pause
	echo.
	goto shell
)
if /i "%command%"=="textfile" (
	echo ===========Text Edit============
	echo - To save text press "Ctrl+Z"
	copy con text.txt
	pause
	echo.
	goto shell
)
if /i "%command%"=="clean_tmp" (
	echo =======Cleaning %temp%=======
	rd %temp% /s/q
	echo.
	goto shell
)
if /i "%command%"=="shutdown" (
	echo ===========Shutdown==========
	shutdown.exe -s -t 0
)
if /i "%command%"=="reboot" (
	echo ============Reboot===========
	shutdown.exe -r -t 0
)
if /i "%command%"=="logoff" (
	echo ======Log off %username%=====
	shutdown.exe -l
)
if /i "%command%"=="sleep" (
	echo ============Sleep============
	shutdown.exe -h
)
if /i "%command%"=="fbsod" (
	goto fbsod
)
if /i "%command%"=="pctest" (
	goto pctest
)
if /i "%command%"=="explorerrst" (
	echo =======Restarting explorer======
	taskkill /f /im explorer.exe
	start explorer
)
if /i "%command%"=="cmdhist" (
	doskey /history
	echo.
	goto shell
)
if /i "%command:~0,5%"=="timer" (
	set "timerInput=%command:~6%"
	call :startTimer !timerInput!
)
if /i "%command%"=="guessnumber" (
    call :guessNumber
)
if /i "%command%"=="timedate" (
    echo Current date and time: %date% %time%
    echo.
	goto shell
)
if /i "%command:~0,5%"=="kill " (
    taskkill /F /IM "%command:~5%"
    echo.
	goto shell
)
if /i "%command%"=="network" (
    netsh wlan show networks
    echo.
	goto shell
)
if /i "%command%"=="networkall" (
    netsh wlan show profiles
    echo.
	goto shell
)
if /i "%command%"=="networksec" (
    set /p "wifiname=Enter Wifi Name: "
	netsh wlan show profiles "!wifiname!" key=clear
    echo.
	goto shell
)
if /i "%command%"=="whatnew" (
	echo ======New in this version=======
	echo 1. New command - guessnumber, timer, calc, timedate, kill, network, networkall, networksec
	echo 2. Deleted command - copytext, suspend
	echo Good luck using Win BatchBox 2.6.9.7!
	echo.
	goto shell
)

%command%
echo.
set command=
goto shell

:fbsod
mode con: lines=30 cols=80
color 1f
echo A problem has been detected and Windows has been shut down to prevent damage
echo to your computer.
echo.
echo DRIVER_IRQL_NOT_LESS_OR_EQUAL
echo.
echo If this is the first time you've seen this stop error screen.
echo restart your computer. If this screen appears again, follow
echo these steps:
echo.
echo Check to make sure any new hardware or software is properly installed.
echo If this is a new installation, ask your hardware or software manufacturer
echo for any windows updates you might need.
echo.
echo If problems continue, disable or remove any newly installed hardware
echo or software. Disable BIOS memory options such as caching or shadowing.
echo If you need to use safe mode to remove or disable components, restart
echo your computer, press F8 to select Advanced Startup Options, and then
echo select Safe Mode.
echo.
echo Technical information:
echo.
echo *** STOP: 0x000000D1 (0x0000000C, 0x00000002, 0x00000000, 0xF86B5A89)
echo *** null.sys - Address F86B5A89 base at F86B5000, DateStamp 3dd991eb
echo.
echo Beginning dump of physical memory
echo Physical memory dump complete.
echo Contact your system administrator or technical support group for further
echo assistance.
ping localhost -n 10 >nul
echo.
goto shell

:pctest
if exist log.txt (
	echo Renaming log.txt
	ren log.txt log%random%.old
)
setlocal enabledelayedexpansion
echo PC Tester
echo - Log will be saved as: %cd%\log.txt
echo.
:m
set /p lap=Enter number of repeats(laps): 
if not defined lap (
    echo Laps cannot be blank.
    goto m
)
if %lap% leq 0 (
    echo Number must be greater than 0.
    goto m
)
REM Ask for confirmation
set /p confirm=Are you sure to start test with %lap% laps? (Y/N)
if /I "%confirm%" NEQ "Y" (
    echo Test cancelled.
    goto m
)
REM Start the timer
for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "start=(((%%a*60)+1%%b %% 100)*6000+1%%c %% 100*100+1%%d %% 100)/100"
)
:a
for /L %%i in (1,1,%lap%) do (
    set "randomString="
    for /L %%j in (1,1,50) do (
        set /a "rand=(!random!%%10)"
        set "randomString=!randomString!!rand!"
    )
    echo !randomString! >> log_randnum.txt
    echo Lap: %%i/%lap% - completed! >> log.txt
    echo %%i/%lap%
)
REM End the timer
for /f "tokens=1-4 delims=:.," %%a in ("%time%") do (
   set /A "end=(((%%a*60)+1%%b %% 100)*6000+1%%c %% 100*100+1%%d %% 100)/100"
)
REM Calculate the elapsed time
set /A elapsed=end-start
echo Test completed in %elapsed% s >> log.txt
echo Test completed. Time: %elapsed% seconds. Laps: %lap%
echo.
goto shell

:startTimer
set "timer=%1"
set /a "elapsedTime=0"

echo Timer set for %timer% seconds.

:timerLoop
timeout /nobreak /t 1 >nul
set /a "elapsedTime+=1"

if %elapsedTime% lss %timer% (
    goto timerLoop
) else (
    echo Timer expired after %timer% seconds.
	echo.
    goto :shell
)

:guessNumber
set /a "targetNum=!random! %% 100 + 1"
set /a "attempts=0"

echo Welcome to Guess the Number!
echo I've picked a number between 1 and 100.
echo Try to guess it!
echo.

:guessLoop
set /p "userGuess=Your guess: "
set /a "attempts+=1"

if %userGuess% lss %targetNum% (
    echo Too low! Try again.
    goto guessLoop
) else if %userGuess% gtr %targetNum% (
    echo Too high! Try again.
    goto guessLoop
) else (
    echo Congratulations! You guessed the number %targetNum% in %attempts% attempts.
    echo.
    goto :shell
)

:calculator
cls
echo Calculator
echo.
set /p "expression=Enter expression (type 'exit' to return to shell): "

if "!expression!"=="exit" (
    echo Exiting to shell
    echo.
    goto :shell
)

set /a "!result!=!expression!"

echo Result: !result!
pause
echo.
goto :calculator

:eof
echo =============Exiting=============
endlocal