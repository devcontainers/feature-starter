param (
  [Parameter(Mandatory = $true)]
  [string]$scriptPath,
  [Parameter(Mandatory = $true)]
  [string]$script
)

$OUTPUT = ""
Get-Content "$env:DEVCONTAINER_SCRIPTS_ROOT/$scriptPath/$script.sh" | ForEach-Object {
    if (!($_.StartsWith("#"))) { # Skip comments
        $LINE = $_ -replace '\"', '\\"' # Escape double quotes
        $LINE = $LINE -replace '\$', '\\$' # Escape dollar signs
        $OUTPUT += "$LINE && "
    }
}

# Remove trailing ' && '
$OUTPUT = $OUTPUT.Trim(" ").Trim("&")

return $OUTPUT
