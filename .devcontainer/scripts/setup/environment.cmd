@ECHO OFF
setlocal EnableDelayedExpansion
set cmdDir=%~dp0
for %%i in ("%cmdDir%\..") do for %%j in ("%%~fi") do set "scriptsRoot=%%~fj"
for %%i in ("%scriptsRoot%\..") do for %%j in ("%%~fi") do set "devcontainerRoot=%%~fj"
for %%i in ("%devcontainerRoot%\..") do for %%j in ("%%~fi") do set "projectRoot=%%~fj"
pushd %devcontainerRoot%
FOR /F "tokens=*" %%i in ('type .env') do SET %%i
popd
set "DEVCONTAINER_FEATURES_PROJECT_ROOT=%projectRoot%"
set "DEVCONTAINER_FEATURES_SOURCE_ROOT=%DEVCONTAINER_FEATURES_PROJECT_ROOT%\src"
set "DEVCONTAINER_SCRIPTS_ROOT=%DEVCONTAINER_FEATURES_PROJECT_ROOT%\.devcontainer\scripts"
set "DEVCONTAINER_POST_BUILD_COMMAND="
for /F "delims=" %%i in (%DEVCONTAINER_SCRIPTS_ROOT%\setup\post-build) do set "DEVCONTAINER_POST_BUILD_COMMAND=!DEVCONTAINER_POST_BUILD_COMMAND! %%i"
call :SetVariables "%DEVCONTAINER_FEATURES_PROJECT_ROOT%" "%DEVCONTAINER_FEATURES_SOURCE_ROOT%" "%DEVCONTAINER_SCRIPTS_ROOT%" "%DEVCONTAINER_POST_BUILD_COMMAND%"
endlocal
set PSHELL=PowerShell
rem https://stackoverflow.com/questions/74862849/powershell-convertto-securestring-not-recognised-if-run-script-inline-from-cmd
set "PSModulePath="
:SetVariables
set "DEVCONTAINER_FEATURES_PROJECT_ROOT=%~1"
set "DEVCONTAINER_FEATURES_SOURCE_ROOT=%~2"
set "DEVCONTAINER_SCRIPTS_ROOT=%~3"
set "DEVCONTAINER_POST_BUILD_COMMAND=%~4"
exit /b
