@ECHO OFF
setlocal EnableDelayedExpansion

rem read script as argument
set "scriptPath=%~1"
set "script=%~2"

set "OUTPUT="
for /f "usebackq delims=" %%A in ("%DEVCONTAINER_SCRIPTS_ROOT%\%scriptPath%\%script%.sh") do (
    set "LINE=%%A"
    echo !LINE!
    rem skip comment lines
    if not "!LINE:~0,1!"=="#" (
        rem escape double quotes
        set "LINE=!LINE:"=\"!"
        rem escape dollar signs
        set "LINE=!LINE:$=\$!"
        rem append the line to output
        set "OUTPUT=!OUTPUT!!LINE! && "
    )
)

rem check if OUTPUT ends with ' && ' and if so, remove it
if "!OUTPUT:~-4!"==" && " (
    set "OUTPUT=!OUTPUT:~0,-4!"
)

echo !OUTPUT!

endlocal