<toc>
# Table of Contents
[*Last generated: Fri 18 Nov 2022 18:47:51 EST*]
- [**Jetson AGX Orin - RT Kernel Final Guide:**](#Jetson-AGX-Orin-RT-Kernel-Final-Guide)
- [**Common**](#Common)
  - [Recommended Tool-sets:](#Recommended-Tool-sets)
    - [oh-my-zsh](#oh-my-zsh)
    - [tmux](#tmux)
    - [Fan-Control](#Fan-Control)
    - [Jetson Links:](#Jetson-Links)
- [**JETSON AGX ORIN:**](#JETSON-AGX-ORIN)
  - [NVMe SSD Installation & bootsetup](#NVMe-SSD-Installation-bootsetup)
  - [Kernel](#Kernel)
  - [Direct NVMe Install](#Direct-NVMe-Install)
- [**JETSON TX2 - ARUCO:**](#JETSON-TX2-ARUCO)
  - [Ubuntu 18.04](#Ubuntu-1804)
  - [ROS - Melodic](#ROS-Melodic)
    - [Catkin tools](#Catkin-tools)
    - [Open cv](#Open-cv)
    - [all ros dependencies:](#all-ros-dependencies)
    - [python2.7 ros dep:](#python27-ros-dep)
  - [Python Packages:](#Python-Packages)
  - [ZED](#ZED)
  - [ROS Melodic with Python3](#ROS-Melodic-with-Python3)


</toc>
> ⚠️ Last updated: Sept. 21, 2022

# Jetson AGX Orin - RT Kernel Final Guide:

> :notebook: TAG: jetson_35.1, the public release DOES NOT HAVE RT KERNEL, SAD!!
>
> - So you have to compile from source:

1. Compile custom kernel:

   1. In your browser, go to https://developer.nvidia.com/embedded/jetson-linux-archive.

   2. Locate and download the Jetson Linux source files for your release.

   3. Extract the `.tbz2` file:

      ```bash
      $ tar -xjf public_sources.tbz2
      ```

   4. Extract the kernel source file:

      ```bash
      $ cd Linux_for_Tegra/source/public
      $ export TEGRA=$HOME/{somewhere}/Linux_for_Tegra/source/public
      $ tar –xjf kernel_src.tbz2
      ```

      This extracts the kernel source to the `kernel/`subdirectory.

   5. Apply RT Kernel: 

      ```bash
      $ cd $TEGRA/kernel
      $ ./kernel-5.10/scripts/rt-patch.sh apply-patches
      ### OUTPUT:
      #> The PREEMPT RT patches have been successfully applied!
      ```

   6. :no_entry_sign:**(ON NON-Jetson PC)** Cross Compile:

      ```bash
      $ export CROSS_COMPILE_AARCH64_PATH=<toolchain-path>
      $ export CROSS_COMPILE_AARCH64=<toolchain-path>/bin/aarch64-buildroot-linux-gnu-
      ```

   7. Kernel out:

      ```bash
      $ cd {somewhere}/kernel_out
      $ export kernel_out={somewhere}/kernel_out
      ```

   8. Build:

      ```bash
      $ cd $TEGRA && ./nvbuild.sh -o $kernel_out
      ```

2. Apply built to the root:

   1. Replace `/boot/Image` with a copy of this file:

      ```bash
      # a copy backup:
      $ sudo mv /boot/kernel/Image /boot/kernel/Image.bak.non-rt
      # override:
      $ sudo cp $kernel_out/arch/arm64/boot/Image /boot/kernel/Image
      ```

   4. Reboot:

      ```bash
      $ sudo reboot 0
      ```

3. Compile PCAN with this custom rt-kernel:

   ```bash
   # download driver:
   $ wget https://www.peak-system.com/fileadmin/media/linux/files/peak-linux-driver-8.15.2.tar.gz
   
   # unzip:
   $ tar -xzf peak-linux-driver-8.15.2.tar.gz
   
   # define sth:
   $ export kernel_out=/home/uwarl-orin/JX_Linux/kernel_out
   
   # build driver with netdev and specified kernel:
   # doesnt work: $ make -C driver NET=NETDEV_SUPPORT KERNEL_LOCATION=$kernel_out 
   $ make NET=NETDEV_SUPPORT KERNEL_LOCATION=$kernel_out
   
   # install:
   $ make install KERNEL_LOCATION=$kernel_out
   
   # GUCCI
   ```

   > :warning: NETDEV support is needed for WAM
   >
   > :warning: Kernel location should be the compiled kernel output with RT-kernel, the `/usr/src` does not contain rt-kernel with custom build

4. To set up an NVMe drive manually for booting

   1. For this method, confirm that the device can boot successfully from eMMC. If it cannot, correct the problem by flashing to eMMC first.

   2. Connect the NVMe drive to the host computer.

   3. Check the NVMe drive’s device name (e.g. /dev/nvme0n1):

      ```bash
      $ lsblk -d -p | grep nvme | cut -d\ -f  1
      ```

      > Note that there must be two spaces after the ‑d\.

   4. Create a new GPT

      ```bash
      $ sudo parted /dev/nvme0n1 mklabel gpt
      ```

   5. Create Partition:

      ```bash
      $ sudo parted /dev/nvme0n1 mkpart APP 0GB 500GB
      ```

   6. Format APP as an ext4 partition and mount it.

      ```bash
      $ sudo mkfs.ext4 /dev/nvme0n1p1 
      $ sudo mount /dev/nvme0n1p1 /mnt
      ```

5. Flash to NVMe on Jetson from Host PC:

   ```bash
   $ cd $TEGRA 
   $ sudo BOOTDEV=nvme0n1p1 ./flash.sh jetson-agx-orin-devkit nvme0n1p1
   
   
   ###
   #$ sudo mkdir tmp_system 
   #$ sudo mount bootloader/system.img.raw ./tmp_system 
   #$ sudo rsync -axHAWX --numeric-ids --info=progress2 --exclude=/proc ./tmp_system/ /mnt
   ```

6. Boot Computer and enter BIO with [ESC] at boot screen

   1. configure boot order to the `nvme` over `emmc`

7. [WHACKY ALERT] $kernel_out is actually part of the kernel headers , so I just copy over to the header and renamed the original header to contain rt `$TEGRA/rootfs/usr/src/linux-headers-5.10.104-rt63-tegra-ubuntu20.04_aarch64/kernel-5.10`

1. XFCE XRDP: https://www.hiroom2.com/ubuntu-2004-xrdp-xfce-en/

----

# Common

## Recommended Tool-sets:

### oh-my-zsh

- install zsh first `sudo apt install zsh`
- https://github.com/ohmyzsh/ohmyzsh

### tmux

- https://linuxize.com/post/getting-started-with-tmux/
- Pretty/Easy-to-use Custom Mod: https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/ (except ctrl-b mod)

### Fan-Control

- https://github.com/yqlbu/fan-control

### Jetson Links:

- [Wiki - Jetson ZOO](https://elinux.org/Jetson_Zoo): guide to everything that has to be installed manually, add-on packages on NVIDIA Jetson



# JETSON AGX ORIN:
- [Review page from Jetson Hacks](https://jetsonhacks.com/2022/04/04/nvidia-jetson-agx-orin-developer-kit/)
> Jetson AGX Orin delivers a 3-6X performance gain over Jetson AGX Xavier.
> 1.5-2X boost for the CPU, 4X GPU cores --> 3-10X Boost comparing to Xavier
- [Docs/Jetson/DeveloperGuide](https://docs.nvidia.com/jetson/archives/r34.1/DeveloperGuide/text/SO/JetsonAgxOrin.html)
    - Bootloader and NVMe
    - [Jetson Linux Real-Time Kernel Package](https://docs.nvidia.com/jetson/archives/r34.1/DeveloperGuide/text/SD/Kernel/KernelCustomization.html#using-the-jetson-linux-real-time-kernel-package)
- **Ubuntu 20.04** , **12 core**, **32MB DDR5 Memory**

## NVMe SSD Installation & bootsetup

> :warning: You do not need this step anymore, with latest SDK, you can install directly onto NVMe, instead of this wacky setup

1. Partition NVMe into swap / boot / filesystems
2. setup for direct booting: https://jetsonhacks.com/2020/05/29/jetson-xavier-nx-run-from-ssd/

> :warning: To upgrade OS, you need to copy from ssd/boot to emmc/boot:
>
> ```bash
> sudo mount /dev/mmcblk0p1 /mnt
> cp -r /boot/* /mnt/boot/
> ```
>
> - Because, the system boot from emmc and is directed to nvme by service, hence, local modification of boot on nvme would not affect the OS at all. Hence a reverse sync by copying over is required.

## Kernel

- https://developer.ridgerun.com/wiki/index.php/NVIDIA_Jetson_Orin/JetPack_5.0.2/Compiling_Code/Kernel

## Direct NVMe Install

https://media.digikey.com/pdf/Data%20Sheets/Seeed%20Technology/Flashing_Booting_the_Target_Device_NVIDIA_Docs.pdf



----
# JETSON TX2 - ARUCO:
## Ubuntu 18.04
- To install Jetson Ubuntu, we need to use *SDK Manager* on a Desktop with **Ubuntu 18.04** (20.04 does not support SDK installation, SAD)

## ROS - Melodic
- a nicely script made by jetsonhacks: https://github.com/jetsonhacks/installROS

### Catkin tools
- https://catkin-tools.readthedocs.io/en/latest/installing.html

### Open cv
```
sudo apt install libopencv-dev=3.2.0+dfsg-4ubuntu0.1
```

### all ros dependencies:
```rosdep install --from-paths src --ignore-src --rosdistro=melodic -y```

### python2.7 ros dep:
```
sudo apt-get install ros-melodic-trac-ik
```

## Python Packages:
- install numpy, scikit-image, scikit-learn: https://forums.developer.nvidia.com/t/how-to-install-numpy-scikit-image-scikit-learn-on-jetson-tx2/83819
- install opencv: https://qengineering.eu/install-opencv-4.5-on-jetson-nano.html 
	- ROS fixes: [fix /opt/ros/melodic/share/cv_bridge/cmake/cv_bridgeConfig.cmake](https://github.com/ros-perception/vision_opencv/issues/345)

## ZED
- please install the python packages and opencv in the way mentioned in previous section
- https://www.stereolabs.com/docs/installation/jetson/
- build zed_ros_wrapper: https://www.stereolabs.com/docs/ros/


> ⚠️ actual IP may depend on the configuration, but here is our config:
```
#export ROS_MASTER_URI=http://192.168.0.178:11311
export ROS_MASTER_URI=http://192.168.0.200:11311/
export ROS_IP=192.168.0.150
#export ROS_HOSTNAME=192.168.0.150
```

## ROS Melodic with Python3
- https://www.miguelalonsojr.com/blog/robotics/ros/python3/2019/08/20/ros-melodic-python-3-build.html

