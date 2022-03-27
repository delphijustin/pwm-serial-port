Format PE Console

include 'win32ax.inc'

ORG 0x402000

.data
hDelphiPWM DD ?
sDelphiPWM DB 'delphipwm.dll',0
sSetParameters DB 'SetParameters',0
pSetParameters DD ?
ConTitle   DB 'Serial Port Pulse Width Modulator for Windows NT',0
hComm      DD ?
numofb     DD ?
inhandle   DD ?
outhandle  DD ?
numwritten DD ?
ComPort    DB "\\.\0123456789ABCDEF",0;16 byte port name buffer delphipwm.dll sets i
msg        DB ?
hwcon      DD ?
_error TCHAR 'Could not Open COM port.Make sure the serial port is correctly installed and configured.Close any programs that use the serial port and try again',0
_delphiError TCHAR 'Could not load "delphipwm.dll".',0
print:
msg1:                                                                               ;add ,13,10,0 to the end of the string so the console is not a mess
DB '90% Duty Cycle Selected                                                      ',13,10,0

msg2:
DB '80% Duty Cycle Selected                                                      ',13,10,0

msg3:
DB '70% Duty Cycle Selected                                                      ',13,10,0

msg4:
DB '60% Duty Cycle Selected                                                      ',13,10,0

msg5:
DB '50% Duty Cycle Selected                                                      ',13,10,0

msg6:
DB '40% Duty Cycle Selected                                                      ',13,10,0

msg7:
DB '30% Duty Cycle Selected                                                      ',13,10,0

msg8:
DB '20% Duty Cycle Selected                                                      ',13,10,0

msg9:
DB '10% Duty Cycle Selected                                                      ',13,10,0

msgsize = $ - msg1

string1:
DB "Serial Port Pulse Width Modulator for Windows NT (4.0 and newer)             ",13,10,0
DB "Use Keys 1 - 9 to adjust Pulse Width                                         ",13,10,0
DB "Press ESCAPE to close window                                                 ",13,10,0
DB "https://delphijustin.biz                                                     ",13,10,0
DB "Serial Settings: 115,200 Bits Per Second                                     ",13,10,0
DB "8 Data Bits No Parity 1 Stop Bit No flow Control                             ",13,10,0
DB "Programmed by: Subcooledheatpump improved by delphijustin                    ",13,10,0
DB "http://www.youtube.com/subcooledheatpump                                     ",13,10,0
DB "This program is Absolutely Free!                                             ",13,10,0
DB "Everyone is Free to distribute and modify                                    ",13,10,0


stringDCB: DB 'baud=115200 parity=N data=8 stop=1',0

size = $-string1

DCB:
DCBlength         dd ?
BaudRate          dd ?
fBinary           dd ?
fParity           dd ?
fOutxCtsFlow      dd ?
fOutxDsrFlow      dd ?
fDtrControl       dd ?
fDsrSensitivity   dd ?
fTXContinueOnXoff dd ?
fOutX             dd ?
fInX              dd ?
fErrorChar        dd ?
fNull             dd ?
fRtsControl       dd ?
fAbortOnError     dd ?
fDummy2           dd ?
wReserved         dw ?
XonLim            dw ?
XoffLim           dw ?
ByteSize          db ?
Parity            db ?
StopBits          db ?
XonChar           db ?
XoffChar          db ?
ErrorChar         db ?
EofChar           db ?
EvtChar           db ?
wReserved1        dw ?

.code
start:
        invoke AllocConsole
        invoke SetConsoleTitle,ConTitle
        invoke LoadLibraryA,sDelphiPWM
        mov [hDelphiPWM],eax
        cmp eax,0
        je delpError
        invoke GetProcAddress,[hDelphiPWM],sSetParameters
        mov [pSetParameters],eax
        cmp eax,0
        je delpError
        invoke pSetParameters,ComPort,msg
        invoke GetConsoleWindow  ;get console window handle
        mov [hwcon],EAX
        invoke GetStdHandle, STD_OUTPUT_HANDLE
        MOV [outhandle],EAX
        invoke WriteConsole,[outhandle],string1,800,numwritten,0

COM:
        invoke CreateFile,ComPort,GENERIC_READ or GENERIC_WRITE,NULL,NULL,OPEN_EXISTING,NULL,NULL
        MOV [hComm], EAX
        CMP EAX, INVALID_HANDLE_VALUE
        JE L10

        invoke BuildCommDCBA,stringDCB,DCB
        invoke SetCommState,[hComm],DCB


       ; MOV AL, 0xFF SetParameters Function does this
        ;MOV [msg], AL
        xor esi,esi

main:
        invoke WriteFile, [hComm], msg,1, numofb, NULL
        INC ESI
        CMP ESI, 0xFF
        JE key
        JMP main
key:
        xor esi,esi
        invoke GetForegroundWindow
;       checks to see if the foreground window is the console window before checking key states
;       this prevents it from catching keys while the user is in a different window

        cmp eax,[hwcon]
        je consolefg
        jmp main
consolefg:
        invoke GetAsyncKeyState, 0x31
        CMP AH,0x80
        JE L1
        invoke GetAsyncKeyState, 0x32
        CMP AH, 0x80
        JE L2
        invoke GetAsyncKeyState, 0x33
        CMP AH, 0x80
        JE L3
        invoke GetAsyncKeyState, 0x34
        CMP AH, 0x80
        JE L4
        invoke GetAsyncKeyState, 0x35
        CMP AH, 0x80
        JE L5
        invoke GetAsyncKeyState, 0x36
        CMP AH, 0x80
        JE L6
        invoke GetAsyncKeyState, 0x37
        CMP AH, 0x80
        JE L7
        invoke GetAsyncKeyState, 0x38
        CMP AH, 0x80
        JE L8
        invoke GetAsyncKeyState, 0x39
        CMP AH, 0x80
        JE L9
        invoke GetAsyncKeyState, 0x1B
        CMP AH, 0x80
        JE Close
        JMP main

L1:
invoke  WriteConsole,[outhandle],msg1,80,numwritten,0
XOR AX, AX
MOV [msg],AL
JMP main

L2:
invoke  WriteConsole,[outhandle],msg2,80,numwritten,0
MOV AL, 0x80
MOV [msg],AL
JMP main

L3:
invoke  WriteConsole,[outhandle],msg3,80,numwritten,0
MOV AL, 0xC0
MOV [msg],AL
JMP main

L4:
invoke  WriteConsole,[outhandle],msg4,80,numwritten,0
MOV AL, 0xE0
MOV [msg],AL
JMP main

L5:
invoke  WriteConsole,[outhandle],msg5,80,numwritten,0
MOV AL, 0xF0
MOV [msg],AL
JMP main

L6:
invoke  WriteConsole,[outhandle],msg6,80,numwritten,0
MOV AL, 0xF8
MOV [msg],AL
JMP main

L7:
invoke  WriteConsole,[outhandle],msg7,80,numwritten,0
MOV AL, 0xFC
MOV [msg],AL
JMP main

L8:
invoke  WriteConsole,[outhandle],msg8,80,numwritten,0
MOV AL, 0xFE
MOV [msg],AL
JMP main

L9:
invoke  WriteConsole,[outhandle],msg9,80,numwritten,0
MOV AL, 0xFF
MOV [msg],AL
JMP main
delpError:
invoke MessageBox,NULL,_delphiError,NULL,MB_ICONERROR+MB_OK
invoke GetLastError
invoke ExitProcess,eax
L10:
 invoke MessageBox,NULL,_error,NULL,MB_ICONERROR+MB_OK
 invoke GetLastError
 invoke ExitProcess,eax
Close:
invoke CloseHandle,[outhandle]
invoke CloseHandle, [hComm]
invoke ExitProcess, 0
.end start