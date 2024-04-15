#!/bin/bash

# This script starts timing the MH01 easy
# video file, while collecting stats of
# system level metrics and internal metrics
# of ORBSLAM3

# start timing with JTOP
python3 stats/collect_jtop_stats.py > jtop_stats.log &

# start perf
stats/kernel/kernel-jammy-src/tools/perf/perf record &

# move into orbslam for the final command
cd orb_slam3

# finally do the actual orbslam with sample video
./Examples/Stereo/stereo_euroc ./Vocabulary/ORBvoc.txt ./Examples/Stereo/EuRoC.yaml ~/Datasets/EuRoc/MH01 ./Examples/Stereo/EuRoC_TimeStamps/MH01.txt dataset-MH01_stereo

# save results into results folder
cd && mkdir -p result_mh01
mv perf.data jtop_stats.log result_mh01/
mv orb_slam3/ExecMean.txt orb_slam3/LocalMapTimeStats.txt orb_slam3/ExecMean.txt orb_slam3/f_dataset-MH01_stereo.txt orb_slam3/SessionInfo.txt orb_slam3/kf_dataset-MH01_stereo.txt orb_slam3/LBA_Stats.txt orb_slam3/TrackingTimeStats.txt result_mh01/
