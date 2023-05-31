Write-Host "setup/windows/dotnet.ps1"
# dotnet workloads
dotnet workload install wasi-experimental
dotnet workload clean
dotnet workload update
dotnet workload repair

# dotnet tools
$modules = @('powershell', 'git-credential-manager')
foreach ($module in $modules) {
  try {
    dotnet tool install -g "$module"
    if ($LASTEXITCODE -ne 0) { Write-Host "dotnet tool install -g $module failed"; throw "Exit code is $LASTEXITCODE" }
  } catch {
    dotnet tool upgrade -g "$module"
  }
}
