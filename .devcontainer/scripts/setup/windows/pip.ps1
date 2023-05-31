Write-Host "setup/windows/pip.ps1"
python -m ensurepip --upgrade
python -m pip install --upgrade pip
pip install pip-review
pip install moreutils
pip install mssql-cli
pip-review --local --auto
