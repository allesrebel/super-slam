# Quick Setup!
- Install JetPack SDK onto a Jetson Device, along with the docker runtime. [Getting Starting Guide](https://developer.nvidia.com/embedded/learn/get-started-jetson-agx-orin-devkit)
- Clone the Docker Container Repo [Nvidia Containers](https://github.com/dusty-nv/jetson-containers/blob/master/docs/setup.md)
- (jetson containers repo)/run.sh --volume $PWD:/root $(jetson-containers repo)/autotag ros:humble-desktop opencv:cuda )
- source commands.sh
