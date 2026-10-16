# Seed empty AnaOS component repos with README + SECURITY.md stubs.
$ErrorActionPreference = "Continue"
$env:Path = "C:\Program Files\GitHub CLI;" + $env:Path
$Owner = "Levan-al"
$Work = Join-Path $env:TEMP "anaos-seed"
New-Item -ItemType Directory -Force -Path $Work | Out-Null

$repos = @(
  "script",
  "hardened_malloc",
  "adevtool",
  "vendor_state",
  "platform_packages_apps_Camera",
  "platform_packages_apps_Updater",
  "platform_packages_apps_Auditor",
  "platform_packages_apps_AppStore",
  "platform_packages_apps_SetupWizard",
  "platform_packages_apps_PdfViewer",
  "platform_external_vanadium"
)

$security = @"
# Security Policy

Report vulnerabilities privately. Do not open public issues for security bugs.

Contact: Levan.alughishvili92@gmail.com (until security@anaos.org is active)

See also: https://github.com/Levan-al/AnaOS/blob/main/SECURITY.md
"@

foreach ($name in $repos) {
  $dir = Join-Path $Work $name
  if (Test-Path $dir) { Remove-Item -Recurse -Force $dir }
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  Push-Location $dir
  git init -b main | Out-Null
  git remote remove origin 2>$null
  git remote add origin "https://github.com/$Owner/$name.git"

  @"
# $name

AnaOS component repository. Part of https://github.com/Levan-al/AnaOS

Package / branding prefix: ``org.anaos`` / AnaOS.
"@ | Set-Content -Encoding utf8 README.md
  $security | Set-Content -Encoding utf8 SECURITY.md

  # copy script README if seeding script repo from meta
  if ($name -eq "script" -and (Test-Path "e:\Sovereign-Security\AnaOS\script\README.md")) {
    Copy-Item "e:\Sovereign-Security\AnaOS\script\README.md" .\README.md -Force
  }

  git add README.md SECURITY.md
  git -c user.name="AnaOS Maintainers Levani" -c user.email="Levan.alughishvili92@gmail.com" commit -m "chore: add README and SECURITY policy stub"
  git push -u origin main
  if ($LASTEXITCODE -eq 0) { Write-Host "seeded $name" } else { Write-Host "failed $name" }
  Pop-Location
  Start-Sleep -Seconds 3
}
