#!/bin/bash

echo "Checking for Jetson Containers Environment Var"
JETSON_CONTAINERS=${JETSON_CONTAINERS:-"$PWD/jetson-containers"}
echo "Jetson Containers Dir: $JETSON_CONTAINERS"

echo "Installing pip requirements of Jetson Containers"
python3 -m pip install -r $JETSON_CONTAINERS/requirements.txt

echo "Running autotag to get image tags..."
AUTOTAG_COMMAND="$($JETSON_CONTAINERS/autotag ros:humble-desktop opencv:cuda l4t-ml)"
echo "Autotag Command Output: $AUTOTAG_COMMAND"

# Check if the number of arguments is greater than 0
if [ $# -gt 0 ]; then
    echo "Passing Argument to Docker: $@"
    echo "$JETSON_CONTAINERS/run.sh --volume $PWD:/root --workdir /root $AUTOTAG_COMMAND run_this_in_docker.sh"
    $JETSON_CONTAINERS/run.sh \
        --volume $PWD:/root \
        --workdir /root \
        $AUTOTAG_COMMAND \
        "$@"
else
    echo "Defaulting to Build OrbSlam 3 only."
    echo "$JETSON_CONTAINERS/run.sh --volume $PWD:/root --workdir /root $AUTOTAG_COMMAND run_this_in_docker.sh"
    $JETSON_CONTAINERS/run.sh \
        --volume $PWD:/root \
        --workdir /root \
        $AUTOTAG_COMMAND \
        "/root/run_this_in_docker.sh"
fi