# Modifications
There are a number of mods applied / or had to be applied to make it work on Tuckoo properly.

Public version is here: https://github.com/UZ-SLAMLab/ORB_SLAM3

- gui was completely stripped out. No Panoglin dependency now
- build was updated to use the same c++ toolchain that was available on Tuckoo
- OpenCV dependency was downgraded to match tuckoo's 3.4
- Eigen dependency was downgraded to match the older version of OpenCV (3.4.0)
- Metrics logging was added to the code base to get end to end latency
- PBS Batch files and Dataset download scripts were added to allow easy testing
- evaluated the pThread tasklevel parallelization 
- added CUDA support to build, via define in source code (a bit hacky)

# To build
## Normal version, with Pthread:
	install Eigen3.4.0
	provide Eigen's CMakeFile to Sophus, g2o, and DBoW (so they can find the includes + libs)
		cmake .. -DCMAKEMODULES=<path to eigen3's cmake>
	Once all dependencies are built:
		go to ORBSlam, and perform the same procedure to provide it with Eigen3.4.0
	Note: if using public version, downgrade from openCV 4.4 to 3.4 (on tuckoo)	
	the $build.sh script creates all the directories and does the cmake operation
	You're ready to run examples!

## Cuda Version, with Pthread:
	a bit more involved - manually invoking the linker will be required, and requires a properly working normal version build (as you'll see shortly). TODO: make more elegant in the future, one day
	zero, create a copy of the ORBextractor, but renamed to cu
		I've provided a reference version, but feel free to override
			$ cp orb_slam3/src/ORBextractor.cc ORBextractor.cu
	first, compile
		NVCC is only available on GPU nodes, so make sure you start an interactive session on one of those supported nodes.
			$ qsub -I -l nodes=1:ppn=16:p100 -N interactive 
		Then issue the compile command
			$ nvcc -DCUDA -c ORBextractor.cu -Iorb_slam3/include -o
 ORBextractor.o
	second, link with rest of object files to make shared lib, LibORB_SLAM3.so
		edit orb_slam3/build/CMakeFiles/ORB_SLAM3.dir/link.txt, replacing the location of ORBxtractor.o with the one just built
		in my build, this meant copying the ORBextractor.o made in step to, to the location shown in build/CMakeFiles/ORB_SLAM3.dir/link.txt: build/CMakeFiles/ORB_SLAM3.dir/src/ORBextractor.cc.o
			$ cp ORBextractor.o orb_slam3/build/CMakeFiles/ORB_SLAM3.dir/src/.
		then running the link.txt in the build directory
			$ source CMakeFiles/ORB_SLAM3.dir/link.txt
		This generates orb_slam3/lib/libORB_SLAM3.so, with our cuda code!
	third, rebuild the target executable / pipeline, with cuda!
		Located at CMakeFiles/stereo_euroc.dir/link.txt, append the following:
		-L/usr/local/cuda/lib64 -lcudart
	finally invoke the linker, and run example!
		In the same method as above, navigate to the build directory and source the link.txt
		the text file can be sourced to invoke it, or simply copying and pasting - 
		the binary will be the same one used by the PBS script (or alternatively rename if you like)
			$ source CMakeFiles/stereo_euroc.dir/link.txt

	final note: the runSimulation script uses the nums variable as an indicator of which run it's doing, it doesn't actually check. Feel free to modify however you like

	(yes I know it's a bit hacky, but ran out of time! I'm excited we go it running on Tuckoo :) )
		

# Run some examples!
Use the load_datasets.sh script to download the dataset we used here.

Once downloaded, to run an example:
- ./Examples/Stereo/stereo_euroc ./Vocabulary/ORBvoc.txt ./Examples/Stereo/EuRoC.yaml ~/Datasets/EuRoc/MH01 ./Examples/Stereo/EuRoC_TimeStamps/MH01.txt dataset-MH01_stereo

Or use the top level script in an interactive tuckoo session interactive_run_mh01_easy.sh

A script is provided to allow automated job generation ( runSimulations.sh ). This script makes a bunch of PBS batch files and queues them for running.
