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

procedure pwmAbort;
begin

end;
procedure SetParameters(lpCom:pansichar);stdcall;
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
writeln('Usage: ',extractfilename(paramstr(0)),' [comport]');
writeln('[comport]  Serial port to use');
exitprocess(0);
end;
if paramcount=1 then strplcopy(@lpcom[4],pchar(Paramstr(1)),16)else begin
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
