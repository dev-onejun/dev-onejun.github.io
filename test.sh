#!/bin/bash

name=$(basename $PWD)
jekyll_port=4000

if [ -z $1 ]; then
    echo -e "Please give the port number that you want to run docker container"

elif [ $1 = "clean" ]; then
    docker stop $name
    docker rm $name
    docker rmi test/$name:latest

elif [ $1 != "clean" ]; then
    if ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo -e "Wrong options !!! Please try again with the proper one."

    # run test with the given port number
    elif [ $1 -ge 2000 ] && [ $1 -le 65536 ]; then
        if [ -z "$(docker images | grep test/$name)" ]; then
            docker build -t test/$name .

            echo -e "\n\n\n**************************" &&
            echo -e "test image is built successfully.\nIf you want to rebuild the image, Please run the command again with 'clean' option" &&
            echo -e "**************************"
        fi

        docker run --rm -it -p $1:$jekyll_port -v $PWD:/usr/src/app --name $name test/$name:latest

    #elif [ $1 -lt 2000 ] && [ $1 -gt 65536 ]; then
    else
        echo -e "Wrong range of ports. Please try again with 2000 <= PORT <= 65536"

    fi

fi
