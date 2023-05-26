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
for /f "delims=" %%i in ('"%DEVCONTAINER_SCRIPTS_ROOT%\utils\echo-sh-as-one-liner.cmd" setup/devspace post-build-sudo') do set "DEVCONTAINER_POST_BUILD_SUDO_COMMAND=%%i"
for /f "delims=" %%i in ('"%DEVCONTAINER_SCRIPTS_ROOT%\utils\echo-sh-as-one-liner.cmd" setup/devspace post-build-user') do set "DEVCONTAINER_POST_BUILD_USER_COMMAND=%%i"
echo DEVCONTAINER_FEATURES_PROJECT_ROOT=!DEVCONTAINER_FEATURES_PROJECT_ROOT!
echo DEVCONTAINER_FEATURES_SOURCE_ROOT=!DEVCONTAINER_FEATURES_SOURCE_ROOT!
echo DEVCONTAINER_SCRIPTS_ROOT=!DEVCONTAINER_SCRIPTS_ROOT!
echo DEVCONTAINER_POST_BUILD_SUDO_COMMAND=!DEVCONTAINER_POST_BUILD_SUDO_COMMAND!
echo DEVCONTAINER_POST_BUILD_USER_COMMAND=!DEVCONTAINER_POST_BUILD_USER_COMMAND!
endlocal
