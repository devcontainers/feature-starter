Write-Host "setup/windows/scoop.ps1"
# https://scoop.sh/
scoop install --global 7zip
scoop update --all --global
scoop update
$complete = $false
do {
    try {
        scoop install --global vcredist vcredist2022 touch patch
        scoop install --global gawk cacert file sed coreutils grep curl wget bzip2 less
        scoop install --global zlib buf protobuf grpc-tools dos2unix gitsign gh
        scoop install --global jq gcc make cmake llvm dotnet-nightly dotnet-sdk-preview dotnet-sdk dotnet-sdk-lts mono go python openssl openssh age 
        scoop install --global mkcert shellcheck speedtest-cli chezmoi sqlite postgresql azure-cli aws
        scoop install --global gedit
        scoop install --global nvm vulkan fiddler speedtest gimp vlc azuredatastudio azuredatastudio-insiders
        if ($LASTEXITCODE -ne 0) { Write-Host "scoop install --global failed"; throw "Exit code is $LASTEXITCODE" }
        $complete = $true
    } catch [Exception] {
        Write-Host $_.Exception.Message
        Write-Host "Retrying"
    }
} while (-not $complete)

scoop update --all --global
Stop-Service -Force sshd
C:\ProgramData\scoop\apps\openssh\current\install-sshd.ps1
C:\ProgramData\scoop\apps\zlib\current\register.reg
# Remove vcredist so the will update if this script is run again, these are special
scoop uninstall --global vcredist vcredist2005 vcredist2008 vcredist2010 vcredist2012 vcredist2013 vcredist2022
# scoop update
scoop update
scoop update --all
scoop update --all --global
scoop status
