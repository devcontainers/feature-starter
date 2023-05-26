param (
  [Parameter(Mandatory = $true)]
  [string]$commandPath,
  [Parameter(Mandatory = $true)]
  [string]$command
)

$OUTPUT = ""
Get-Content "$env:DEVCONTAINER_SCRIPTS_ROOT/$commandPath/$command.sh" | ForEach-Object {
    if (!($_.StartsWith("#"))) { # Skip comments
        $LINE = $_ -replace '\"', '\\"' # Escape double quotes
        $LINE = $LINE -replace '\$', '\\$' # Escape dollar signs
        $OUTPUT += "$LINE && "
    }
}

# Remove trailing ' && '
$OUTPUT = $OUTPUT.Trim(" ").Trim("&")

return $OUTPUT
