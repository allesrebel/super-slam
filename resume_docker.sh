#/bin/bash

# starts a fresh session using an existing docker container image

# Check if the number of arguments is greater than 0
if [ $# -gt 0 ]; then
    docker run --runtime nvidia -it --rm --network host --volume /tmp/argus_socket:/tmp/argus_socket --volume /etc/enctune.conf:/etc/enctune.conf --volume /etc/nv_tegra_release:/etc/nv_tegra_release --volume /tmp/nv_jetson_model:/tmp/nv_jetson_model --volume /var/run/dbus:/var/run/dbus --volume /var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket --volume /var/run/docker.sock:/var/run/docker.sock --volume /home/rebel/jetson_orbslam3/jetson-containers/data:/data --device /dev/snd --device /dev/bus/usb -e DISPLAY=localhost:10.0 -v /tmp/.X11-unix/:/tmp/.X11-unix -v /tmp/.docker.xauth:/tmp/.docker.xauth -e XAUTHORITY=/tmp/.docker.xauth --volume /home/rebel/jetson_orbslam3:/root --volume /run/jtop.sock:/run/jtop.sock --workdir /root --cap-add SYS_ADMIN $@ bash
else
    echo Please Provide A Image hash!
    docker images
fi