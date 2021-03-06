library delphipwm;

uses
  SysUtils,
  windows,
  Classes;
  const fmt_dcb='baud=%d parity=N data=8 stop=1';
  var args:tstringlist;
function pwmTimer(timeout:integer):dword;stdcall;
var i:integer;
begin
if timeout=0then begin
writeln('Cannot use a timeout of 0');exitprocess(error_invalid_parameter);
end;
for i:=0downto timeout do asm nop end;if timeout<0then exitprocess(0);
sleep(timeout);
exitprocess(0);
end;
procedure pwmAbort(proc,lastError:dword;msg:pchar);stdcall;
begin
case proc of
0: write('CreateFile');
1: write('BuildCommDCB');
2: write('SetCommState');
3: write('WriteFile');
end;
writeln(': ',syserrormessage(lasterror));if msg<>nil then writeln(msg);
if paramcount=0 then begin Write('Press enter to quit...');readln;end;
exitprocess(getlasterror);
end;

procedure SetParameters(lpCom,dcbstr:pansichar;var dutyCycle:byte);stdcall;
var hkPorts:hkey;
portcount,cbName,cbDev,timerId:dword;
I,J:integer;
comport:array[0..15]of char;
comdev:array[0..max_path]of char;
begin
args:=tstringlist.Create;
args.CommaText:=strpas(GetCommandline);
if args.IndexOf('/?')>0then begin
writeln(
'This tool allows you to send pulse width modulation through the serial port.');
writeln;
writeln('Usage: ',extractfilename(paramstr(0)),' [/P comport] [/D dutyCycle] [/T msec] [/B Baud Rate');
writeln('[comport]    Serial port to use');
writeln('[dutyCycle]  Duty cycle must be 1 though 9 where 1 is 90% and 9 is 10%');
writeln('[msec]       Abort after a number of milliseconds');
exitprocess(0);
end;
if args.IndexOf('/B')>0then
strfmt(dcbstr,fmt_dcb,[strtointdef(args[args.indexof('/B')+1],115200)])else
strfmt(dcbstr,fmt_dcb,[115200]);
if args.indexof('/P')>0then strplcopy(@lpcom[4],args[args.indexof('/P')+1],16)else begin
if regopenkeyex(HKEY_LOCAL_MACHINE,
'SYSTEM\CurrentControlSet\Control\COM Name Arbiter\Devices',0,key_read,hkports)
=error_success then begin
// get serial ports from registry
regqueryinfokey(hkports,nil,nil,nil,nil,nil,nil,@portcount,nil,nil,nil,nil);
writeln('Avalible COM Ports:');
for I:=0to portcount-1 do begin cbName:=16;cbdev:=max_path+1;
regenumvalue(hkports,i,comport,cbname,nil,nil,@comdev,@cbdev);write(comport);
for J:=0to 7do write(' ');write(comdev);comdev[0]:=#0;comport[0]:=#0;writeln;
end;
regclosekey(hkports);
end;
writeln;
write('Enter COM Port: \\.\');readln(comport);if strlen(comport)=0then
exitprocess(maxdword);strlcopy(@lpcom[4],comport,16);
end;
dutycycle:=$ff;
if(args.IndexOf('/D')>0)then
case strtointdef(args[args.indexof('/D')+1],0)of
1:dutyCycle:=0;
2:dutyCycle:=$80;
3:dutycycle:=$c0;
4:dutycycle:=$e0;
5:dutycycle:=$f0;
6:dutycycle:=$f8;
7:dutycycle:=$fc;
8:dutycycle:=$fe;
9:asm nop end;
else writeln('Duty Cycle parameter is incorrect, using 10%');
end;
if args.IndexOf('/T')>0then createthread(nil,0,@pwmTimer,pointer(strtointdef(
args[args.indexof('/T')+1],0)),0,timerid);
end;
exports SetParameters,pwmAbort;
begin
end.
