# Note: this repo uses submodules!
- Don't forget to clone recursively
# Quick Setup!
- Install JetPack SDK onto a Jetson Device, along with the docker runtime. [Getting Starting Guide](https://developer.nvidia.com/embedded/learn/get-started-jetson-agx-orin-devkit)
- Clone the Docker Container Repo [Nvidia Containers](https://github.com/dusty-nv/jetson-containers/blob/master/docs/setup.md)
- (jetson containers repo)/run.sh --volume $PWD:/root $(jetson-containers repo)/autotag ros:humble-desktop opencv:cuda )
- source run_this_on_native.sh

# Run some examples!
- cd
- mkdir -p Datasets/EuRoc
- cd Datasets/EuRoc/
- wget -c http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_01_easy/MH_01_easy.zip
- mkdir MH01
- unzip MH_01_easy.zip -d MH01/
- cd orb_slam3
- ./Examples/Stereo/stereo_euroc ./Vocabulary/ORBvoc.txt ./Examples/Stereo/EuRoC.yaml ~/Datasets/EuRoc/MH01 ./Examples/Stereo/EuRoC_TimeStamps/MH01.txt dataset-MH01_stereo
