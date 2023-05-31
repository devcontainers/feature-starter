Write-Host "setup/windows/pre-sudo.ps1"
# https://scoop.sh/
try {
  scoop --version
  if ($LASTEXITCODE -ne 0) { throw Write-Host "scoop --version failed"; "Exit code is $LASTEXITCODE" }
} catch {
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}

scoop bucket add extras
scoop bucket add games
scoop bucket add nerd-fonts
scoop bucket add nirsoft
scoop bucket add sysinternals
scoop bucket add java
scoop bucket add nonportable
scoop bucket add php
scoop bucket add versions
scoop update
scoop install sudo refreshenv
scoop update --all
refreshenv
