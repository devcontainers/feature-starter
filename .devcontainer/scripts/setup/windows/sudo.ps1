# https://scoop.sh/
try {
  scoop --version
} catch {
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}

scoop install sudo refreshenv
scoop update --all
