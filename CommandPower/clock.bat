@echo off
:clock
color f
title clock
mode con: cols=40 lines=2
echo %date% %time%
goto clock