# Local Phase A/B autopilot for AnaOS Hetzner bring-up.
param(
  [string]$SshHost = "anaos-build",
  [string]$OutDir = "",
  [switch]$Once
)

$ErrorActionPreference = "Continue"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
if (-not $OutDir) { $OutDir = Join-Path $RepoRoot "anaos-emulator-out" }
$StateFile = Join-Path $OutDir "LOCAL_AUTOPILOT_STATE.txt"

function Write-State([string]$msg) {
  New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
  $line = "$(Get-Date -Format o) $msg"
  Add-Content -Path $StateFile -Value $line
  Write-Host $line
}

function Invoke-Remote([string]$cmd) {
  # Single remote argv string; keep bash operators inside single-quoted PS strings at call sites.
  ssh -o BatchMode=yes -o ConnectTimeout=20 $SshHost $cmd
}

function Get-HcloudToken {
  if ($env:HCLOUD_TOKEN -and $env:HCLOUD_TOKEN.Trim().Length -gt 0) {
    return $env:HCLOUD_TOKEN.Trim()
  }
  $p = Join-Path $RepoRoot "secrets\hcloud_token"
  if (Test-Path $p) {
    return (Get-Content -Raw $p).Trim()
  }
  return $null
}

function Pull-Artifacts {
  Write-State "pull_start"
  New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
  $remoteReady = Invoke-Remote 'test -f /opt/anaos/ARTIFACTS_READY && echo YES || echo NO'
  if ($remoteReady -match "YES") {
    scp -o BatchMode=yes -o ConnectTimeout=30 -r "${SshHost}:/opt/anaos/artifacts-ready/*" "$OutDir/"
  } else {
    $imgs = @(
      "system.img","product.img","vendor.img","system_ext.img","system_dlkm.img",
      "vendor_boot.img","vbmeta.img","ramdisk.img","super.img","dtb.img"
    )
    foreach ($f in $imgs) {
      scp -o BatchMode=yes -o ConnectTimeout=60 "${SshHost}:/opt/anaos/aosp/out/target/product/emulator/$f" "$OutDir/" 2>$null
    }
    scp -o BatchMode=yes "${SshHost}:/opt/anaos/overlay-build.log" "$OutDir/" 2>$null
    scp -o BatchMode=yes "${SshHost}:/opt/anaos/SLEEP_REPORT.txt" "$OutDir/" 2>$null
    scp -o BatchMode=yes "${SshHost}:/opt/anaos/BRINGUP.txt" "$OutDir/" 2>$null
    scp -o BatchMode=yes "${SshHost}:/opt/anaos/OVERLAY_BUILD_OK" "$OutDir/" 2>$null
  }
  Write-State "pull_done"
  "PULLED $(Get-Date -Format o)" | Set-Content (Join-Path $OutDir "PULL_OK.txt")
}

function Remove-HetznerServer {
  $token = Get-HcloudToken
  if (-not $token) {
    Write-State "delete_skipped_no_HCLOUD_TOKEN - set env HCLOUD_TOKEN or secrets/hcloud_token"
    "NEED_HCLOUD_TOKEN $(Get-Date -Format o)" | Set-Content (Join-Path $OutDir "DELETE_PENDING.txt")
    return $false
  }
  Write-State "delete_lookup"
  $headers = @{ Authorization = "Bearer $token" }
  $servers = Invoke-RestMethod -Headers $headers -Uri "https://api.hetzner.cloud/v1/servers"
  $target = $servers.servers | Where-Object {
    $_.name -eq "anaos-build" -or $_.public_net.ipv4.ip -eq "188.34.189.66"
  } | Select-Object -First 1
  if (-not $target) {
    Write-State "delete_skip_server_not_found (already gone?)"
    "GONE $(Get-Date -Format o)" | Set-Content (Join-Path $OutDir "DELETE_OK.txt")
    return $true
  }
  Write-State "delete_server id=$($target.id) name=$($target.name)"
  Invoke-RestMethod -Method Delete -Headers $headers -Uri "https://api.hetzner.cloud/v1/servers/$($target.id)"
  "DELETED id=$($target.id) $(Get-Date -Format o)" | Set-Content (Join-Path $OutDir "DELETE_OK.txt")
  Write-State "delete_ok"
  return $true
}

function Tick {
  $ok = Invoke-Remote 'test -f /opt/anaos/OVERLAY_BUILD_OK && echo OK || echo NO'
  $fail = Invoke-Remote 'test -f /opt/anaos/OVERLAY_BUILD_FAIL && echo FAIL || echo NO'
  $abort = Invoke-Remote 'test -f /opt/anaos/PHASE_B_ABORT && echo ABORT || echo NO'
  $localPull = Test-Path (Join-Path $OutDir "PULL_OK.txt")
  $localOk = Test-Path (Join-Path $OutDir "OVERLAY_BUILD_OK")
  Write-State "tick ok=$ok fail=$fail abort=$abort localPull=$localPull"

  if (($ok -match "OK") -or $localPull -or $localOk) {
    if (-not $localPull) {
      Pull-Artifacts
    }
    if (-not (Test-Path (Join-Path $OutDir "DELETE_OK.txt"))) {
      [void](Remove-HetznerServer)
    }
    Write-State "phase_B_complete"
    return "done"
  }

  if ($abort -match "ABORT") {
    if (-not (Test-Path (Join-Path $OutDir "PULL_OK.txt"))) {
      Pull-Artifacts
    }
    if (-not (Test-Path (Join-Path $OutDir "DELETE_OK.txt"))) {
      [void](Remove-HetznerServer)
    }
    Write-State "phase_B_abort_finalized"
    return "done"
  }
  return "running"
}

$result = Tick
Write-Host "result=$result"
exit 0
