
# Define the URL for the latest Python installer
$pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"

# Define the path to save the installer
$installerPath = "$env:TEMP\python-3.12.0-amd64.exe"

# Download the Python installer
Write-Output "Downloading Python installer..."
Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $installerPath
Write-Output "Python installer downloaded to $installerPath"

# Run the installer silently
Write-Output "Running the Python installer..."
Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=0" -NoNewWindow -Wait
Write-Output "Python installation completed"

# Clean up the installer file
Write-Output "Cleaning up the installer file..."
Remove-Item -Path $installerPath
Write-Output "Installer file removed"

# Get the current user's username
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.Split('\')[-1]
Write-Output "Current user: $currentUser"

# Define the Python installation path
$pythonInstallPath = "C:\Users\$currentUser\AppData\Local\Programs\Python\Python312"  # Adjust version number if necessary
Write-Output "Python installation path: $pythonInstallPath"

# Add Python to the system PATH
Write-Output "Adding Python to the system PATH..."
$env:Path += ";$pythonInstallPath"
[System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
Write-Output "Python added to the system PATH"

# Verify the installation
Write-Output "Verifying Python installation..."
python --version

