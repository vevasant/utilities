## Managing ENCRYPTION in PUPPET

PUPPET is a configuration management tool used in deploying and managing the applications in cloud environment.
Maintaining confidential data such as passwords etc.. in such system is required. This is achieved using eyaml 
tool bundled with Puppet.

Here encrypt.sh script encrypts each of the entries (value of the variable) in each line of entries.txt and stores the encrypted value 
in a specified yaml file for the variable.This script also helps in re-generating encrypted string for a variable such as password
whose value may change over period of time.

### Execution

1. Update eyaml.properties file (hiera_datadir,private_key and public_key location) according to your setup.
2. Update entries.txt with the values which needs to be encrypted -> <var_name>,<var_value>,<relative_location_of_yaml_file>
3. Run encrypt.sh



