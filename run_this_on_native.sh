#! /bin/bash

~/nvme/jetson-containers/run.sh --volume $PWD:/root $(~/nvme/jetson-containers/autotag ros:humble-desktop opencv:cuda l4t-ml )
