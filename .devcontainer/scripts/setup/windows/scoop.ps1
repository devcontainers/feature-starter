# https://scoop.sh/
scoop install --global 7zip
scoop update --all --global
scoop update
$complete = $false
do {
    try {
        scoop install --global vcredist vcredist2022 gawk openssh vulkan openssl gitsign gh sed curl wget grep sed coreutils less touch sqlite gcc buf protobuf grpc-tools llvm bzip2 make cmake patch cacert file dos2unix shellcheck zlib age mkcert go python dotnet-nightly dotnet-sdk-preview dotnet-sdk dotnet-sdk-lts nvm chezmoi postgresql speedtest-cli speedtest jq gedit gimp vlc azure-cli aws fiddler
        if ($LASTEXITCODE -ne 0) { throw "Exit code is $LASTEXITCODE" }
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
