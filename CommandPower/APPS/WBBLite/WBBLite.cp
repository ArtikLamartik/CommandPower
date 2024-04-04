@echo off
:shell
set command=
set /p "command=%cd%$ "
if /i "%command%"=="exit" goto eof
if /i "%command%"=="help" (
	echo Win BatchBox Help
	echo Help: Help page
	echo Ver: Version of the Shell and system
	echo Debug_on: enable debug
	echo Debug_off: disable debug
	echo.
	goto shell
)
if /i "%command%"=="ver" (
	echo Win BatchBox
	echo Download full version: https://github.com/WinXP655/WinBatchBox/releases
	ver
	echo.
	goto shell
)
if /i "%command%"=="debug_on" (
	echo on
	goto shell
)
if /i "%command%"=="debug_off" (
	echo off
	goto shell
)
%command%
echo.
set command=
goto shell

:eof