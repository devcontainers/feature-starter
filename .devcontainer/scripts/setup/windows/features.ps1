$ProgPref = $ProgressPreference
$ProgressPreference = 'SilentlyContinue'
$results = Enable-WindowsOptionalFeature -FeatureName TFTP,LegacyComponents,DirectPlay,MediaPlayback,SmbDirect,MSRDC-Infrastructure,MicrosoftWindowsPowerShellV2Root,MicrosoftWindowsPowerShellV2,SearchEngine-Client-Package,Printing-PrintToPDFServices-Features,Printing-XPSServices-Features,TelnetClient,Printing-Foundation-InternetPrinting-Client,VirtualMachinePlatform,Containers-DisposableClientVM -All -Online -NoRestart -WarningAction SilentlyContinue
$ProgressPreference = $ProgPref
if ($results.RestartNeeded -eq $true) {
  Restart-Computer -Force
}

Add-WindowsCapability -Online -Name "App.StepsRecorder"
Add-WindowsCapability -Online -Name "App.Support.QuickAssist"
Add-WindowsCapability -Online -Name "App.WirelessDisplay.Connect"
Add-WindowsCapability -Online -Name "DirectX.Configuration.Database"
Add-WindowsCapability -Online -Name "Language.Basic~~~en-US"
Add-WindowsCapability -Online -Name "Language.Handwriting~~~en-US"
Add-WindowsCapability -Online -Name "Language.OCR~~~en-US"
Add-WindowsCapability -Online -Name "Language.Speech~~~en-US"
Add-WindowsCapability -Online -Name "Language.TextToSpeech~~~en-US"
Add-WindowsCapability -Online -Name "MathRecognizer"
Add-WindowsCapability -Online -Name "Microsoft.WebDriver"
Add-WindowsCapability -Online -Name "Microsoft.Windows.MSPaint"
Add-WindowsCapability -Online -Name "Microsoft.Windows.Notepad"
Add-WindowsCapability -Online -Name "Microsoft.Windows.PowerShell.ISE"
Add-WindowsCapability -Online -Name "Microsoft.Windows.WordPad"
Add-WindowsCapability -Online -Name "Msix.PackagingTool.Driver"
Add-WindowsCapability -Online -Name "OpenSSH.Client"
Add-WindowsCapability -Online -Name "OpenSSH.Server"
Add-WindowsCapability -Online -Name "Print.Fax.Scan"
Add-WindowsCapability -Online -Name "Print.Management.Console"
Add-WindowsCapability -Online -Name "RasCMAK.Client"
Add-WindowsCapability -Online -Name "RIP.Listener"
Add-WindowsCapability -Online -Name "SNMP.Client"
Add-WindowsCapability -Online -Name "Tools.DeveloperMode.Core"
Add-WindowsCapability -Online -Name "Tools.Graphics.DirectX"
Add-WindowsCapability -Online -Name "WMI-SNMP-Provider.Client"
Add-WindowsCapability -Online -Name "XPS.Viewer"
