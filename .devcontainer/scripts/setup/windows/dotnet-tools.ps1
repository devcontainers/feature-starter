try {
  dotnet tool install -g git-credential-manager
}
catch {
  dotnet tool upgrade -g git-credential-manager
}
