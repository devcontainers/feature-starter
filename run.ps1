aram (
    [Parameter(Mandatory=$true)]
    [string]$scriptPath,
    [Parameter(Mandatory=$true)]
    [string]$script,
    [Parameter(Mandatory=$false)]
    [string]$command,
    [Parameter(Mandatory=$false)]
    [string]$dependency
)
projectRoot="$PSCommandPath"
sourceRoot="$projectRoot/src"
scriptsRoot="$projectRoot/scripts"
dependencySourceRoot="$projectRoot/dependencies/$dependency/src"
& "$scriptsRoot/setup/set-env-vars.ps1"
# if [ "$scriptPath" = "-h" ] || [ "$scriptPath" = "--help" ]; then
#   echo "Run will run a script from in the src directory with the correct env variables setup."
#   echo "Usage: ./run <script> <command>"
#   echo "DevContainer Feature Scripts:"
#   echo "    Color:"
#   echo "        sudo FAVORITE=blue ./run color/install"
#   echo "    Hello:"
#   echo "        sudo GREETING=Hello ./run hello/install"
#   echo "    Homebrew:"
#   echo "        sudo BREWS=git ./run homebrew/install"
#   echo "        ./run homebrew/uninstall"
executionRoot="$sourceRoot"
if [ "$dependency" != "" ]; then
  executionRoot="$dependencySourceRoot"
elif [ "$isScript" = "true" ]; then
    executionRoot="$scriptsRoot"
fi
executionRoot="$executionRoot/$scriptPath"
pushd "$executionRoot"
  "./$script.sh" "$command"
popd
