@ECHO OFF
set projectRoot=%~dp0
set scriptPath=%1
set script=%2
set commandPath=%3
set command=%4
set "scriptsRoot=%projectRoot%/.devcontainer/scripts"
FOR /F "tokens=1* delims==" %%A IN ('call "%scriptsRoot%/setup/environment.cmd"') DO SET "%%A=%%B"
rem "%DEVCONTAINER_SCRIPTS_ROOT%/utils/gui-sound.cmd"
PowerShell -file "%DEVCONTAINER_FEATURES_PROJECT_ROOT%/run.ps1" --scriptPath "%scriptPath%" --script "%script%" --commandPath "%commandPath%" --command "%command%"
