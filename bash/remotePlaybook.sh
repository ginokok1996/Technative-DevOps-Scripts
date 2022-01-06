#!/bin/bash

#define flags
while getopts d:f: flag
do
    case "${flag}" in
        d) destination=${OPTARG};;
        f) fileName=${OPTARG};;
    esac
done

#stop script if destination flag is empty
if [ -z "$destination" ]
then
      echo "destination flag is empty";
      exit 1;
fi

#default to playbook.yml is fileName flag is empty
if [ -z "$fileName" ]
then
      echo "fileName flag is empty defaulting to playbook.yml";
      filename="playbook.yml";
fi

#retrieve the repository name
NAME=${destination##*/};

#install git cli if not present already
sudo yum install git -y;

#creates tmp folder for the repository and navigates to it
mkdir /tmp/playbook;
cd /tmp/playbook;

#clones the respository to the created tmp folder and navigates to repo
git clone $destination;
cd $NAME;

#checks if we can find the file and if so run ansible-playbook with it
if test -f "$fileName"; then
    ansible-playbook $fileName;
else 
    echo "Unable to find file";
    exit 1;
fi

#remove the temp folder
rm -r /tmp/playbook -f;