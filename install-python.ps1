$pythonInstallerUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"

$installerPath = "$env:TEMP\python-3.12.0-amd64.exe"

Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $installerPath

Start-Process -FilePath $installerPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=0" -NoNewWindow -Wait

Remove-Item -Path $installerPath

$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.Split('\')[-1]

$pythonInstallPath = "C:\Users\$currentUser\AppData\Local\Programs\Python\Python312"  # Adjust version number if necessary

$env:Path += ";$pythonInstallPath"
[System.Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)

python --version

