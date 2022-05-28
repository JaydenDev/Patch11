@echo off

If exist "dl" (
    echo DEBUG: Required directory already exists
) else (
    mkdir dl
)

:Menu
Echo ----------------------------------------------------------------
echo [101;93m Patch11 Version 1.0 [0m
Echo ----------------------------------------------------------------
echo [46m 1 - Take ownership context menu item[0m
echo [46m 2 - Fast delete context menu[0m
echo [46m 3 - Classic context menu[0m
echo [46m 4 - Enable/disable rounded corners[0m
echo [46m 5 - Enroll in insider program on unsupported device[0m
echo ------------------------
Echo [46m 13 - Restore default context menu[0m
Echo [46m 14 - Toggle classic taskbar icons[0m
Echo [46m 15 - Restart Patch11 as administrator[0m
echo ------------------------
Echo [46m 64 - Restart Explorer (required for most patches)[0m
Echo [46m 128 - Suggest a feature (opens defualt browser)[0m

Set /P App=Type the # of your selection 
If %App%=="" exit
If %App%==1 GOTO 1
If %App%==2 GOTO 2
If %App%==3 GOTO 3
If %App%==4 GOTO 4
If %App%==5 GOTO 5
If %App%==6 GOTO 6
If %App%==13 GOTO 13
If %App%==14 GOTO 14
If %App%==15 GOTO 15
If %App%==64 GOTO RST
If %App%==128 GOTO 128

:1
rem set __COMPAT_LAYER=RunAsInvoker  
If exist "%~dp0\dl\tocm.reg" (
    echo 'File found, skipping download'
) else (
    echo 'Downloading required files'
    curl -s -L https://dl.jaydendev.repl.co/tocm.reg -o dl\tocm.reg
)
REGEDIT.EXE  /S  "%~dp0\dl\tocm.reg"
exit

rem set __COMPAT_LAYER=RunAsInvoker  
If exist "%~dp0\dl\fast.reg" (
    echo 'File found, skipping download'
) else (
    echo 'Downloading required files'
    curl -s -L https://dl.jaydendev.repl.co/fast.reg -o dl\tocm.reg
)
REGEDIT.EXE  /S  "%~dp0\dl\fast.reg"
exit

:3
rem set __COMPAT_LAYER=RunAsInvoker  
If exist "%~dp0\dl\context.reg" (
    echo 'File found, skipping download'
) else (
    echo 'Downloading required files'
    curl -s -L https://dl.jaydendev.repl.co/context.reg -o dl\tocm.reg
)
REGEDIT.EXE  /S  "%~dp0\dl\context.reg"
exit

:13
rem set __COMPAT_LAYER=RunAsInvoker  
If exist "%~dp0\dl\context2.reg" (
    echo 'File found, skipping download'
) else (
    echo 'Downloading required files'
    curl -s -L https://dl.jaydendev.repl.co/context2.reg -o dl\context2.reg
)
REGEDIT.EXE  /S  "%~dp0\dl\context2.reg"
exit

:14
cmd /c "explorer shell:::(05d7b0f4-2121-4eff-bf6b-ed3f69b894d9)"

:4
rem set __COMPAT_LAYER=RunAsInvoker  
If exist "%~dp0\dl\classic.reg" (
    echo 'File found, skipping download'
) else (
    echo 'Downloading required files'
    curl -s -L https://dl.jaydendev.repl.co/classic.reg -o dl\classic.reg
)
REGEDIT.EXE  /S  "%~dp0\dl\tocm.reg"
exit

:128
start "" "https://scratch.mit.edu/discuss/topic/608121"
exit

:15
cmd /c "Patch11WithAdmin.cmd"
exit

:RST
taskkill /f /im explorer.exe
explorer.exe
exit

:5
mkdir dl
If exist "%~dp0\dl\roundedcorners.exe" (
    Echo File already downloaded, skipping
) else (
    echo Downloading required files
    curl -s -L https://github.com/valinet/Win11DisableRoundedCorners/releases/latest/download/Win11DisableOrRestoreRoundedCorners.exe -o dl\roundedcorners.exe
    echo File downloaded, running task
)
dl\roundedcorners.exe

:6
If exist "%~dp0\dl\insider.zip" (
    Echo File already downloaded, skipping
) else (
    echo Downloading required files
    curl -s -L https://github.com/abbodi1406/offlineinsiderenroll/releases/download/2.6.3/OfflineInsiderEnroll-2.6.3.zip -o dl\insider.zip
)
powershell -command "Expand-Archive %~dp0\dl\insider.zip %~dp0\dl\insider"
start cmd.exe /c "%~dp0\dl\insider\OfflineInsiderEnroll.cmd"
pause
