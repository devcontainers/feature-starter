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
endlocal
