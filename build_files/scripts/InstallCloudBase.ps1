# Install CloudBase-Init

Write-Host  "Downloading CloudBase-Init"

try {
    Write-Host "Downloading CloudBaseInit Software"
    Invoke-WebRequest -Uri "https://cloudbase.it/downloads/CloudbaseInitSetup_x64.msi" -OutFile CloudbaseInitSetup_x64.msi


    Write-Host "Installing CloudBaseInit"
    $cloudbase = (Start-Process msiexec.exe -ArgumentList "/i","CloudBaseInitSetup_x64.msi","/qb-","/norestart" -NoNewWindow -Wait -PassThru)
    if ($cloudbase.ExitCode -ne 0) {
      Write-Error "Error installing CloudBaseInit Software"
      exit 1
    }
  
  }
  catch
  {
    Write-Error $_.Exception
    exit 1
  }