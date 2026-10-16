#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
export PATH=/root/bin:$PATH
apt-get update -qq
apt-get install -y -qq git-core gnupg flex bison build-essential zip curl zlib1g-dev \
  libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
  libxml2-utils xsltproc unzip fontconfig python3 python3-pip python-is-python3 \
  rsync ccache openjdk-17-jdk wget ca-certificates
mkdir -p /root/bin /opt/anaos
if [[ ! -x /root/bin/repo ]]; then
  curl -fsSL https://storage.googleapis.com/git-repo-downloads/repo -o /root/bin/repo
  chmod a+x /root/bin/repo
fi
grep -q '/root/bin' /root/.bashrc || echo 'export PATH=/root/bin:$PATH' >> /root/.bashrc
git config --global user.name "AnaOS Maintainers Levani"
git config --global user.email "Levan.alughishvili92@gmail.com"
ccache -M 50G || true
cat > /opt/anaos/HOST_STATUS.md <<'EOF'
# anaos-build (Hetzner CPX62)
- ip: 188.34.189.66
- specs: 16 vCPU / 32GB RAM / ~600GB disk
- note: ccx43+ blocked by new-account dedicated-core limit
EOF
repo version
echo BOOTSTRAP_OK
