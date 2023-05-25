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
set "DEVCONTAINER_POST_BUILD_SUDO_COMMAND="
for /F "delims=" %%i in (%DEVCONTAINER_SCRIPTS_ROOT%\setup\devspace\post-build-sudo) do set "DEVCONTAINER_POST_BUILD_SUDO_COMMAND=!DEVCONTAINER_POST_BUILD_SUDO_COMMAND! %%i"
set "DEVCONTAINER_POST_BUILD_USER_COMMAND="
for /F "delims=" %%i in (%DEVCONTAINER_SCRIPTS_ROOT%\setup\devspace\post-build-user) do set "DEVCONTAINER_POST_BUILD_USER_COMMAND=!DEVCONTAINER_POST_BUILD_USER_COMMAND! %%i"
call :SetVariables "%DEVCONTAINER_FEATURES_PROJECT_ROOT%" "%DEVCONTAINER_FEATURES_SOURCE_ROOT%" "%DEVCONTAINER_SCRIPTS_ROOT%" "%DEVCONTAINER_POST_BUILD_SUDO_COMMAND%" "%DEVCONTAINER_POST_BUILD_USER_COMMAND%"
endlocal
:SetVariables
@rem Make vaariables available to the calling script
set "DEVCONTAINER_FEATURES_PROJECT_ROOT=%~1"
set "DEVCONTAINER_FEATURES_SOURCE_ROOT=%~2"
set "DEVCONTAINER_SCRIPTS_ROOT=%~3"
set "DEVCONTAINER_POST_BUILD_SUDO_COMMAND=%~4"
set "DEVCONTAINER_POST_BUILD_USER_COMMAND=%~5"
set PSHELL=PowerShell
@rem https://stackoverflow.com/questions/74862849/powershell-convertto-securestring-not-recognised-if-run-script-inline-from-cmd
set "PSModulePath="
exit /b
