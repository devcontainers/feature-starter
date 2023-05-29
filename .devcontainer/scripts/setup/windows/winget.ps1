# https://apps.microsoft.com/store/detail/app-installer/
# https://github.com/microsoft/winget-cli
# https://github.com/microsoft/winget-cli/issues/210
winget --version
winget install --name "Sysinternals Suite" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "Microsoft.Edge" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "Microsoft.Edge.Beta" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "Microsoft.Edge.Dev" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --name "Microsoft Edge DevTools Preview" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --name "Remote Tools for Microsoft Edge" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "Google.Chrome" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --name "Chrome Remote Desktop Host" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "Microsoft.WindowsTerminal" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "Microsoft.WindowsTerminal.Preview" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "RedHat.Podman" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "JanDeDobbeleer.OhMyPosh" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --name "Windows Subsystem for Linux" --accept-package-agreements --accept-source-agreements --disable-interactivity
wsl --update
wsl --set-default-version 2
winget install --name --exact "Ubuntu" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --name "Ubuntu (Preview)" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --id "Docker.DockerDesktop" --accept-package-agreements --accept-source-agreements --disable-interactivity
# Windows Features
& "$env:DEVCONTAINER_FEATURES_PROJECT_ROOT/run.ps1" setup/windows pre-sudo
winget install --name "Microsoft Visual Studio Code" --accept-package-agreements --accept-source-agreements --disable-interactivity
winget install --name "Microsoft Visual Studio Code Insiders" --accept-package-agreements --accept-source-agreements --disable-interactivity
# https://learn.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2022
# https://learn.microsoft.com/en-us/visualstudio/install/workload-and-component-ids?view=vs-2022
# https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-build-tools?view=vs-2022&preserve-view=true
winget install --id Microsoft.VisualStudio.2022.BuildTools --accept-package-agreements --accept-source-agreements --disable-interactivity --override "--passive --wait --add Microsoft.VisualStudio.Workload.AzureBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.DataBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.MSBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.NodeBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.OfficeBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.UniversalBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.VCTools;includeRecommended --add Microsoft.VisualStudio.Workload.VisualStudioExtensionBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.WebBuildTools;includeRecommended --add Microsoft.VisualStudio.Workload.XamarinBuildTools;includeRecommended"
# https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-enterprise?view=vs-2022&preserve-view=true
# sudo winget install --id Microsoft.VisualStudio.2022.Enterprise.Preview --override "--passive --wait --add Microsoft.VisualStudio.Workload.Azure;includeRecommended --add Microsoft.VisualStudio.Workload.Data;includeRecommended --add Microsoft.VisualStudio.Workload.DataScience;includeRecommended --add Microsoft.VisualStudio.Workload.ManagedDesktopproductArchx64;includeRecommended --add Microsoft.VisualStudio.Workload.ManagedGame;includeRecommended --add Microsoft.VisualStudio.Workload.NativeCrossPlat;includeRecommended --add Microsoft.VisualStudio.Workload.NativeDesktopproductArchx64;includeRecommended --add Microsoft.VisualStudio.Workload.NativeGameproductArchx64;includeRecommended --add Microsoft.VisualStudio.Workload.NativeMobile;includeRecommended --add Microsoft.VisualStudio.Workload.NetCrossPlat;includeRecommended --add Microsoft.VisualStudio.Workload.NetWebproductArchx64;includeRecommended --add Microsoft.VisualStudio.Workload.Node;includeRecommended --add Microsoft.VisualStudio.Workload.Office;includRecommended --add Microsoft.VisualStudio.Workload.Python;includeRecommended --add Microsoft.VisualStudio.Workload.UniversalproductArchx64;includeRecommended --add Microsoft.VisualStudio.Workload.VisualStudioExtension;includeRecommended"
