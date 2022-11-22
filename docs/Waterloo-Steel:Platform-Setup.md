<toc>

# Table of Contents
[*Last generated: Mon 21 Nov 2022 20:22:24 EST*]
- [**1. Adlink MXE 211 (Robotnik SUMMIT PC)**](#1-Adlink-MXE-211-Robotnik-SUMMIT-PC)
  - [1.1 RT Kernel](#11-RT-Kernel)
  - [1.2  Peak Linux Driver](#12-Peak-Linux-Driver)
  - [1.3 Summit Hardware Library](#13-Summit-Hardware-Library)
  - [1.4 Sony PS PAD Controller](#14-Sony-PS-PAD-Controller)
  - [1.5 Pixhawk PX4 Flight Controller - Chassis IMU](#15-Pixhawk-PX4-Flight-Controller-Chassis-IMU)
  - [1.6 Velodyn (VLP 16)](#16-Velodyn-VLP-16)
  - [1.7 Install ROS:](#17-Install-ROS)
  - [1.8 [:star:] UWARL ROS Catkin Workspace Setup](#18-star-UWARL-ROS-Catkin-Workspace-Setup)
    - [1.8.1 ⭐ [Automated] Install Catkin Workspace + Hardware Setup](#181-Automated-Install-Catkin-Workspace-Hardware-Setup)
      - [1.8.1-(3) How to Build Hardware Package?](#181-3-How-to-Build-Hardware-Package)
    - [1.8.2 Setup Auto-launch at the boot:](#182-Setup-Auto-launch-at-the-boot)
- [**2. Jetson Orin (Barrett WAM External PC)**](#2-Jetson-Orin-Barrett-WAM-External-PC)
  - [2.0 Flash Linux OS & Install JetPack :v:](#20-Flash-Linux-OS-Install-JetPack-v)
    - [2.0.a eMMC SD](#20a-eMMC-SD)
    - [2.0.b NVMe SSD](#20b-NVMe-SSD)
      - [2.0.b.1 Flash Linux onto NVMe direct Boot:](#20b1-Flash-Linux-onto-NVMe-direct-Boot)
      - [2.0.b.2 Install Jetpack SDK:](#20b2-Install-Jetpack-SDK)
  - [2.1 (Jetson) RT Kernel](#21-Jetson-RT-Kernel)
  - [2.2 Peak Linux Driver  (Out-of-tree Linux RT Header)](#22-Peak-Linux-Driver-Out-of-tree-Linux-RT-Header)
  - [2.3 Libbarrett Hardware Library](#23-Libbarrett-Hardware-Library)
  - [2.4 ZED Stereo-Camera](#24-ZED-Stereo-Camera)
  - [2.5 Intel i515 Lidar Mono-Camera](#25-Intel-i515-Lidar-Mono-Camera)
  - [2.6 Install ROS](#26-Install-ROS)
  - [2.7 [:star: automated] UWARL ROS Catkin Workspace Setup](#27-star-automated-UWARL-ROS-Catkin-Workspace-Setup)
- [**3. Common:**](#3-Common)
  - [3.1 Remote Screen via SSH:](#31-Remote-Screen-via-SSH)
  - [3.2 SSH Keys & Github](#32-SSH-Keys-Github)
  - [3.3 Commonly used command:](#33-Commonly-used-command)
  - [3.4 ZSH & oh-my-zsh](#34-ZSH-oh-my-zsh)
  - [3.5 TMUX: virtual terminal within terminal](#35-TMUX-virtual-terminal-within-terminal)


</toc>

---

# 1. Adlink MXE 211 (Robotnik SUMMIT PC)

| Ubuntu 18.04 - RT | Intel(R) Atom(TM) Processor E3950 @ 1.60GHz - 4 Cores - x64_86 | ROS-Melodic | NOT_NETDEV PCAN | 8 GB | 25W-35.2W |
| ----------------- | ------------------------------------------------------------ | ----------- | --------------- | ---- | --------- |

## 1.1 RT Kernel

- RT kernel patch: https://stackoverflow.com/questions/51669724/install-rt-linux-patch-for-ubuntu

## 1.2  Peak Linux Driver



## 1.3 Summit Hardware Library



## 1.4 Sony PS PAD Controller





## 1.5 Pixhawk PX4 Flight Controller - Chassis IMU





## 1.6 Velodyn (VLP 16)

- ![Updated](resources/VLP_2022-10-19.png)

- Updated to 3.0.41 on Oct-19,2022

  - Now we have DHCP :) 

- > ⚠️ Make sure the velodyn is on different subnet with the router, else you will not be able to use wifi at all due to conflicts

- ROS: http://wiki.ros.org/velodyne/Tutorials/Getting%20Started%20with%20the%20Velodyne%20VLP16

  ```bash
  $ sudo apt-get install ros-melodic-velodyne
  # test launch
  $ roslaunch velodyne_pointcloud VLP16_points.launch	
  $ rosnode list
  $ rostopic echo /velodyne_points
  # rviz:
  $ rosrun rviz rviz -f velodyne
  ```




## 1.7 Install ROS:



## 1.8 [:star:] UWARL ROS Catkin Workspace Setup

### 1.8.1 ⭐ [Automated] Install Catkin Workspace + Hardware Setup
0. Install ROS and configure the environment necessary from previous section

1. Clone configurations: 
    ```zsh
    $ cd ~ && git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robot_configs.git
    ```
2. Install the repo with auto-script:
    ```zsh
    $ cd ~ && ./uwarl-robot_configs/scripts/auto-config_UWARL_catkin_ws.zsh
    ```

    > :notebook: this script will install automatically based on the **user name** (e.g. uwarl-orin) to identify the PC space

3. Install Hardware Package:

    ```bash
    $ sudo dpkg -i ~/uwarl-robot_configs/summit/ros-melodic-robotnik-msgs_2.2.0-0bionic_amd64.deb
    ```

    > :warning: You may not find this one from the server directly, but I did hard work for you, as stated below:

    #### 1.8.1-(3) How to Build Hardware Package?

    > :warning: In Melodic, you will see errror on dependency `melodic-msgs`, which is not available in melodic server, and required a local build, which will be done later with catkin build, just ignore this error

    1. :notebook: we can actually build one :D

       ```bash
       $ cd UWARL_catkin_ws/uwarl-robotnik_msgs
       $ catkin build --this
       $ bloom-generate rosdebian --os-name ubuntu --ros-distro melodic
       $ fakeroot debian/rules binary
       ```

    - Build base_hw dpkg:

      ```bash
      sudo dpkg -i uwarl-robotnik_base_hw/lib/ros-melodic-robotnik-base-hw-lib_****_amd64.deb
      ```

4. Configure ROS Environment:\

    ```bash
    # (Optional) Ensure ip are correct in the env.
    $ sudo vim ~/uwarl-robot_configs/summit/user_services/environment
    # Copy ROS env:
    $ sudo cp ~/uwarl-robot_configs/summit/user_services/environment ~/.ros/
    ```

5. Catkin Build:    

    ```bash
    # source robot config env & ros
    $ source ~/.zshrc
    # build:
    $ cd $ROS_CATKIN_WS && catkin_build
    ### Trick:
    $ build_ws # from anywhere, which will does the job for you :P (Jack is too lazy)
    ```

### 1.8.2 Setup Auto-launch at the boot:

- Let's use system boot as a method to auto-boot services, as they can be restarted easily with status logs

  > This is different from what Robotnik was doing, but way better :P

- User system Permissions:

  ```bash
  $ sudo usermod -a -G dialout $USER 
  $ sudo usermod -a -G root $USER
  ```

- Create auto roslaunch:

  ```bash
  $ cd ~
  # load system services:
  #[OPTIONAL] roscore only:
  $ sudo cp uwarl-robot_configs/summit/user_services/roscore.service /usr/lib/systemd/user
  #[this one] roscore and roslaunch:
  $ sudo cp uwarl-robot_configs/summit/user_services/roscorelaunch@.service /usr/lib/systemd/user
  #[OPTIONAL] depends on remote roscore:
  $ sudo cp uwarl-robot_configs/summit/user_services/roslaunch@.service /usr/lib/systemd/user 
  
  # create launch for summit:
  $ systemctl --user daemon-reload
  $ systemctl --user enable roscorelaunch@waterloo_steel_bringup:waterloo_steel_summit.launch
  
  # uninstall:
  $ systemctl --user disable roscorelaunch@waterloo_steel_bringup:waterloo_steel_summit.launch
  
  # Start at bootup instead of graphical login
  sudo loginctl enable-linger $USER
  ```

- Check:

  ```bash
  # check system:
  $ systemctl --user status roscorelaunch@waterloo_steel_bringup:waterloo_steel_summit.launch.service
  
  # restart:
  $ systemctl --user restart roscorelaunch@waterloo_steel_bringup:waterloo_steel_summit.launch.service
  
  # stop:
  $ systemctl --user stop roscorelaunch@waterloo_steel_bringup:waterloo_steel_summit.launch.service
  
  # check log:
  $ journalctl --user --user-unit=roscorelaunch@waterloo_steel_bringup:waterloo_steel_summit.launch.service
  # live:
  $ journalctl --follow --user --user-unit=roscorelaunch@waterloo_steel_bringup:waterloo_steel_summit.launch.service
  ```

- add to `~/zshrc`  (Preferred) or `~/bashrc` (scripts may be out-dated) for terminals:

  ```bash
  ## >>> Custom entries:
  source /home/uwarl/uwarl-robot_configs/summit/summitxl_ros_config.zsh
  # source /home/uwarl/uwarl-robot_configs/summit/summitxl_ros_config.bash # bash
  ## <<<< EOF .
  ```

  



# 2. Jetson Orin (Barrett WAM External PC)

| Ubuntu 20.04 - RT - Tegra | Arm® Cortex®-A78AE v8.2 64-bit CPU 2.2GHz - 12 Cores - aarch64/arm64 | ROS-Noetic | NETDEV PCAN | 32 GB | 15~60W |
| ------------------------- | ------------------------------------------------------------ | ---------- | ----------- | ----- | ------ |

## 2.0 Flash Linux OS & Install JetPack :v:

- On Ubuntu 20.04 PC, install SDK Manager
- Install [ **JetPack 5.0.2 | Jetson Linux r35.1**] Linux For Jetson AGX Orin Modules
  - **Jetson Linux Release Doc**: https://developer.download.nvidia.com/embedded/L4T/r35_Release_v1.0/Jetson_Linux_Release_Notes_r35.1.pdf
  - **Kernel Packages**:  https://docs.nvidia.com/jetson/archives/r35.1/DeveloperGuide/text/SD/Kernel/KernelCustomization.html#using-the-jetson-linux-real-time-kernel-package
  - Getting Started: https://developer.nvidia.com/embedded/learn/get-started-jetson-agx-orin-devkit
- Boot Jetson into Flashing mode (By restarting the hardware, while holding the other two buttons to enter the recovering mode.)

### 2.0.a eMMC SD 

-  Just use manual flashing mode with pre-configure:

  ```
  account: uwarl-orin
  password: xxxxxx
  ```

### 2.0.b NVMe SSD

#### 2.0.b.1 Flash Linux onto NVMe direct Boot:

> NVMe is much faster (x5-10) than EMMc SSD, but you would want to install JetPack and updates with eMMC first just in case.

1. Configure **BIOS**:

   - Boot Computer and enter BIO with [ESC] at the boot screen

   - configure boot order to the `nvme` over `emmc`

2. Try flash by selecting  **[ NVMe ]** in the pre-configure, along with:

   ```
   account: uwarl-orin
   password: xxxxxx
   ```

   >  :warning: It will fail at Flashing!!! At least it will prepare and compile all installation files. (R35.1), dunno if it will be fixed. To note, NVMe support and UEFI Boot Manager were only introduced after JetPack 5.

3. Manually flashing it:

   ```bash
   # In Host PC: 
   $ cd ~/{Target-HW-Image-Folder}/JetPack_5.0.2_Linux_JETSON_AGX_ORIN_TARGETS/Linux_for_Tegra
   # flash manually:
   $ sudo ./tools/kernel_flash/l4t_initrd_flash.sh --external-device nvme0n1p1 -c ./tools/kernel_flash/flash_l4t_external.xml -S 100 --erase-all --showlogs jetson-agx-orin-devkit nvme0n1p1
   ```

4. Plug-in DP Monitor, and manually configure ubuntu at boot with `uwarl-orin`

   > :cheese:  Last installation (Nov. 21, 2022) was successfully onto NVMe. **485.4 GB / 491.4 GB Available**, Boot directly from NVMe. 

   > [System Check]:
   >
   > - [x] Heat Sink Fan running
   > - [x] DP working
   > - [x] SSH available by default

   > ----
   >
   >  :no_good:  Last resource, to migrate onto NVMe manually in earlier releases: 
   >
   > https://github.com/jetsonhacks/rootOnNVMe (It's not booting from NVMe, but rather booting from eMMC, and switching to NVMe by a system-ctl service)

#### 2.0.b.2 Install Jetpack SDK:

1. After flashing OS, unplug the flashing USB cable, and launch SDK Manager 

   > Assuming Host PC and Jetson is under the same network (plug host PC WAN into the LAN port of the robot)

2. Skip the Jetson Linux Flashing Interface (by cancelling the selection)

3. Configure Ethernet for installing Jetson SDK:

   ![SDK_config](resources/SDK_config.png)

4. Wait for installation. And DONE :beers:

## 2.1 (Jetson) RT Kernel

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

   2. Reboot:

      ```bash
      $ sudo reboot 0
      ```

   3. Install new Kernel headers:

      ```bash
      # - copy kernel_out into `/usr/src/{uname -r}`
      $ sudo mkdir /usr/src/linux-headers-5.10.104-rt63-tegra-ubuntu20.04_aarch64/
      $ cd /usr/src/linux-headers-5.10.104-rt63-tegra-ubuntu20.04_aarch64/
      $ mkdir kernel-5.10
      $ sudo cp -r $kernel_out kernel-5.10
      # - inside `/usr/src/{uname -r}` to install into `/lib/modules`
      $ sudo make module_install 
      $ ls /lib/modules 
      # [5.10.104-rt63]
      # - but we want: 5.10.104-rt63-tegra 
      # 		hence, lets rename the foler instead:
      $ sudo mv 5.10.104-rt63/ 5.10.104-rt63-tegra
      
      # export current kernel
      $ export kernel=/usr/src/linux-headers-5.10.104-rt63-tegra-ubuntu20.04_aarch64/kernel-5.10
      ```

      

## 2.2 Peak Linux Driver  (Out-of-tree Linux RT Header)

Compile PCAN with this custom rt-kernel:

```bash
# download driver:
$ wget https://www.peak-system.com/fileadmin/media/linux/files/peak-linux-driver-8.15.2.tar.gz

# unzip:
$ tar -xzf peak-linux-driver-8.15.2.tar.gz

# build driver with netdev and specified kernel:
$ make -C driver NET=NETDEV_SUPPORT KERNEL_LOCATION=$kernel LOCALVERSION="-tegra"

# install:
$ sudo make install KERNEL_LOCATION=$kernel

# GUCCI
cd ~/libbarrett/scripts && ~/libbarrett/scripts/install_dependencies.sh
$ sudo reboot 0

# testing:
$ sudo dmesg | grep pcan
```

> :warning: `netdev` support is needed for WAM
>
> :warning: Kernel location should be the compiled kernel output with RT-kernel, the `/usr/src` does not contain rt-kernel with custom build



## 2.3 Libbarrett Hardware Library

> Use our `uwarl-libbarrett` with fixes to support arm based system

1. Install dependencies `$ ./scripts/install_dependencies.sh`

   1. This will fail at builing the `libconfig-1.4.5`, due to outdated aux-build kernel guesses (the outdated one is 2006, last modified is 2022)

   2. So let's update:

      ```bash
      $ cd ~/Downloads/libconfig-1.4.5
      $ wget -o http://git.savannah.gnu.org/gitweb/\?p\=config.git\;a\=blob_plain\;f\=config.sub\;hb\=HEAD
      
      $ wget -o http://git.savannah.gnu.org/gitweb/\?p\=config.git\;a\=blob_plain\;f\=config.guess\;hb\=HEAD
      ```

   3. Compile libconfig and install:

      ```bash
      cd libconfig-1.4.5 && ./configure && make -j$(nproc)
      sudo make install
      sudo ldconfig
      sudo reboot 0
      ```

2. Continue to build library and install:

   ```bash
   cd ~/libbarrett
   export CC=/usr/bin/clang
   export CXX=/usr/bin/clang++
   cd ~/libbarrett && cmake .
   make -j$(nproc)
   
   sudo make install
   ```

3. copy libbarrett configurations from `uwarl-robot_configs` repo for vertical config (program assume horizontal)

## 2.4 ZED Stereo-Camera



## 2.5 Intel i515 Lidar Mono-Camera



## 2.6 Install ROS



## 2.7 [:star: automated] UWARL ROS Catkin Workspace Setup



# 3. Common:

## 3.1 Remote Screen via SSH:

- XFCE XRDP: https://www.hiroom2.com/ubuntu-2004-xrdp-xfce-en/

  > :rotating_light: Xfce is lighter, GNOME is quite heavy, not recommended for remote screen via ssh.

## 3.2 SSH Keys & Github

1. generate key `ssh-keygen -t ed25519 -C "your_email@example.com"`
2. copy the public key  `cat ~/.ssh/id_ed25519.pub`
3. paste to GitHub SSH keys under personal account profile

## 3.3 Commonly used command:

1. `$ uname -r`: OS check 
2. `$ cat /prov/version_signature`: identify kernel
3. `$ arp -a` : Scan Local Network Devices and IPs
4. `$ tree -L 1`: list hierarchy of directory in depth=1,may  require: `sudo apt install tree`

## 3.4 ZSH & oh-my-zsh

- install zsh first `sudo apt install zsh`
- https://github.com/ohmyzsh/ohmyzsh

## 3.5 TMUX: virtual terminal within terminal

- https://linuxize.com/post/getting-started-with-tmux/
- Pretty/Easy-to-use Custom Mod: https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/ (except ctrl-b mod)

> :notebook: Do not use multiple `ssh` clients, as they will make the system a bit heavier. 

> 🔥 Tmux can still run in the background, even if the computer is disconnected from the internet. 

> :warning: Normal ssh sessions without tmux will terminate the program if your ssh client is disconnected

