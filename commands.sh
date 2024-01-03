apt update
apt install -y libboost-all-dev libglew-dev libssl-dev

git clone --recursive https://github.com/stevenlovegrove/Pangolin pangolin
mkdir build && cd build && cmake ../pangolin && make -j && make install && cd ..

git clone -b c++14_comp https://github.com/UZ-SLAMLab/ORB_SLAM3.git orb_slam3
cd orb_slam3 && chmod +x build.sh && ./build.sh

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib 
