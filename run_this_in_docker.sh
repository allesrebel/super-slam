apt update

# depedencies of orbslam and pangolin
apt install -y libboost-all-dev libglew-dev libssl-dev

# Pangolin is included as a submodule, BUT if you want, you can manually
# git clone --recursive https://github.com/stevenlovegrove/Pangolin pangolin
cd pangolin && mkdir -p build && cd build && cmake .. && make -j && make install && cd

# orbslam3 is included as a submodule, BUT if you want, you can manually
# git clone -b c++14_comp https://github.com/UZ-SLAMLab/ORB_SLAM3.git orb_slam3
cd orb_slam3 && chmod +x build.sh && ./build.sh # stay in orbslam dir

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib 
