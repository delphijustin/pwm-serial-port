@echo off
if "%1"=="" goto help
set timeout=%2
if "%2"=="" set timeout=500
:loop
for /L %%d in (1,1,9) do SerialPWMWindows.EXE /p %1 /d %%d /t %timeout%
goto loop
:help
echo This script sends an oscillating PWM through a serial port
echo Usage: %0 comporrt [timeout]
pause





