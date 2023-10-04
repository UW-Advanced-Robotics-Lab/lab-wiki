<toc>

# Table of Contents
[*Last generated: Wed  4 Oct 2023 15:34:20 EDT*]
- [**0. General**](#0-General)
- [**1. [Launch Instruction] Waterloo Steel Demo (Jack)**](#1-Launch-Instruction-Waterloo-Steel-Demo-Jack)
  - [1.1 Launching the Camera](#11-Launching-the-Camera)
  - [1.2 Launching WAM](#12-Launching-WAM)
  - [1.3 Launching Demo Node](#13-Launching-Demo-Node)
  - [1.4 Check Demo Rosbag Records:](#14-Check-Demo-Rosbag-Records)

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

## 1.4 Check Demo Rosbag Records:

```bash
$ ls ~/.ros/bagfiles/waterloo_steel_demo/session_{id}/
```


















<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>