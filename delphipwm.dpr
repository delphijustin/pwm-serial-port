library delphipwm;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  windows,
  Classes;

procedure SetParameters(lpCom:pansichar;var dutyCycle:byte);stdcall;
var hkPorts:hkey;
portcount,cbName,cbDev:dword;
I,J:integer;
comport:array[0..15]of char;
comdev:array[0..max_path]of char;
begin
if paramstr(1)='/?'then begin
writeln(
'This tool allows you to send pulse width modulation through the serial port.');
writeln;
writeln('Usage: ',extractfilename(paramstr(0)),' [comport] [dutyCycle]');
writeln('[comport]    Serial port to use');
writeln('[dutyCycle]  Duty cycle must be 1 though 9 where 1 is 90% and 9 is 10%');
exitprocess(0);
end;
if paramcount>0then strplcopy(@lpcom[4],pchar(Paramstr(1)),16)else begin
case strtointdef(paramstr(2),0)of
1:dutyCycle:=0;
2:dutyCycle:=$80;
3:dutycycle:=$c0;
4:dutycycle:=$e0;
5:dutycycle:=$f0;
6:dutycycle:=$f8;
7:dutycycle:=$fc;
8:dutycycle:=$fe;
else dutycycle:=$ff;
end;
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
end;
exports SetParameters;
begin
end.
