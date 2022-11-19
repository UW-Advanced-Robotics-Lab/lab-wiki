<toc>
# Table of Contents
[*Last generated: Fri 18 Nov 2022 19:45:09 EST*]
- [**Waterloo Steel V2 Platform Instructions**](#Waterloo-Steel-V2-Platform-Instructions)
- [**1. Waterloo Steel Robot Launch Instructions :construction:**](#1-Waterloo-Steel-Robot-Launch-Instructions-construction)
- [**2. Local Development :construction:**](#2-Local-Development-construction)
- [**workspace:**](#workspace)
- [**clone --> to the src/**](#clone-to-the-src)
- [**recursive submodules:**](#recursive-submodules)
- [**or manually init specific submodules you want to compile with**](#or-manually-init-specific-submodules-you-want-to-compile-with)
  - [Ubuntu 18 - ROS Melodic](#Ubuntu-18-ROS-Melodic)
  - [Ubuntu 20 - ROS Noetic](#Ubuntu-20-ROS-Noetic)
- [**3. Robot Maintenance**](#3-Robot-Maintenance)
  - [Manual Migration Backup :construction:](#Manual-Migration-Backup-construction)
- [**4. Debug Tips**](#4-Debug-Tips)
  - [PeakCAN:](#PeakCAN)
  - [PS Controller:](#PS-Controller)
- [**5. Helpful Scripts**](#5-Helpful-Scripts)
  - [Git:](#Git)
- [**6. File Arch**](#6-File-Arch)
  - [6.1 xacro and launching](#61-xacro-and-launching)


</toc>
# Waterloo Steel V2 Platform Instructions


---
<img src="resources/Waterloo_steel_arch_v2_final.jpg" alt="Hardware Architecture Diagram V2 Final"></img>

# 1. Waterloo Steel Robot Launch Instructions :construction:

1. Power on the robot, wait for computers to auto-boot

2. Check if default launch successful:

   ```bash
   # SSH into adlink mxe211 (summit)
   $ ssh uwarl@192.168.1.11
   
   # check if summit bringup is successful
   $ systemctl status --user roscorelaunch@summit_xl_bringup:summit_xl_complete.launch
   
   # stop/restart
   $ systemctl stop/restart --user roscorelaunch@summit_xl_bringup:summit_xl_complete.launch
   
   # [DEBUG]
   $ journalctl --user --user-unit=roscorelaunch@summit_xl_bringup:summit_xl_complete.launch.service > log.txt
   # [DEBUG] - Live Stream:
   $ journalctl --follow --user --user-unit=roscorelaunch@summit_xl_bringup:summit_xl_complete.launch.service
   ```



# 2. Local Development :construction:

```bash
# SUMMIT-catkin_ws
[Hardware v2] catkin workspace for Robotnik Summit XLS in Adlink MXE-211
This will serve as the foundation for managing `UWARL_catkin_ws/src`

# Installation Guide:
1. Clone the repo as workspace source
    ```bash
    # workspace:
    $ cd ~ && mkdir -p ~/UWARL_catkin_ws/src
    # clone --> to the src/
    $ git clone git@github.com:UW-Advanced-Robotics-Lab/SUMMIT-catkin_ws.git ~/UWARL_catkin_ws/src
		# recursive submodules:
    $ cd ~/UWARL_catkin_ws/src && git submodule update --init --recursive
    # or manually init specific submodules you want to compile with
```
2. Build: `$ cd ~/UWARL_catkin_ws && catkin build`
3. Robot ROS Configuration Files & Scripts & instructions on semi-automated installation:
    --> https://github.com/UW-Advanced-Robotics-Lab/uwarl-robot_configs

> :warning: For additional Guides, Please follow [UWARL Wiki Guide](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/How-To%3AWaterloo-Steel-V2-Final-Upgrade-Guide)

# Usage Guide:
## Modifications:
1. switch workspace : `git checkout {branch-name}`
2. add modules: `$ git submodule add {git-repo}`
3. remove submodules: `$ git submodule deinit {git-repo}` and you may need delete the submodules in `.gitmodules` file
4. Create a new branch of workspace: `git checkout -b waterloo_steel/adlink-mxe211-melodic/{node}/{feature}`

## Commit and Push:
1. Commit all changes under submodules
2. Make sure you run this: `$ ./git-status-all.sh` to log all status into `git-status-all.log`
3. commit all current workspace changes: `$ git add . && git commit -a`
4. Push workspace `$ git push` or upload a branch `$ git push -u {your-branch-name}`

```



## Ubuntu 18 - ROS Melodic



## Ubuntu 20 - ROS Noetic

- `sudo ln -s /usr/bin/empy3 /usr/bin/empy` is required to get robotnik hw compiled on **x86**

  - **arm** arch please do not update the submodule for the base_hw

- Catkin build with python3: ` catkin build -DPYTHON_EXECUTABLE=/usr/bin/python3`

  - else you may get compile error for failing to find python `empy`

  



# 3. Robot Maintenance

## Manual Migration Backup :construction:

1. Backing Up Remote Robot's core files with https://github.com/UW-Advanced-Robotics-Lab/uwarl-robot-backup
   - Pre-requisite: previous ssh remote access of the computer
   - Ex: (⚠️ Large) backing up summit-pc configuration: `bash backup.sh uwarl_summit summit@192.168.0.147 {passcode}`
   - Lightweight backup just the config necessary (`backup_without_home`)

2. Unpacking only: `bash unpacking.sh uwarl_summit`



# 4. Debug Tips

## PeakCAN:

- [Link to Linux Manual PDF](https://www.peak-system.com/fileadmin/media/linux/files/PCAN-Driver-Linux_UserMan_eng.pdf)

```bash
# check if loaded
$ sudo modprobe pcan
$ dmesg | grep pcan
	
# Check CAN interfaces configurations:
$	cat /etc/modprobe.d/pcan.conf
```

## PS Controller:

```bash
# check driver status
$ systemctl status ds4drv.service
```



# 5. Helpful Scripts

## Git:

```bash
# list all repo under catkin_ws/src and their git status
$ find . -maxdepth 1 -type d -execdir sh -c 'cd {}; pwd ;git status; git remote -v; echo "----------\n\"' \;
# [uwarl-robot_configs] now in zshrc aliasing:
$ git-status-all
```



# 6. File Arch

## 6.1 xacro and launching

````
# waterloo_steel
Private repo that contains the mobile manipulator configuration for both hw and sim. 

```
[2022 Nov 05]
..xl_robot/../waterloo_steel_summit.launch              >>> Physical robot launching
| ---> summit_xl_state_robot.launch                     >>> ROS Parameter Server
    |----> xacro robot model

summit_xl_rviz.launch           >>> rviz
rviz.launch                     >>> rviz
wam_launch.launch               >>> wam launch file???

waterloo_steel/..viz/..sim_bringup/waterloo_steeel_complete.launch          >>> complete
|---> waterloo_steel_gazebo.launch
    |---> waterloo_steel/..viz/..gazebo/waterloo_steeel_one_robot.launch    >>> one robot

[xacro robot model: .env variable]
    |----> summit_xls_171102A.urdf.xacro
        |----> all_sensors.urdf.xacro
        |----> {waterloo_steel_description}/../omni_wheel.urdf.xacro
        |----> {waterloo_steel_description}/../summit_xls_base_waterloo.urdf.xacro
            |----> {waterloo_steel_description}/summit_xl_base.gazebo.urdf.xacro
                |---> *.so ros controller/driver
            |----> *.stl
	
waterloo_steel/..viz/..sim_bringup/waterloo_steeel_complete_combined.launch	>>> wagon + robot
    |----> waterloo_steel/..viz/..sim_bringup/waterloo_steeel_complete.launch	

```
````





