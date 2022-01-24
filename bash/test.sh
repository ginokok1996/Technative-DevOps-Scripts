#!/bin/sh
echo "Lets make sure to attach the correct variables to the environment you want to work in."
read -p "$(echo -e 'Which shell would you like to use? (enter bash or sh) \n\b')" shell
read -p "$(echo -e 'Which environment variables should be loaded? (enter dev or rc) \n\b')" answer

set -o allexport

case $answer in

  dev)
    source docker/pb-test/config/.env.pb_dev
    ;;

  rc)
    source docker/pb-test/config/.env.pb_rc
    ;;

  *)
    echo "Incorrect command please retry with either dev or rc"
    exit
    ;;

esac

set -o allexport

case $shell in

  bash)
    /bin/bash
    ;;

  sh)
    /bin/sh
    ;;

  *)
    echo "Incorrect command please retry with either dev or rc"
    exit
    ;;

esac
