# dotnet workloads
dotnet workload install wasi-experimental
dotnet workload update

# dotnet tools
try {
  dotnet tool install -g git-credential-manager
  if ($LASTEXITCODE -ne 0) { throw "Exit code is $LASTEXITCODE" }
}
catch {
  dotnet tool upgrade -g git-credential-manager
}
