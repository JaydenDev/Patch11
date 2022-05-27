@echo off

:Menu
Echo ----------------------------------------------------------------
Echo Patch11, registry patch installer
Echo Ver: dev
Echo ----------------------------------------------------------------
Echo 1 - Take ownership context menu command
Echo 2 - Fast delete context menu command
Echo 3 - Classic context menu
Echo 4 - Classic file explorer, taskbar, and UI
echo ------------------------
Echo 13 - Restore default context menu
echo ------------------------
Echo 64 - Restart Explorer (required for most patches)

Set /P App=Selection #
If %App%=="" GOTO MENU
If %App%==1 GOTO 1
If %App%==2 GOTO 2
If %App%==3 GOTO 3
If %App%==4 GOTO 4
If %App%==13 GOTO 13
If %App%==64 GOTO RST

:1
rem set __COMPAT_LAYER=RunAsInvoker  
REGEDIT.EXE  /S  "%~dp0\reg\tocm.reg"
pause
     
:2
rem set __COMPAT_LAYER=RunAsInvoker  
REGEDIT.EXE  /S  "%~dp0\reg\fast.reg"
pause

:3
rem set __COMPAT_LAYER=RunAsInvoker
REGEDIT.EXE /S "%~dp0\reg\context.reg"
pause

:13
rem set __COMPAT_LAYER=RunAsInvoker
REGEDIT.EXE /S "%~dp0\reg\context2.reg"
pause

:4
rem set __COMPAT_LAYER=RunAsInvoker
REGEDIT.EXE /S "%~dp0\reg\classic.reg"
pause

:RST
taskkill /f /im explorer.exe
explorer.exe