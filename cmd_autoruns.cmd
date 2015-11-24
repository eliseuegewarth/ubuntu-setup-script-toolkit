@echo off
cls
Color 0A
doskey /macrofile=c:\bin\aliases
::reg add "hkcu\software\microsoft\command processor" /v Autorun /t reg_sz /d c:\bin\cmd_autoruns.cmd
