@ECHO OFF
setlocal
set projectRoot=%~dp0
set scriptPath=%1
set script=%2
set commandPath=%3
set command=%4
set "scriptsRoot=%projectRoot%/.devcontainer/scripts"
"%scriptsRoot%/setup/environment.cmd"
"%scriptsRoot%/setup/submodules.cmd"
call :Run "%projectRoot%/run.ps1" "%scriptPath%" "%script%" "%commandPath%" "%command%"
endlocal
:Run
PowerShell -file "%1" --scriptPath "%2" --script "%3" --commandPath "%4" --command "%5"
exit /b
