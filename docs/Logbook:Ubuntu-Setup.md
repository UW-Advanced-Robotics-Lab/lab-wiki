<toc>

# Table of Contents
[*Last generated: Fri  6 Jan 2023 22:35:56 EST*]
- [**Ubuntu Setup**](#Ubuntu-Setup)
  - [General Linux Ubuntu Setup](#General-Linux-Ubuntu-Setup)
  - [ROS Kinetic Setup (for Ubuntu 16.04)](#ROS-Kinetic-Setup-for-Ubuntu-1604)
  - [Summit Simulation](#Summit-Simulation)
    - [Barrett WAM Arm (ArUco Demo)](#Barrett-WAM-Arm-ArUco-Demo)
- [**Other Common Packages:**](#Other-Common-Packages)
  - [PeakCAN (RT + NO/NETDEV_SUPPORT):](#PeakCAN-RT-NONETDEV_SUPPORT)
- [**Tips**](#Tips)
  - [Commonly used command:](#Commonly-used-command)
  - [Remote Desktop Setup - XRDP (WLAN):](#Remote-Desktop-Setup-XRDP-WLAN)
    - [(Extra):](#Extra)
  - [Manually backup a directory of files:](#Manually-backup-a-directory-of-files)
  - [SSH](#SSH)
    - [SSH Keys & Github](#SSH-Keys-Github)
  - [UDEV](#UDEV)

---
</toc>

# Ubuntu Setup
## General Linux Ubuntu Setup 
> ⚠️ Noetic works, melodic works, up to you.
1. install ROS noetic: http://wiki.ros.org/noetic/Installation/Ubuntu
> a. In case this method does not work for Noetic, use https://varhowto.com/install-ros-noetic-ubuntu-20-04/
2. create a catkin work space: http://wiki.ros.org/catkin/Tutorials/create_a_workspace

## ROS Kinetic Setup (for Ubuntu 16.04)
1. Follow the steps listed in https://varhowto.com/install-ros-noetic-ubuntu-20-04/ and replace 'noetic' with 'kinetic'. Afterwards, you can stick to the setup mentioned at bullet 1.5 and below (http://wiki.ros.org/kinetic/Installation/Ubuntu)
a. When you are updating 'rosdep update', since you are installing an EOL version, remember to append the command '--include-eol-distros'; that way, you will have access to the EOL distro of 'Kinetic'
2. In case the above method does not work, follow steps in: https://copyfuture.com/blogs-details/202201090138336289
3. There may be instances where not all the packages necessary have been installed. In that case, install them individually 'sudo apt install ros-kinetic-<name of package>' (source: https://answers.ros.org/question/281917/cannot-launch-node-of-type/)
4. A good source to know why somethings you are doing in the installation process (in case you're new to Linux) (https://www.youtube.com/watch?v=FUy_mu5Fa8A)
5. In case you observe the errors 'unable to find uri[model://sun]' or 'unable to find uri[model://ground]', this is most likely due to your Gazebo version being 7.0.0. Upgrade it to 7.16 by first uninstalling Gazebo from ROS (sudo apt-get remove ros-kinetic-gazebo*) and the base version (sudo apt-get remove gazebo7*). After this, follow the 'alternate steps' in https://classic.gazebosim.org/tutorials?tut=install_ubuntu&cat=install. Make sure to replace 'gazebo11' with 'gazebo7' in the last sub-step of step 3. Then install 'Gazebo Messages' package: 'sudo apt-get install ros-kinetic-gazebo-msgs' | 'Gazebo ROS' package: 'sudo apt-get install ros-kinetic-gazebo-ros' | 'Gazebo ROS Control' package: 'sudo apt-get install ros-kinetic-gazebo-ros-control'
6. In case you observe the error ' ...fatal error: ignition/math/Inertial.hh' while building a simulation package, refer to https://github.com/grvcTeam/grvc-ual/issues/53

## Summit Simulation
When starting off of a fresh install, ensure that you are able to compile the package 'summit_xl_sim_bringup'. Initially, you may require to install certain packages native to the robot itself:
1. First is the 'Robotnik Msg' package: 'sudo apt-get install ros-kinetic-robotnik-msgs'
2. Then, for the 'Robotnik Sensors' package, we have: 'sudo apt-get install ros-kinetic-robotnik-sensors'

Then, we proceed to ensure that the simulation itself is working correctly. Run the following launch file: 'roslaunch summit_xl_sim_bringup summit_xls_complete_e7.launch'. Although the packages Rviz and Gazebo have been installed correctly, you will see that there are many packages missing, as outlined in the terminal. Let's go over them one by one:
1. 'controller-manager' package: Install using the command: (General command: 'sudo apt-get install ros-kinetic-PACKAGE') 'sudo apt-get install ros-kinetic-controller-manager'
2. 'Twist-mux' package: 'sudo apt-get install ros-kinetic-twist-mux'
3. 'Map Server' package: 'sudo apt-get install ros-kinetic-map-server'(Earlier, Rviz would have been showing a blank window, but after installing this package, you should see a may of the 3rd floor of E7)
4. 'AMCL' package: 'sudo apt-get install ros-kinetic-amcl' (In addition to the map from above, you should now be seeing a point-cloud surrounding the robot)
5. 'Teleop Twist Keyboard' package (for operating with the keyboard): 'sudo apt-get install ros-kinetic-teleop-twist-keyboard'
6. 'Move-base' package: 'sudo apt-get install ros-kinetic-move-base'
7. 'Global Planner' package: 'sudo apt-get install ros-kinetic-global-planner'
8. 'Teb Local Planner' package: 'sudo apt-get install ros-kinetic-teb-local-planner'
9. 'Robot Localization' package: 'sudo apt-get install ros-kinetic-robot-localization'
10. 'Costmap Prohibition Layer' package: 'sudo apt-get install ros-kinetic-costmap-prohibition-layer'
11. 'Mavros Messages' package: 'sudo apt-get install ros-kinetic-mavros-msgs'
12. 'GMapping' package: 'sudo apt-get install ros-kinetic-gmapping'
13. 'Joint State Controller' package: 'sudo apt-get install ros-kinetic-joint-state-controller'
14. 'Velocity Controller' package: 'sudo apt-get install ros-kinetic-velocity-controllers'

> ⚠️ DO NOT INSTALL ANYTHING UNNECESSARY. Since Kinetic is already depreciated, there are instances where installing unnecessary packages, while having installed correctly, will in fact break ROS.


### Barrett WAM Arm (ArUco Demo)
1. clone WAM arm scripts: https://github.com/UW-Advanced-Robotics-Lab/barrett-wam-arm
2. install gripper controllers and missing packages needed:
```
$ sudo apt-get install ros-noetic-gripper-action-controller

$ sudo apt-get install ros-noetic-joint-trajectory-controller

$ sudo apt install protobuf-c-compiler 

```



# Other Common Packages:

## PeakCAN (RT + NO/NETDEV_SUPPORT): 

> [Linux User Manual](https://www.peak-system.com/fileadmin/media/linux/files/PCAN-Driver-Linux_UserMan_eng.pdf)

1. Download driver: `$ wget https://www.peak-system.com/fileadmin/media/linux/files/peak-linux-driver-8.15.2.tar.gz`

2. Untar: `$ tar -xzf peak-linux-driver-8.15.2.tar.gz` 

3. Build non-RT binaries: `$ cd peak-linux-driver-8.15.2  && make clean && make`

   > ⚠️ for RT, please specify kernel patching methods (RTAI/Xenomai/RTAI) [Refer Instruction](https://www.peak-system.com/fileadmin/media/linux/files/PCAN-Driver-Linux_UserMan_eng.pdf)

4. Install: `$ sudo make install`

5. Configure PC CAN interfaces `$ cat /etc/modprobe.d/pcan.conf`:

   ```
   #### Below is the configuration found from summit-PC: ###
   # pcan - automatic made entry, begin --------
   # if required add options and remove comment 
   # options pcan type=isa,sp
   install pcan modprobe --ignore-install pcan
   # pcan - automatic made entry, end ----------
   ```

6. driver loading; `$ sudo modprobe pcan`

7. check if loaded: `$ sudo dmesg | grep pcan`

   - > 🟠 If dmseg failed: operation note permitted

     - unlock restriction from non-root `$ sudo sysctl kernel.dmesg_restrict=0`



# Tips

## Commonly used command:
1. `$ uname -r`: OS check 
2. `$ cat /prov/version_signature`: identify kernel
3. `$ arp -a` : Scan Local Network Devices and IPs
4. `$ tree -L 1`: list hierarchy of directory in depth=1

## Remote Desktop Setup - XRDP (WLAN):

- XRDP: `$ sudo apt install xrdp`

### (Extra):

- 🔥 xrdp with gnome: https://www.hiroom2.com/2018/04/29/ubuntu-1804-xrdp-gnome-en/ 

  - > :rotating_light: But it's heavy and slow, hence, not preferred

- Xfce4 (default): `$ sudo apt install xfce4`

- switch xfce4:
  - `sudo update-alternatives --config x-session-manager `
  - xfce4 is much smoother than gnome


## Manually backup a directory of files:
1. EX: backup home directory `sudo rsync -a --info=progress2 --exclude="lost+found" --exclude=".cache" /home/ /mnt/usbdrive/` [[cite:1]](https://www.pragmaticlinux.com/2021/05/how-to-backup-your-home-directory-in-linux/)

## SSH

### SSH Keys & Github

1. generate key `ssh-keygen -t ed25519 -C "your_email@example.com"`
2. copy the public key  `cat ~/.ssh/id_ed25519.pub`
3. paste to github SSH keys under personal account profile



## UDEV

- http://www.clearpathrobotics.com/assets/guides/kinetic/ros/Udev%20Rules.html




<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>