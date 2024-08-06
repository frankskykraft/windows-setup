Set-ExecutionPolicy Bypass -Scope Process -Force
$scriptPath = "$env:TEMP\install_python.ps1"
Set-Content -Path $scriptPath -Value @'
# Define the URL for the latest Python installer
$pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"

# Define the path to save the installer
$installerPath = "$env:TEMP\python-3.12.0-amd64.exe"

# Download the Python installer
Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $installerPath

# Run the installer silently
Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -NoNewWindow -Wait

# Clean up the installer file
Remove-Item -Path $installerPath

# Verify the installation
python --version
'@

# Run the script
. $scriptPath
