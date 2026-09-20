# Set SONAR_TOKEN in the current PowerShell session before running this script.
if ([string]::IsNullOrWhiteSpace($env:SONAR_TOKEN)) {
  throw "SONAR_TOKEN no esta definido. Ejecuta: `$env:SONAR_TOKEN = 'TU_TOKEN'"
}

$pysonar = Get-Command pysonar -ErrorAction SilentlyContinue
if ($null -eq $pysonar) {
  $userScripts = Join-Path $env:APPDATA 'Python\Python314\Scripts\pysonar.exe'
  if (Test-Path $userScripts) {
    $pysonar = $userScripts
  } else {
    throw "No se encontro pysonar. Instala el paquete con: python -m pip install pysonar"
  }
}

Push-Location $PSScriptRoot
try {
  & $pysonar `
    --sonar-host-url=http://localhost:9000 `
    --sonar-token=$env:SONAR_TOKEN `
    --sonar-project-key=Trivia
} finally {
  Pop-Location
}