Write-Host "setup/windows/pip.ps1"
python -m ensurepip --upgrade
python -m pip install --upgrade pip
pip install --use-pep517 pip-review
pip install moreutils
pip-review --auto
