#!/bin/bash
# This script is used to generate and store encrypted values for the variables in specified yaml file.
# Make sure entries.txt has a list of variables which are new or whose values has changed else
# already existing value in the yaml file will be overwritten.

. ./eyaml.properties

function encryptnstore() {
     # eyaml encrypt regenerates new encrypted value for the same string value during each run of it.
     var_value=`eyaml encrypt --pkcs7-private-key $private_key --pkcs7-public-key $public_key -s $var_value -o string`

     if grep -q "$var_name:" "$yaml_file"; then
        if ! ( grep -q "$var_name: $var_value" "$yaml_file"); then
          sed -i "s|^\s*$var_name:.*|$var_name: $var_value|g" $yaml_file
          echo "Stored new encrypted value for '$var_name' in '$yaml_file'"
        fi
     else
        echo "$var_name: $var_value" >> $yaml_file
        echo "Stored encrypted value for '$var_name' in '$yaml_file'"
     fi
}

while read line           
do           
    if ! [[ $line =~ ^#.* ]]; then
       var_name=$(echo $line |cut -d',' -f1)
       var_value=$(echo $line |cut -d',' -f2)
       yaml_file=$(echo $line |cut -d',' -f3)
       if [ -z $var_name ]; then 
          echo "ERROR: Specify variable name."
          exit 0 
       elif [ -z $var_value ]; then
          echo "ERROR: Specify value for the variable '$var_name'."
          exit 0
       elif ! [ -e $hiera_datadir/$yaml_file ]; then
          echo "ERROR: $hiera_datadir/$yaml_file file doesn't exists."
          exit 0
       else
         yaml_file=$hiera_datadir/$yaml_file
       fi
       encryptnstore
    fi
done < ./entries.txt

