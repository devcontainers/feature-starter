@ECHO OFF
setlocal
set projectRoot=%~dp0
set scriptPath=%1
set script=%2
set commandPath=%3
set command=%4
rem https://stackoverflow.com/questions/74862849/powershell-convertto-securestring-not-recognised-if-run-script-inline-from-cmd
set "PSModulePath="
set "scriptsRoot=%projectRoot%/.devcontainer/scripts"
"%scriptsRoot%/setup/environment.cmd"
PowerShell -file "%projectRoot%/run.ps1" --scriptPath "%scriptPath%" --script "%script%" --commandPath "%commandPath%" --command "%command%"
endlocal
