Files Included:

The Following files should be present:

SerialPWMWindows.EXE - The finished program, ready to use

SerialPWMWindows.ASM - The source code. Can be modified and assembled with FASM or similar*

delphiPWM.dll - A library file you need.

delphiPWM.dpr - library source code

README.MD - This ReadMe instruction file 

*NOTE: If you plan to modify and assemble, It is highly recommended to use the FASM GUI for Windows.
(FASMW.EXE - included with FASM for Windows) The FASM Windows GUI handles the .inc includes with no problem

The Console version of FASM will give an error if you don't have EVERY file listed in the .inc in the same folder
as the FASM.EXE console program


Description:

The Serial port pulse width modulator is a program that allows users to output pulses, that resemble a PWM type pulse

through a standard RS-232 serial port on a Personal Computer (PC). Users can use the PC keyboard to control the program

and ultimately the pulse width output of the serial port.

The output through the serial port can then be used to control transistors, relays, or LED lamps, however optical isolation 
is highly recommended.

The output pulse will be available at the serial port DB9 connector, pin 3 (DATA Transmit) and pin 5 (GROUND)

This program is free, users may modify and redistribute if they wish to do so. 

This program was written entirely in FASM Assembly language.


Using the Serial port pulse width modulator program:

This version of the Serial port pulse width modulator was designed to work with all versions of Windows NT, from 4.0 and newer

(NT 3.1, 3.5 and 3.51 are not supported)

It is NOT designed to work with Windows 3.x or Windows 9.x. 

Use the DOS version for use on those operating systems

The Serial port pulse width modulator is operated by the keyboard, and
provides display in a console window. 

Pressing each of the number keys, 1 through 9 will adjust the pulse width by 10%

Key 1 being 90% and Key 9 being 10%

Because of the Serial Port limitations, Pulse Widths are only adjustable in 10% increments

The minimum pulse width when the program is running is 10% duty cycle 

The maximum pulse width when the program is running is 90% duty cycle

The console will display which duty cycle has been selected

Pressing the ESCAPE key will end the program and close the window

The program uses the serial port at COM1 for output

If the program is unable to open COM1, it will display an error message, and then close.

You can change the COM port used in the soruce code, by changing the contents of the variable on line 14

For example:

CommPort DB "COM1",0

Could be changed to:

CommPort DB "COM2",0

Named pipes can also be specified:(This should work for USB to RS232 / USB to serial converters with virtual com drivers)

CommPort DB "\.\\pipename',0 


Then assemble with FASM

This may be updated in the future, to allow changes to the COM port without re-assembling

The baud rate (which affects the switching frequency, in this case) can be adjusted by changing the contents of

the variable at line 61.

For example:

stringDCB: DB 'baud=115200 parity=N data=8 stop=1',0

could be changed to:

stringDCB: DB 'baud=9600 parity=N data=8 stop=1',0

Then assemble with FASM


Supported Operating Systems:

Windows NT 4.0

Windows 2000 (NT 5.0)

Windows XP    (NT 5.1)

Windows
Server 2003    (NT 5.2)

Windows 
Vista                (NT 6.0)

Windows 7      (NT 6.1)

Windows 8(.1)(NT 6.2 (.3))

Windows 10   (NT 10.0)

Although these operating systems are supported, the Serial PWM hasn't yet been tested on all of them

It is very likely it will work with them all

Below is a list of operating systems the Serial PWM has been tested on, and confirmed to work correctly
(except NT 3.51, it is unsupported)


Tested Operating Systems:

Windows NT 3.51    Offically unsupported, no keyboard control

Windows NT 4.0 SP6a  (No errors encountered)(delphijustin's version has been untested with this version of windows)

Windows 2000 SP4      (No errors encountered)

Windows XP SP3         (No errors encountered)

Windows 7 SP1            (No errors encountered)


System requirements:


Operating system : Windows NT 4.0 or newer (using delphijustin's version it will need to be Windows 2000 or newer)
Free Memory: 2 MB (recommended, uses only ~480K on Windows NT 4.0, 1 MB+ for Windows XP)
Free Disk Space: 79 KB (.DLL File = ~64 KB,.EXE Program = 4 KB, .ASM Source code = 6 KB, .TXT Readme file = 5 KB)
CPU: 486 25 MHz minimum for NT 4.0
Intel Pentium II 300 MHz or AMD K6-3 400 MHz or better highly recommended

Questions or comments?

visit:

http://www.youtube.com/subcooledheatpump

