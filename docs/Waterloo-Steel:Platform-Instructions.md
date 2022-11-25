<toc>

# Table of Contents
[*Last generated: Fri 25 Nov 2022 14:32:24 EST*]
- [**1. Waterloo Steel Robot Launch Instructions :construction:**](#1-Waterloo-Steel-Robot-Launch-Instructions-construction)
  - [1.1 Adlink MXE 211 (SUMMIT + Lidar PC)](#11-Adlink-MXE-211-SUMMIT-Lidar-PC)
    - [1.1.1 PS Controller:](#111-PS-Controller)
    - [1.1.2 Summit XL Bringup:](#112-Summit-XL-Bringup)
  - [1.2 Jetson Orin (WAM + Vision PC)](#12-Jetson-Orin-WAM-Vision-PC)
- [**2. Unified Development :construction:**](#2-Unified-Development-construction)
- [**3. ROS UWARL_catkin_ws Usage Guide:**](#3-ROS-UWARL_catkin_ws-Usage-Guide)
  - [3.1 Modifications:](#31-Modifications)
  - [3.2 Commit and Push:](#32-Commit-and-Push)
- [**Appendix A - File Arch**](#Appendix-A-File-Arch)
  - [A.1 xacro and launching](#A1-xacro-and-launching)


</toc>



<img src="resources/Waterloo_steel_arch_v2_final.jpg" alt="Hardware Architecture Diagram V2 Final"></img>

# 1. Waterloo Steel Robot Launch Instructions :construction:

1. MXE 211 should auto-launch the summit-xl 
   1. If you need to check status, refer to [1.1 Adlink MXE 211 (SUMMIT + Lidar PC)](#11-Adlink-MXE-211-SUMMIT-Lidar-PC) below.
   
1. Interfacing on-board computers:
   
   1. SSH:
   
      ```bash
      # Jetson:
      ssh uwarl-orin@192.168.1.10
      # Adlink:
      ssh uwarl@192.168.1.11
      # Internal-WAM PC:
      ssh robot@192.168.1.40
      ```
   
      
   

## 1.1 Adlink MXE 211 (SUMMIT + Lidar PC)

### 1.1.1 PS Controller:

```bash
# check driver status
$ systemctl status ds4drv.service
```

### 1.1.2 Summit XL Bringup:

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



## 1.2 Jetson Orin (WAM + Vision PC)

[TODO]



# 2. Unified Development :construction:

> 🔥 (hot-takes) on **[Hardware v2]** : A unified multi-platform configuration
>
> - `UWARL_catkin_ws/src`:  A single common catkin workspace that can be deployed dynamically across multiple platforms. This repository will track other ROS components as submodules on particular commit hask token (without tracking physical files and changes).
> - `uwarl-robot_configs`: An all-star installation toolkit that will configure any hardware automatically with simple bash scripts.
> - Supported OS: **Ubuntu 18.04** and **Ubuntu 20.04**

1. Install Git and configure the environment necessary from previous section, and SSH authenticated with Github, see instruction @ [0.2 SSH Keys & Github](#02-SSH-Keys-Github)

2. Clone configurations: 

    ```zsh
    $ cd ~ && git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robot_configs.git
    ```

3. Install the repo with auto-script:

    ```zsh
    $ cd ~ && ./uwarl-robot_configs/scripts/auto-config_UWARL_catkin_ws.zsh
    ```

    > :notebook: this script will install automatically based on the **user name** (e.g. uwarl-orin) to identify the PC space
    >
    > :hot_pepper: It will install ROS Noetic for Ubuntu 20.04 automatically if your system does not have yet!

4. Build: 

    ```bash
    # build ws from anywhere
    $ build_ws
    # source ws from anywhere
    $ src_ws
    # cd into workspace from anywhere
    $ cd_ws
    ```

5. (*) For hardware platform setup, please refer to [ [Waterloo-Steel:Platform-Setup.md](./Waterloo-Steel:Platform-Setup.md) ]

# 3. ROS UWARL_catkin_ws Usage Guide:

## 3.1 Modifications:
1. switch workspace : `git checkout {branch-name}`
2. add modules: `$ git submodule add {git-repo}`
3. remove submodules: `$ git submodule deinit {git-repo}` and you may need delete the submodules in `.gitmodules` file
4. Create a new branch of workspace: `git checkout -b waterloo_steel/adlink-mxe211-melodic/{node}/{feature}`

## 3.2 Commit and Push:
1. Commit all changes under submodules
2. Make sure you run this: `$ ./git-status-all.sh` to log all status into `git-status-all.log`
3. commit all current workspace changes: `$ git add . && git commit -a`
4. Push workspace `$ git push` or upload a branch `$ git push -u {your-branch-name}`



---

# Appendix A - File Arch

## A.1 xacro and launching

````bash
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




