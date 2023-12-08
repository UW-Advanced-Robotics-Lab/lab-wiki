<toc>

# Table of Contents
[*Last generated: Thu 07 Dec 2023 02:20:12 PM EST*]
- [**0. General**](#0-General)
- [**1. [Launch Instruction] Waterloo Steel Demo (Jack)**](#1-Launch-Instruction-Waterloo-Steel-Demo-Jack)
  - [1.1 Launching the Camera](#11-Launching-the-Camera)
  - [1.2 Launching WAM](#12-Launching-WAM)
  - [1.3 Launching Demo Node](#13-Launching-Demo-Node)
  - [1.4 Launching Mobile Base trajectory demo](#14-Launching-Mobile-Base-trajectory-demo)
      - [Stopping the Experiment](#Stopping-the-Experiment)
  - [1.5 Check Demo Rosbag Records:](#15-Check-Demo-Rosbag-Records)
  - [1.6 Collecting Rosbag Data:](#16-Collecting-Rosbag-Data)

---
</toc>

 # 0. General 

> ‼️ For general powering on device, please refer to [:diamond_shape_with_a_dot_inside: *Platform Instruction*](./Waterloo-Steel%3APlatform-Instruction)  

# 1. [Launch Instruction] Waterloo Steel Demo (Jack)

## 1.1 Launching the Camera

```bash
$ ssh uwarl-orin@192.168.1.10
$ roslaunch waterloo_steel_supervisor multi_intel_camera.launch
```

> 🚨 If the launch is not successful:
>
> 1. Check the hardware USB C cable connections to both cameras
> 2. [Ask Jack if you need to] Launch individual cameras separately for the system to register individual camera IDs

## 1.2 Launching WAM

```bash
# 1. connect to jetson
$ ssh uwarl-orin@192.168.1.10
# 2. start a tmux session
$ tmux 
### TIPS:
# create multiple windows with:
# [ctrl + b] then ["] : split horizontal
# [ctrl + b] then [%] : split vertical
# [ctrl + b] then [arrow-keys] : switch window selection
# [ctrl + b] then [:] and [type: set mouse on] : to enable mouse selection and scroll and window adjustment

# 3. launch wam node:
$ roslaunch wam_node wam_node.launch
### WAM Activation Instruction:
# 1. release all E-stops
# 2. [shift & activate] on control pendant (the one with E-stop inside the cabinet)
# 3. [Enter] on the keyboard to confirm default home-position
# Now, you will hear the gear activating

### TIPS:
# launch other nodes: 1.2 camera & 1.4 demo node in different tmux windows

# 4. detach to keep running in background and independent from your laptop terminal:
# [ctrl + b] then [:] and [type: dettach]
```

## 1.3 Launching Demo Node

```bash
$ roslaunch waterloo_steel_supervisor waterloo_steel_demo.launch
# command to perform demo:
$ rosservice call /waterloo_steel/start_demo "demo_id: 2"
```

## 1.4 Launching Mobile Base trajectory demo
First SSH into Base pc
```
$ ssh uwarl@192.168.1.11
```

```
$ tmux_multi
```
This will launch a tmux with 2 vertically split windows. To split the windows again, press right mouse-click + h for horizontal split or right mouse-click + v for vertical split. (For older versions: use Ctrl+b % or Ctrl+b ")

Then launch the Rosbag recorder action server and Base controller action server in two separate windows.
```
$ roslaunch rosbag_recorder rosbag_recorder_action_server.launch 
$ roslaunch base_controller Base_controller.launch
```
For an experiment using VICON data in the RobotHub, use the Base controller below:
```
$ roslaunch base_controller Base_controller_vicon.launch
```

Next, run the desired demo node to pass the trajectory to the Base controller and start the recording. 
```
$ rosrun waterloo_steel_sim_bringup Demo_V09_base_control_demo.py
```
This node will pass the specified trajectory to the Base controller action server. To change the way-points, go to the `SummitClass_V6_demo_base.py' file and change to the desired trajectory. Two simple trajectories are available. A circular motion, and a linear motion. Next to that, way-points can be defined in a .txt file and loaded.

#### Stopping the Experiment
To stop the experiment, shutdown the Base controller action server. This will stop the movement of the robot.
Make sure to stop the Rosbag recorder action server as well to stop the recording, to prevent large sizes of rosbag files.

> [!IMPORTANT] 
> ⚠️ In case of an emergency, press and hold the R1 button on the Steam Deck controller. This will overrule all velocity commands and will stop the movement of the base. Then, shutdown the Base controller action server to stop it from publishing the velocity commands for following the trajectory. 

## 1.5 Check Demo Rosbag Records:
Depending on where the Rosbag data is saved.

```bash
$ ls ~/.ros/bagfiles/waterloo_steel_demo/session_{id}/
```

## 1.6 Collecting Rosbag Data:
Data copying can be done in 2 ways. For direct acces, connect one of the USB-C ports of the robot with an external drive. Then copy directly to the drive via SSH or NoMachine.
The second option is to copy over the network. This is not as fast, but might be convenient. Make sure to be connected to the robot wifi. This method will copy the entire `bagfiles` folder. 
```
$ scp -r uwarl@192.168.1.11:~/UWARL_catkin_ws/src/waterloo_steel/waterloo_steel_viz/waterloo_steel_sim_bringup/bagfiles ~/{Folder in which you want to copy the files}
```







<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>