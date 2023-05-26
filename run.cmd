@ECHO OFF
setlocal
set projectRoot=%~dp0
set scriptPath=%1
set script=%2
set commandPath=%3
set command=%4
set "scriptsRoot=%projectRoot%/.devcontainer/scripts"
call "%scriptsRoot%/setup/environment.cmd"
rem "%DEVCONTAINER_SCRIPTS_ROOT%/utils/gui-sound.cmd"
call :Run "%DEVCONTAINER_FEATURES_PROJECT_ROOT%/run.ps1" "%scriptPath%" "%script%" "%commandPath%" "%command%"
goto :eof
:Run
echo %1
PowerShell -file "%1" --scriptPath "%2" --script "%3" --commandPath "%4" --command "%5"
endlocal
exit /b
