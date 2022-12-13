<toc>

# Table of Contents
[*Last generated: Tue 13 Dec 2022 18:02:01 EST*]
- [**1. Waterloo Steel Robot Launch Instructions :construction:**](#1-Waterloo-Steel-Robot-Launch-Instructions-construction)
  - [1.1 Adlink MXE 211 (SUMMIT + Lidar PC)](#11-Adlink-MXE-211-SUMMIT-Lidar-PC)
    - [1.1.0 Reset Workspace:](#110-Reset-Workspace)
    - [1.1.1 PS Controller:](#111-PS-Controller)
    - [1.1.2 Summit XL Bringup:](#112-Summit-XL-Bringup)
  - [1.2 Jetson Orin (WAM + Vision PC)](#12-Jetson-Orin-WAM-Vision-PC)
    - [1.2.1 WAM:](#121-WAM)
    - [1.2.2 ZED:](#122-ZED)
- [**2. Unified Development :construction:**](#2-Unified-Development-construction)
  - [2.1 How to commit:](#21-How-to-commit)
  - [2.2 How to Add a new modules under workspace/src:](#22-How-to-Add-a-new-modules-under-workspacesrc)
- [**3. ROS UWARL_catkin_ws Usage Guide:**](#3-ROS-UWARL_catkin_ws-Usage-Guide)
  - [3.1 Modifications:](#31-Modifications)
  - [3.2 Commit and Push:](#32-Commit-and-Push)
- [**Appendix A - File Arch**](#Appendix-A-File-Arch)
  - [A.1 xacro and launching](#A1-xacro-and-launching)
  - [A.2 ROS](#A2-ROS)
    - [A.2.1 ROS Profiling](#A21-ROS-Profiling)
      - [a) GDB:](#a-GDB)
      - [b) Valgrind:](#b-Valgrind)
  - [A.3 Common Issues:](#A3-Common-Issues)
    - [A.3.1 Error of catkin build: Unable to find source space ....](#A31-Error-of-catkin-build-Unable-to-find-source-space-)


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


3. All shortcuts came with auto-configuration:

   ```bash
   # update (pull recursively in a batch) of the entire workspace with all required submodules (as noted in common.sh) from anywhere
   $ update_ws
   # build ws from anywhere
   $ build_ws
   # source ws from anywhere
   $ src_ws
   # source ~/.zshrc from anywhere
   $ src_zsh
   # cd into workspace from anywhere
   $ cd_ws
   # check wworkspace status from anywhere
   $ check_ws_status
   # cd into robot_configs from anywhere
   $ cd_config
   ```

   

## 1.1 Adlink MXE 211 (SUMMIT + Lidar PC)

### 1.1.0 Reset Workspace:

```bash
$ rm -rf ~/UWARL_catkin_ws
$ cd_config
$ ./scripts/auto-config_UWARL_catkin_ws.zsh
```



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
   $ systemctl status --user roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch
   
   # stop/restart
   $ systemctl stop/restart --user roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch
   
   # [DEBUG]
   $ journalctl --user --user-unit=roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch > log.txt
   # [DEBUG] - Live Stream:
   $ journalctl --follow --user --user-unit=roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch
   ```



## 1.2 Jetson Orin (WAM + Vision PC)

### 1.2.1 WAM:

```bash
# launch wam node:
$ roslaunch wam_node wam_node.launch

# example commands:
$ rosservice call /wam/go_home                                                                         $ rosservice call /wam/joint_move "joints:                                                            
- 0.0
- 0.0
- 0.0
- 0.0
- 0.0
- 0.0
- 0.0"
```



### 1.2.2 ZED:

```bash
$ roslaunch zed_wrapper zed.launch
```



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
    # update (pull recursively in a batch) of the entire workspace with all required submodules (as noted in common.sh) from anywhere
    $ update_ws
    # build ws from anywhere
    $ build_ws
    # source ws from anywhere
    $ src_ws
    ```

5. (*) For hardware platform setup, please refer to [ [Waterloo-Steel:Platform-Setup.md](./Waterloo-Steel:Platform-Setup.md) ]

## 2.1 How to commit:

1. check every status of subdirectories of the Catkin Workspace:

   ```bash
   $ check_ws_status 
   ```

2. commit changes for every sub-directory (submodule)

   ```bash
   $ cd uwarl-barrrett-ros-pkg 
   $ git status 
   $ git commit -a 
   $ git push
   ```

3. Once you are satisfied with the current version of the workspace, you may commit this specific combination of submodules

   ```bash
   $ check_ws_status # let's update local log file that automatically track workspace status upon checking the status, so we will know if the commit for workspace has any local commits that have not yet been tracked.
   $ cd_ws
   $ git status
   $ git commit -a 
   $ git push
   ```

## 2.2 How to Add a new modules under workspace/src:

1. Add module into workspace
   ```bash
   $ cd_ws
   $ git submodule add git@github.com:UW-Advanced-Robotics-Lab/uwarl-zed_ros_wrapper.git
   $ git commit ### commit: [New Submodule] : zed ros wrapper
   $ git push
   ```

2. Add module name into `uwarl-robot_configs/scripts/common.sh`

   ```bash
   $ cd_config
   $ vim scripts/common.sh
   ## Ex: add zed ros wrapper to wam module
   SUBMODULES_FOR_WAM=(
       "uwarl-barrett-ros-pkg" 
       "uwarl-zed_ros_wrapper" # <----- just added/uncomment
   )
   ```

   1. Remove/Commenting-out the module:

      ```bash
      $ cd_ws
      $ rm -rf uwarl-zed_ros_wrapper/* # delete local cache
      $ cd_config
      $ vim scripts/common.sh
      ## Ex: comment out zed ros wrapper to wam module
      SUBMODULES_FOR_WAM=(
          "uwarl-barrett-ros-pkg" 
          #"uwarl-zed_ros_wrapper" # <----- just added
      )
      ```

      

3. Update workspace and install ros dependencies:

   ```bash
   $ update_ws
   ```

4. Build:

   ```bash
   $ build_ws
   ```

   

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

[TODO: below is not up-to-date]

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





## A.2 ROS 

### A.2.1 ROS Profiling

- Reads:
  - [Read More about [Debugging and profiling ROS nodes]](https://subscription.packtpub.com/book/iot-&-hardware/9781783987443/4/ch04lvl1sec25/debugging-and-profiling-ros-nodes)
  - Valgrind:https://valgrind.org
  - https://answers.ros.org/question/28383/time-consumption-profiling/
  - ROS valgrind: https://wiki.ros.org/roslaunch/Tutorials/Roslaunch%20Nodes%20in%20Valgrind%20or%20GDB
    - Kcachegrind: https://wiki.ros.org/roslaunch/Tutorials/Profiling%20roslaunch%20nodes

#### a) GDB:

```bash
<launch>
  <node name="wam_node" type="wam_node" pkg="wam_node" output="screen" 
    launch-prefix="gdb -ex run --args"
  />
</launch>
```

#### b) Valgrind:

- Install:

  - ```bash
    $ sudo apt -y install valgrind
    $ sudo apt-get install kcachegrind # visualizer:
    
    #### roslaunch file add prefix:
    <launch>
      <node name="wam_node" type="wam_node" pkg="wam_node" output="screen" 
        launch-prefix="valgrind --tool=callgrind  
          --log-file=/home/uwarl-orin/JX_Logs/valgrind.log 
          --callgrind-out-file='/home/uwarl-orin/JX_Logs/callgrind.wam_node.%p'"
      />
    </launch>
    ```

- Instructions:

  - ```bash
    $ catkin build -DCMAKE_BUILD_TYPE=Debug
    
    # enable core dumps:
    $ ulimit -a	# check limits
    $ ulimit -c unlimited  # unlimited
    
    # allow core dumps to be created:
    $ sudo echo 1 > /proc/sys/kernel/core_uses_pid
    ```

    



## A.3 Common Issues:

### A.3.1 Error of catkin build: Unable to find source space ....

```bash
rm -rf ~/.catkin_tools
```

- [Ref](https://github.com/catkin/catkin_tools/issues/425)



