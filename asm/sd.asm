;-------------------------------------------------------------------------------------
.586
.model flat,stdcall
option casemap:none

   include kernel32.inc
   
   includelib kernel32.lib
;-------------------------------------------------------------------------------------
.code
start:
    ;反正执行到本程序最后一句就关机了，所以就不用保存 esi edi 了
    mov    esi,@F        ;没有使用 .data 段，就这样来取字串"ntdll.dll"
    invoke LoadLibrary,esi
    add    esi,0Ah        ;字串"NtShutdownSystem"
    push   esi
    push   eax
    add    esi,11h        ;字串"RtlAdjustPrivilege"
    push   esi
    push   eax
    mov    edi,GetProcAddress
    call   edi
    push   esp
    push   0h
    push   1h
    push   13h
    call   eax            ;RtlAdjustPrivilege
    call   edi            ;GetProcAddress
    push   0h            ;０为快速关机，１为快速重起
    call   eax            ;进去就关机了，所以后面就不用 ret 了，也不用FreeLibrary了
@@:    
    db "ntdll.dll",0
    db "NtShutdownSystem",0
    db "RtlAdjustPrivilege",0

;    invoke  RtlAdjustPrivilege,13h,1h,0h,esp
;    invoke  NtShutdownSystem,0

end start
;------------------------------------------------------------------------------------