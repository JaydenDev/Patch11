@echo off

:Menu
Echo ----------------------------------------------------------------
Echo Patch11, patch installer
Echo Ver: dev
Echo ----------------------------------------------------------------
Echo 1 - Take ownership context menu command
Echo 2 - Fast delete context menu command
Echo 3 - Classic context menu
Echo 4 - Classic file explorer, taskbar, and UI
Echo 5 - Disable/Enable rounded corners
echo ------------------------
Echo 13 - Restore default context menu
Echo 14 - Toggle classic taskbar icons
echo ------------------------
Echo 64 - Restart Explorer (required for most patches)

Set /P App=Selection #
If %App%=="" exit
If %App%==1 GOTO 1
If %App%==2 GOTO 2
If %App%==3 GOTO 3
If %App%==4 GOTO 4
If %App%==5 GOTO 5
If %App%==13 GOTO 13
If %App%==14 GOTO 14
If %App%==64 GOTO RST

:1
rem set __COMPAT_LAYER=RunAsInvoker  
REGEDIT.EXE  /S  "%~dp0\reg\tocm.reg"
exit

:2
rem set __COMPAT_LAYER=RunAsInvoker  
REGEDIT.EXE  /S  "%~dp0\reg\fast.reg"
exit

:3
rem set __COMPAT_LAYER=RunAsInvoker
REGEDIT.EXE /S "%~dp0\reg\context.reg"
exit

:13
rem set __COMPAT_LAYER=RunAsInvoker
REGEDIT.EXE /S "%~dp0\reg\context2.reg"
exit

:14
cmd /c "explorer shell:::{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}"

:4
rem set __COMPAT_LAYER=RunAsInvoker
REGEDIT.EXE /S "%~dp0\reg\classic.reg"
exit

:RST
taskkill /f /im explorer.exe
explorer.exe
exit

:5
mkdir dl
curl -L https://github.com/valinet/Win11DisableRoundedCorners/releases/latest/download/Win11DisableOrRestoreRoundedCorners.exe -o dl\roundedcorners.exe
dl\roundedcorners.exe

