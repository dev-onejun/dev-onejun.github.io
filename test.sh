#!/bin/bash

name=$(basename "$PWD")
jekyll_port=4000

if [ -z "$1" ]; then
    echo "Please give the port number that you want to run docker container"
    exit 1

elif [ "$1" = "clean" ]; then
    docker stop "$name"
    docker rm "$name"
    docker rmi "test/$name:latest"

else
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Wrong options! Please try again with a valid port number or 'clean'."
        exit 1

    elif [ "$1" -ge 2000 ] && [ "$1" -le 65535 ]; then
        if [ -z "$(docker images -q "test/$name")" ]; then
            if docker build -t "test/$name" .; then
                echo -e "\n**************************"
                echo -e "Test image built successfully."
                echo -e "To rebuild, run with 'clean' option first."
                echo -e "**************************\n"
            else
                echo "Docker build failed!"
                exit 1
            fi
        fi

        docker run --rm -it -p "$1:$jekyll_port" -v "$PWD:/usr/src/app" --name "$name" "test/$name:latest"

    else
        echo "Invalid port range. Please use 2000 <= PORT <= 65535"
        exit 1
    fi
fi
