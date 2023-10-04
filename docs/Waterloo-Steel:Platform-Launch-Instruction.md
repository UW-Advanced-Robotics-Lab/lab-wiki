<toc>

# Table of Contents
[*Last generated: Wed  4 Oct 2023 14:07:38 EDT*]
- [**1. Power On**](#1-Power-On)
  - [1.0 External Network with Ethernet](#10-External-Network-with-Ethernet)
    - [1.0.a [Optional] Connect Ethernet to WAN from Router LAN](#10a-Optional-Connect-Ethernet-to-WAN-from-Router-LAN)
    - [1.0.b [Optional] Connect Ethernet to LAN to Laptop Ethernet Port](#10b-Optional-Connect-Ethernet-to-LAN-to-Laptop-Ethernet-Port)
  - [1.1 Powering on the robot](#11-Powering-on-the-robot)
    - [1.1.1 Turn on the robot by twisting power knobs for Base](#111-Turn-on-the-robot-by-twisting-power-knobs-for-Base)
    - [1.1.2 Turn on the robot by twisting power knobs for WAM](#112-Turn-on-the-robot-by-twisting-power-knobs-for-WAM)
    - [1.1.3 Power on the steam deck controller, and connect to the Robot Wifi `UWARL_171102_5G`](#113-Power-on-the-steam-deck-controller-and-connect-to-the-Robot-Wifi-UWARL_171102_5G)
    - [1.1.4 Launch the Controller on Steam Deck:](#114-Launch-the-Controller-on-Steam-Deck)
- [**2. Power Off**](#2-Power-Off)
  - [2.1 Power off Robot Sequence ‼️](#21-Power-off-Robot-Sequence-)
- [**3. Waterloo Steel Demo [Jack]**](#3-Waterloo-Steel-Demo-Jack)
  - [3.1 Launching the Camera](#31-Launching-the-Camera)
  - [3.2 Launching WAM](#32-Launching-WAM)
  - [3.3 Launching Demo Node](#33-Launching-Demo-Node)
  - [3.4 Check Demo Rosbag Records:](#34-Check-Demo-Rosbag-Records)
- [**A. Troubleshoot**](#A-Troubleshoot)
  - [A.1 Deck Controller Cannot Launch:](#A1-Deck-Controller-Cannot-Launch)
  - [A.2 ROS Testing](#A2-ROS-Testing)
- [**B. Hardware Guide**](#B-Hardware-Guide)
  - [B.1 Steam Deck Controller Button Layout](#B1-Steam-Deck-Controller-Button-Layout)
    - [B.1.a) Move Summit:](#B1a-Move-Summit)
    - [B.1.b) Steam Arch Linux:](#B1b-Steam-Arch-Linux)

---
</toc>

# 1. Power On

## 1.0 External Network with Ethernet

### 1.0.a [Optional] Connect Ethernet to WAN from Router LAN

- if you want internet access (eg, update local repository), please connect to:
  - WAN port of the robot <-----> LAN port of the Router

### 1.0.b [Optional] Connect Ethernet to LAN to Laptop Ethernet Port

- if you want Remote access with **AnyDesk** to the robot network,
  - you may want your PC connecting to the Lab Wifi
  - and connect the ethernet from robot LAN to Laptop

## 1.1 Powering on the robot

### 1.1.1 Turn on the robot by twisting power knobs for Base

- we should see the green button (for jetson pc) is lighting on
- fan spinning, and everything should be powered except WAM

### 1.1.2 Turn on the robot by twisting power knobs for WAM

- Make sure the LED panel is powered on, and will show ERROR as the WAM has not been calibrated and launched by default

### 1.1.3 Power on the steam deck controller, and connect to the Robot Wifi `UWARL_171102_5G`

- We should be able to launch the controller

### 1.1.4 Launch the Controller on Steam Deck:

1. Launch the joystick controller by touching **[Launch UWARL Summit Controller]** App Icon

   - 🚨 If the controller app quits after launching,  [[A.1 Deck Controller Cannot Launch:](#A1-Deck-Controller-Cannot-Launch)]
   - **[OPTIONAL]** :notebook: You may launch the rviz by touching **[Launch Rviz]** App Icon

> 📓 Icon apps are installed by `uwarl-robot_config` toolchain, and allow us to use the basic interface without keyboard.

![deck_controller_desktop](resources/deck/deck_controller_desktop.jpg)

- :one:  > **Launch Pad** 
- :two:  > **Rviz Viewer**

# 2. Power Off

## 2.1 Power off Robot Sequence ‼️ 

> :warning: If possible, ssh into the jetson and summit PC to shutdown the PC first
>
> ```bash
> # jetson:
> $ ssh uwarl-orin@192.168.1.10
> # summit:
> $ ssh ssh uwarl@192.168.1.11
> ```

1. Long Press Green Button to power off the **Jetson PC**
2. Turn off the **WAM** power rails 
3. Turn off the **overall power rails** 
4. Turn off the screen of the steam deck by pressing power button briefly once, and put into charger.
   - we dont want a reboot of steam deck



# 3. Waterloo Steel Demo [Jack]

## 3.1 Launching the Camera

```bash
$ ssh uwarl-orin@192.168.1.10
$ roslaunch waterloo_steel_supervisor multi_intel_camera.launch
```

> 🚨 If the launch is not successful:
>
> 1. Check the hardware USB C cable connections to both cameras
> 2. [Ask Jack if you need to] Launch individual cameras separately for the system to register individual camera IDs

## 3.2 Launching WAM

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

## 3.3 Launching Demo Node

```bash
$ roslaunch waterloo_steel_supervisor waterloo_steel_demo.launch
# command to perform demo:
$ rosservice call /waterloo_steel/start_demo "demo_id: 2"
```

## 3.4 Check Demo Rosbag Records:

```bash
$ ls ~/.ros/bagfiles/waterloo_steel_demo/session_{id}/
```



# A. Troubleshoot

## A.1 Deck Controller Cannot Launch:

🚨 If the controller app quit after launching, it is likely due to the following issues:

 1.  The deck is not connected to summit wifi "*UWARL_171102A_5G*"

     > 🛠️ Connect to the wifi manually at the status bar

 2.  The summit is not hardware ready:

     > 🛠️ Please reset (engage and release) the E-Stop at the rear of the SUMMIT base

 3.  There is no ros core in the network OR any other detailed issues → The Summit Base ROS Controller and ROS Core were not launched successfully nor enabled:

     > 🛠️ Please SSH into the summit base and troubleshoot from there:
     >
     > ```bash
     > # SSH into adlink mxe211 (summit)
     > $ ssh uwarl@192.168.1.11
     > 
     > # check if summit bringup is successful
     > $ systemctl status --user roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch
     > 
     > # [DEBUG] - print out last msg (double-check time-stamp):
     > $ journalctl --follow --user --user-unit=roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch.service > log.txt
     > # [DEBUG] - Live Stream:
     > $ journalctl --follow --user --user-unit=roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch.service
     > 
     > # stop/restart
     > $ systemctl stop --user roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch
     > $ systemctl restart --user roscorelaunch@waterloo_steel_summit_bringup:waterloo_steel_summit.launch
     > 
     > # You may want to check if the workspace is at the right target, and built successfully:
     > $ check_ws_status
     > $ build_ws
     > $ src_all
     > ```



## A.2 ROS Testing

```bash
$ rosnode ping -c 4 rosout
rosnode: node is [/rosout]
pinging /rosout with a timeout of 3.0s
xmlrpc reply from http://ann:46635/     time=1.195908ms
xmlrpc reply from http://ann:46635/     time=1.123905ms
xmlrpc reply from http://ann:46635/     time=1.144886ms
xmlrpc reply from http://ann:46635/     time=1.137018ms
ping average: 1.150429ms
```

- http://wiki.ros.org/rosnode

# B. Hardware Guide

## B.1 Steam Deck Controller Button Layout

![steam_deck_ports_controls](resources/deck/steam_deck_ports_controls.jpg)

### B.1.a) Move Summit:

- Launch the joystick controller by touching **[Launch UWARL Summit Controller]** App Icon

- Button Layouts:
  - Hold :three: **[R1]**  + Move Up/Down :one: **[L3]** : Forward/Reverse
  - Hold :three: **[R1]**  + Move Left/Right :two: **[R3]** : CCW/CW
  - Hold :three: **[R1]**  + Press **(11)** **[Options]** : Omni / Skid Mode

### B.1.b) Steam Arch Linux:

- :four: **[R4]** : Scroll Up
- :five: **[R5]** : Scroll Down
- :six: **[L5]** : Left Mouse Click for Mouse Menus
- :seven: **[L4]** : Enter 
- :eight: **[Left Trackpad]**  Button Click : Arrow Key Up/Down/Left/Right
- 9️⃣ **[Right Trackpad]** : Mouse Move +  Mouse Right Click
- :keycap_ten: **[Steam]** : Menu Selection ---> Used to switch between Steam OS / ArchLinux Mode + Power/Restart












<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>