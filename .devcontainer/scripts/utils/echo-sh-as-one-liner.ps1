param (
  [Parameter(Mandatory = $true)]
  [string]$script
)

$OUTPUT = ""
Get-Content "$DEVCONTAINER_SCRIPTS_ROOT/$script.sh" | ForEach-Object {
    if (!($_.StartsWith("#"))) { # Skip comments
        $LINE = $_ -replace '\"', '\\"' # Escape double quotes
        $LINE = $LINE -replace '\$', '\\$' # Escape dollar signs
        $OUTPUT += "$LINE && "
    }
}

# Remove trailing ' && '
$OUTPUT = $OUTPUT.Substring(0, $OUTPUT.Length - 4)

Write-Output $OUTPUT
