#!/usr/bin/env bash
# Create AnaOS GitHub organization repositories (TASK_003).
# Prerequisites:
#   1. Create org https://github.com/organizations/plan → name: AnaOS
#   2. gh auth login
#   3. Run: ./scripts/create-github-repos.sh
set -euo pipefail

ORG="${ANAOS_GITHUB_ORG:-AnaOS}"

REPOS=(
  "platform_manifest:repo manifest (default.xml)"
  "branding:AnaOS product branding injection"
  "script:Build and release helper scripts"
  "hardened_malloc:Hardened memory allocator"
  "adevtool:Vendor extraction and device tree tooling"
  "vendor_state:Vendor blob state tracking"
  "platform_packages_apps_Camera:AnaOS Camera (org.anaos.camera)"
  "platform_packages_apps_Updater:AnaOS Updater (org.anaos.updater)"
  "platform_packages_apps_Auditor:AnaOS Auditor (org.anaos.auditor)"
  "platform_packages_apps_AppStore:AnaOS App Store (org.anaos.appstore)"
  "platform_packages_apps_SetupWizard:AnaOS Setup Wizard"
  "platform_packages_apps_PdfViewer:AnaOS PDF Viewer"
  "platform_external_vanadium:Hardened Chromium / WebView"
  "meta:Project meta, plan, and bootstrap docs"
)

echo "Creating repositories under org: ${ORG}"

for entry in "${REPOS[@]}"; do
  name="${entry%%:*}"
  desc="${entry#*:}"
  if gh repo view "${ORG}/${name}" >/dev/null 2>&1; then
    echo "skip  ${ORG}/${name} (exists)"
    continue
  fi
  gh repo create "${ORG}/${name}" \
    --public \
    --description "${desc}" \
    --disable-wiki
  echo "ok    ${ORG}/${name}"
done

echo "Done. Next: push this workspace to ${ORG}/meta (or branding + docs split)."
