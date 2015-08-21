
#!/usr/bin/env bash
# This bootstraps Puppet on CentOS , RHEL 5.x,6.x,7.x
# It has been tested on RHEL 6.4 64bit

set -e

REPO_URL="http://yum.puppetlabs.com/puppetlabs-release-el-\$RELEASE_VERSION.noarch.rpm"

# Updates REPO_URL with release version
release_info=$(</etc/redhat-release)
[[ $release_info =~ [^0-9]*([0-9]+)\.?[0-9]+ ]]
release_version=${BASH_REMATCH[1]}
  
REPO_URL="$(echo $REPO_URL | sed "s/\$RELEASE_VERSION/${release_version}/g")"

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

if which puppet > /dev/null 2>&1; then
  echo "Puppet is already installed."
  exit 0
fi

# Install puppet labs repo
echo "Configuring PuppetLabs repo..."
repo_path=$(mktemp)
wget --output-document="${repo_path}" "${REPO_URL}" 2>/dev/null
rpm -i "${repo_path}" >/dev/null

# Install Puppet...
echo "Installing puppet"
yum install -y puppet > /dev/null

echo "Puppet installed!"




