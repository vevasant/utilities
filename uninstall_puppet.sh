#!/usr/bin/env bash
# This script uninstalls Puppet on CentOS , RHEL 5.x,6.x,7.x
# It has been tested on RHEL 6.6 64bit

puppetlabs_pkg_name="puppetlabs-release-\$RELEASE_VERSION-11.noarch"

# Check if it is root user
if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Uninstalling puppet
which puppet > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
   echo "Uninstalling puppet.."
   yum remove -y puppet > /dev/null 2>&1
else
   echo "Puppet is not installed."
   exit 0
fi

# Determine RHEL or Centos release version
release_info=$(</etc/redhat-release)
[[ $release_info =~ [^0-9]*([0-9]+)\.?[0-9]+ ]]
release_version=${BASH_REMATCH[1]}

# Update puppetlabes_pkg_name with release version
puppetlabs_pkg_name="$(echo $puppetlabs_pkg_name | sed "s/\$RELEASE_VERSION/${release_version}/g")"

# Disable the Puppet Labs Package Repository
rpm -e "${puppetlabs_pkg_name}" >/dev/null 2>&1

echo "Successfully uninstalled puppet!"