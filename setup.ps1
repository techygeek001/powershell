$softwares_path = "CustomScriptPluginSoftwares"
$pwsh_version = "PowerShell-7.1.3-win-x64.msi"
$service_fabric_sdk_version =  "MicrosoftAzure-ServiceFabric-CoreSDK.appids"

New-Item -ItemType Directory -Path $softwares_path
cd $softwares_path

# Install Powershell
Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/download/v7.1.3/$pwsh_version" -OutFile $pwsh_version
msiexec.exe /package $pwsh_version /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

# Install  ServiceFabric sdk
Invoke-WebRequest -Uri  "https://webpihandler.azurewebsites.net/web/handlers/webpi.ashx/getinstaller/MicrosoftAzure-ServiceFabric-CoreSDK.appids" -OutFile $service_fabric_sdk_version
msiexec.exe /package $service_fabric_sdk_version /quiet 


# Install Azure Cli
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; 
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; 
rm .\AzureCLI.msi
