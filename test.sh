#!/bin/bash

name=$(basename $PWD)

if [ -z $1 ]; then
    echo -e "Please give the port number that you want to run docker container"

elif [ $1 = "clean" ]; then
    sudo docker stop $name
    sudo docker rm $name
    sudo docker rmi test/$name:latest

elif [ $1 = "run" ]; then
    sudo docker stop $name
    sudo docker rm $name
    sudo docker run -d -p $1:4000 -v $PWD:/mnt --name $name test/$name:latest &&
        echo -e "Re-run the container"

elif [ $1 != "clean" ]; then
    if ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo -e "Wrong options !!! Please try again with the proper one."

    # run test with the given port number
    elif [ $1 -ge 2000 ] && [ $1 -le 65536 ]; then
        if [ -z "$(sudo docker images | grep test/$name)" ]; then
            sudo docker build -t test/$name .

            echo -e "\n\n\n**************************" &&
            echo -e "test image is built successfully.\nIf you want to rebuild the image, Please run the command again with 'clean' option" &&
            echo -e "**************************"
        fi

        sudo docker run --rm -it -p $1:4000 -v $PWD:/mnt --name $name test/$name:latest bundle exec jekyll serve -H 0.0.0.0 --port=4000

        echo -e "is it run?"


    #elif [ $1 -lt 2000 ] && [ $1 -gt 65536 ]; then
    else
        echo -e "Wrong range of ports. Please try again with 2000 <= PORT <= 65536"

    fi

fi
