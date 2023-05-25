# https://scoop.sh/
try {
  scoop --version
} catch {
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}

scoop install sudo refreshenv
scoop update --all
sudo scoop install --global sudo refreshenv aria2
sudo scoop update --all --global
scoop config aria2-warning-enabled false
scoop uninstall sudo refreshenv
