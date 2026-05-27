<!-- : Begin batch script
setlocal EnableDelayedExpansion
chcp 65001
cd %~dp0

:: IF script and executable exist, run the macro
if exist "AltSyncMain.ahk" (
	if exist "AutoHotkey64.exe" (
		if not [%~3]==[] (
			set /a "delay=%~3" 2
			echo Starting Natro Macro in !delay! seconds.
			<nul set /p =Press any key to skip . . . 
			timeout /t !delay!
		)
		start "" "%~dp0AutoHotkey64.exe" "%~dp0AltSyncMain.ahk" %*
		exit
	)
)