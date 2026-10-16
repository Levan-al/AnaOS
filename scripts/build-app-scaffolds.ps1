# Build AnaOS app scaffolds locally (does not touch Hetzner AOSP).
$ErrorActionPreference = "Stop"
$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

$Sdk = Join-Path $env:LOCALAPPDATA "Android\Sdk"
$JavaHome = "C:\Program Files\Android\Android Studio\jbr"
$env:JAVA_HOME = $JavaHome
$env:ANDROID_HOME = $Sdk
$env:Path = "$JavaHome\bin;$env:Path"

$GradleVer = "8.11.1"
$GradleZip = Join-Path $env:TEMP "gradle-$GradleVer-bin.zip"
$GradleHome = Join-Path $env:TEMP "gradle-$GradleVer"
$GradleBat = Join-Path $GradleHome "gradle-$GradleVer\bin\gradle.bat"

if (-not (Test-Path $GradleBat)) {
  $url = "https://services.gradle.org/distributions/gradle-$GradleVer-bin.zip"
  Write-Host "Downloading $url"
  Invoke-WebRequest -Uri $url -OutFile $GradleZip
  Expand-Archive -Path $GradleZip -DestinationPath $GradleHome -Force
}

$sdkDirProp = ($Sdk -replace '\\', '/')
$Apps = @("Updater", "Auditor", "Camera", "PdfViewer", "AppStore", "SetupWizard")
$results = @()

foreach ($name in $Apps) {
  $dir = Join-Path $Root "apps\$name"
  if (-not (Test-Path $dir)) { continue }
  Set-Content -Path (Join-Path $dir "local.properties") -Value "sdk.dir=$sdkDirProp" -Encoding ASCII
  Push-Location $dir
  try {
    Write-Host ("==== {0} wrapper ====" -f $name)
    & $GradleBat wrapper --gradle-version $GradleVer
    Write-Host ("==== {0} assembleDebug ====" -f $name)
    & .\gradlew.bat assembleDebug --no-daemon
    if ($LASTEXITCODE -ne 0) { throw "gradle exit $LASTEXITCODE" }
    $apk = Get-ChildItem -Recurse -Filter "*.apk" -Path (Join-Path $dir "app\build\outputs") -ErrorAction SilentlyContinue |
      Select-Object -First 1 -ExpandProperty FullName
    $results += [pscustomobject]@{ App = $name; Ok = $true; Apk = $apk }
    Write-Host ("OK {0} -> {1}" -f $name, $apk)
  } catch {
    $results += [pscustomobject]@{ App = $name; Ok = $false; Apk = $_.Exception.Message }
    Write-Host ("FAIL {0}: {1}" -f $name, $_)
  } finally {
    Pop-Location
  }
}

$results | Format-Table -AutoSize
if ($results | Where-Object { -not $_.Ok }) { exit 1 }
