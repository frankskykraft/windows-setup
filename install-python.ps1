# Define the URL for the latest Python installer
$pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.4/python-3.12.4-amd64.exe"

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

# Define the Python installation path
$pythonInstallPath = "C:\Program Files\Python312"
Write-Output "Python installation path: $pythonInstallPath"

# Verify if Python was installed in the expected directory
if (Test-Path -Path "$pythonInstallPath\python.exe") {
    Write-Output "Python executable found at $pythonInstallPath\python.exe"
    
    # Add Python to the system PATH
    Write-Output "Adding Python to the system PATH..."
    $env:Path += ";$pythonInstallPath"
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
    Write-Output "Python added to the system PATH"

    # Open a new PowerShell window to verify the installation
    Write-Output "Please open a new PowerShell window and run 'python --version' to verify the installation."
} else {
    Write-Output "Python executable not found at $pythonInstallPath. Installation might have failed."
}

