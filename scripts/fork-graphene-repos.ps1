# Fork GrapheneOS / related repos under Levan-al (TASK_011 / TASK_012).
# Does not require a build machine. Rate-limit aware.
$ErrorActionPreference = "Continue"
$env:Path = "C:\Program Files\GitHub CLI;" + $env:Path
$Owner = "Levan-al"

# GrapheneOS uses these names on GitHub
$repos = @(
  # TASK_011 — critical platform
  "GrapheneOS/platform_bionic",
  "GrapheneOS/platform_frameworks_base",
  "GrapheneOS/platform_frameworks_native",
  "GrapheneOS/platform_system_core",
  "GrapheneOS/platform_system_sepolicy",
  "GrapheneOS/platform_art",
  "GrapheneOS/platform_libcore",
  "GrapheneOS/platform_build",
  "GrapheneOS/platform_build_soong",
  "GrapheneOS/platform_system_vold",
  "GrapheneOS/platform_system_netd",
  "GrapheneOS/platform_bootable_recovery",
  # TASK_012 — GrapheneOS unique
  "GrapheneOS/hardened_malloc",
  "GrapheneOS/adevtool",
  "GrapheneOS/branding",
  "GrapheneOS/script",
  "GrapheneOS/vendor_state",
  "GrapheneOS/Vanadium",
  "GrapheneOS/AppStore",
  "GrapheneOS/Auditor",
  "GrapheneOS/Camera",
  "GrapheneOS/PdfViewer",
  "GrapheneOS/Apps",
  "GrapheneOS/platform_packages_apps_SetupWizard"
)

foreach ($src in $repos) {
  $name = $src.Split('/')[-1]
  $dest = "$Owner/$name"
  gh repo view $dest 2>$null | Out-Null
  if ($LASTEXITCODE -eq 0) {
    # If we already created an empty stub with same name, skip fork
    Write-Host "exists $dest (skip fork — resolve manually if stub vs fork conflict)"
    continue
  }
  Write-Host "forking $src -> $Owner ..."
  gh repo fork $src --org "" --fork-name $name --remote=false --clone=false 2>&1
  # default forks to user
  if ($LASTEXITCODE -ne 0) {
    gh repo fork $src --clone=false 2>&1
  }
  Start-Sleep -Seconds 8
}
Write-Host "done"
