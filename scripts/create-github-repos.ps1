# Create AnaOS GitHub organization repositories (TASK_003).
# Prerequisites:
#   1. Create org https://github.com/organizations/plan → name: AnaOS
#   2. gh auth login
#   3. Run: .\scripts\create-github-repos.ps1

$ErrorActionPreference = "Stop"
$Org = if ($env:ANAOS_GITHUB_ORG) { $env:ANAOS_GITHUB_ORG } else { "AnaOS" }

$Repos = @(
    @{ Name = "platform_manifest"; Desc = "repo manifest (default.xml)" },
    @{ Name = "branding"; Desc = "AnaOS product branding injection" },
    @{ Name = "script"; Desc = "Build and release helper scripts" },
    @{ Name = "hardened_malloc"; Desc = "Hardened memory allocator" },
    @{ Name = "adevtool"; Desc = "Vendor extraction and device tree tooling" },
    @{ Name = "vendor_state"; Desc = "Vendor blob state tracking" },
    @{ Name = "platform_packages_apps_Camera"; Desc = "AnaOS Camera (org.anaos.camera)" },
    @{ Name = "platform_packages_apps_Updater"; Desc = "AnaOS Updater (org.anaos.updater)" },
    @{ Name = "platform_packages_apps_Auditor"; Desc = "AnaOS Auditor (org.anaos.auditor)" },
    @{ Name = "platform_packages_apps_AppStore"; Desc = "AnaOS App Store (org.anaos.appstore)" },
    @{ Name = "platform_packages_apps_SetupWizard"; Desc = "AnaOS Setup Wizard" },
    @{ Name = "platform_packages_apps_PdfViewer"; Desc = "AnaOS PDF Viewer" },
    @{ Name = "platform_external_vanadium"; Desc = "Hardened Chromium / WebView" },
    @{ Name = "meta"; Desc = "Project meta, plan, and bootstrap docs" }
)

Write-Host "Creating repositories under org: $Org"

foreach ($r in $Repos) {
    $full = "$Org/$($r.Name)"
    gh repo view $full 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "skip  $full (exists)"
        continue
    }
    gh repo create $full --public --description $r.Desc --disable-wiki
    Write-Host "ok    $full"
}

Write-Host "Done. Next: push this workspace to $Org/meta"
