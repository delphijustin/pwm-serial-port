# pwm-serial-port
Send Pulse Width Modulation through the serial port

I decided to modify the code which orginally came from subcooledheatpump because of some of the stuff it lacked on:

Here's whats been improved:
1. You now don't need to recompile it everytime you need to change the com port
2. It now only detects keys being pushed when its console window is the foreground. Before it was detecting them even when the console window was minimized
3. If anything fails it returns with the Win32 error code

NOTE THIS PROGRAM MOSTLY MADE WITH FLAT ASSEMBLER AND BORLAND DELPHI(For the DLL which made it easier when working with fasm).

Subcooledheatpump's link: http://www.youtube.com/subcooledheatpump
Project homepage https://delphijustin.biz/serial-port-pwm/

More information see the other readfile(README.TXT)
