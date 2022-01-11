#!/bin/bash

# Define flags
while getopts d:f: flag
do
    case "${flag}" in
        d) destination=${OPTARG};;
        f) fileName=${OPTARG};;
    esac
done

# Stop script if destination flag is empty
if [ -z "$destination" ]
then
      echo "destination flag is empty";
      exit 1;
fi

# Default to playbook.yml is fileName flag is empty
if [ -z "$fileName" ]
then
      echo "fileName flag is empty defaulting to playbook.yml";
      filename="playbook.yml";
fi

# Retrieve the repository name
NAME=${destination##*/};

# Install git cli if not present already
sudo yum install git -y;

# Creates tmp folder for the repository and navigates to it
mkdir /tmp/playbook;
cd /tmp/playbook;

# Clones the respository to the created tmp folder and navigates to repo
git clone $destination;
cd $NAME;

# Checks if we can find the file and if so run ansible-playbook with it
if test -f "$fileName"; then
    ansible-playbook $fileName;
else 
    echo "Unable to find file";
    rm -r /tmp/playbook -f;
    exit 1;
fi

# Remove the temp folder
rm -r /tmp/playbook -f;
