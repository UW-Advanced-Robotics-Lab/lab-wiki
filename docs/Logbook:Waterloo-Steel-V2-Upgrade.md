<toc>

# Table of Contents
[*Last generated: Fri  6 Jan 2023 22:35:56 EST*]
- [**Spec Comparison**](#Spec-Comparison)
- [**ADLINK - MXE211**](#ADLINK-MXE211)
    - [Catkin_ws/src](#Catkin_wssrc)
  - [Barrett WAM](#Barrett-WAM)
  - [Robotnik Summit XL](#Robotnik-Summit-XL)
    - [PeakCANpcan](#PeakCANpcan)
    - [misc commands:](#misc-commands)
    - [PAD Configuration PS Controller (Sony)](#PAD-Configuration-PS-Controller-Sony)
    - [Pixhawk PX4 Flight Controller (IMU)](#Pixhawk-PX4-Flight-Controller-IMU)
    - [[:star: A better version] UWARL ROS Catkin Workspace Setup](#star-A-better-version-UWARL-ROS-Catkin-Workspace-Setup)
    - [[:no_entry_sign: Manual] catkin_ws](#no_entry_sign-Manual-catkin_ws)
    - [[⭐ A better version - Jack] RC Config for ROS and devices](#-A-better-version-Jack-RC-Config-for-ROS-and-devices)
    - [[🛑 robotnik] RC Config for ROS and devices](#-robotnik-RC-Config-for-ROS-and-devices)
      - [Boot/Startup Scripts:](#BootStartup-Scripts)
      - [RC:](#RC)
  - [Local Summit-PC Catkin-ws:](#Local-Summit-PC-Catkin-ws)
    - [UWARL Repo Versions Backed:](#UWARL-Repo-Versions-Backed)
    - [Robotnik:](#Robotnik)
    - [Other Vendors:](#Other-Vendors)
    - [Unused:](#Unused)
    - [Unknown:](#Unknown)
- [**Jetson AGX ORIN**](#Jetson-AGX-ORIN)
  - [RT Kernel](#RT-Kernel)
    - [Reference](#Reference)
    - [Instruction on compiling on ORIN:](#Instruction-on-compiling-on-ORIN)
    - [compiling on external PC](#compiling-on-external-PC)
  - [install libbarrett](#install-libbarrett)
    - [~~2.4.1-(3) v2 : How to Build Libbarrett v2.0.0 on ubuntu 20 ?~~ [Not working]](#241-3-v2-How-to-Build-Libbarrett-v200-on-ubuntu-20-Not-working)
- [**Axis Camera (AXIS M5013 Network Camera)**](#Axis-Camera-AXIS-M5013-Network-Camera)
- [**Velodyn (VLP 16)**](#Velodyn-VLP-16)
- [**TP Link Router (Archer C7 v2)**](#TP-Link-Router-Archer-C7-v2)

---
</toc>

> :warning: As mentioned in the issue, we will be unifying the platform and upgrade to Ubuntu 18.04 + Melodic for hosting RT for WAM and SUMMIT synchronization. Jetson ORIN will be processing visions mostly

<img src="resources/Waterloo_steel_arch_v2_final.jpg" alt="Hardware Architecture Diagram V2 Final"></img>

# Spec Comparison

```
$ cat /proc/cpuinfo  | grep 'name'| uniq
$ grep MemTotal /proc/meminfo
```



|      | WAM PC                                    | Summit PC                                          | ADLink                                             | Orin                                      |
| ---- | ----------------------------------------- | -------------------------------------------------- | -------------------------------------------------- | ----------------------------------------- |
| CPU  | Geode(TM) Integrated Processor by AMD PCS | Intel(R) Core(TM) i7-4790S CPU @ 3.20GHz           | Intel(R) Atom(TM) Processor E3950 @ 1.60GHz        | Arm® Cortex®-A78AE v8.2 64-bit CPU 2.2GHz |
| Mem  | 993676 kB (1 GB)                          | 8079796 kB (8 GB)                                  | 7985864 kB (8 GB)                                  | 32GB                                      |
|      | 2.6.38.2-ipipe                            | Linux version 4.4.0-64-generic (buildd@lgw01-56)ls | Linux version 5.4.192-rt74 (uwarl@uwarl-MXE210-18) | Jetpack 5.0                               |
|      | 1 core                                    | 8 Processor \| 4 cores                             | 4 processor \| 4 cores                             | 12 cores                                  |
|      |                                           | 60W ?                                              | 25W-35.2W full load (recommend 40w supply)         | 15~60W                                    |
| V    |                                           |                                                    | 6-36V                                              | *9-20v*                                   |



# ADLINK - MXE211

Version: ROS Melodic + Ubuntu 18.04 rt



### Catkin_ws/src

1. [PeakCAN](####PeakCAN)
2. `git clone https://github.com/RobotnikAutomation/rcomponent`
3. `git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robotnik_msgs.git`
4. `git clone https://github.com/RobotnikAutomation/robotnik_pad.git`
5. Install [PAD Configuration PS Controller (Sony)](####PAD Configuration PS Controller (Sony))
6. Install [Pixhawk - PX4 Flight Controller (Chassis IMU)](####Pixhawk - PX4 Flight Controller (Chassis IMU))
7. Config [Boot/Startup Scripts](####Boot/Startup Scripts)
8. Setup [RC Config for ROS and devices](####RC Config for ROS and devices)
9. [Continue to setup ROS and catkin_ws](####catkin_ws)

## Barrett WAM 

- Please refer to [WAM PC Setup] Guide for External PC Setup

## Robotnik Summit XL

### PeakCANpcan

1. Install PeakCAN if have not

   1. no netdev 

      1. > :warning: with netdev, it wont work for summit controller `make `
         >
         > but , WAM requires netdev `make -C driver NET=NETDEV_SUPPORT`

         - With WAM Custom RT Kernel on Jetson:
           - define the installed kernel out: `$ export kernel_out="$HOME/JX_linux/Linux_for_Tegra/source/public/kernel_out/"`
           - make: ` $ make -C driver NET=NETDEV_SUPPORT KERNEL_LOCATION=$kernel_out`
         
      2. `$ sudo make install`

   2. check `cat /proc/pcan`

      ```bash
      summit@summit-171102A:~$ cat /proc/pcan
      
      *------------- PEAK-System CAN interfaces (www.peak-system.com) -------------
      *------------- Release_20180720_n (8.6.0) May 25 2021 11:16:42 --------------
      *------------- [mod] [isa] [pci] [pec] [dng] [par] [usb] [pcc] --------------
      *--------------------- 1 interfaces @ major 243 found -----------------------
      *n -type- -ndev- --base-- irq --btr- --read-- --write- --irqs-- -errors- status
      32    usb   -NA- ffffffff 000 0x001c 00000000 00000000 00000000 00000000 0x0000
      ```

2. setup `60-can.rules` for robotnik summit CAN controller 

   1. `vim /etc/udev/rules.d/...`

   2. add a line `KERNEL=="pcanusb*", SYMLINK+="pcan_base", MODE="0666"`

   3. ```bash
      KERNEL=="pcanusb*", SYMLINK+="pcan_base", MODE="0666"
      RUN+="/bin/reset_can_non_xenomai.sh"
      ```

3. Reload udev rules or reboot to take effect:

   ```bash
   $ sudo service udev reload
   $ sudo service udev restart
   $ sudo udevadm trigger
   $ sudo rmmod pcan
   $ sudo modprobe pcan
   ```

4. Connect Peak USB-CAN dongle, and test with `lsmod | grep pcan`  and `ls /dev/pcanusb*`

### misc commands:

- ```
  # list can usb
  $ tree /dev/pcan-pcie_fd 
  
  # proc interface
  $ cat /proc/pcan
  
  # list of all the CAN interfaces
  $ tree -a /sys/class/pcan
  
  # check pcan driver variant:
  $ modinfo pcan.ko | grep -e ^description:
  
  $ modinfo pcan | grep -e "^depends:"
  
  $ dmesg | grep pcan
  /home/uwarl-orin/JX_Linux/Linux_for_Tegra/source/public/kernel/kernel-5.10/Makefile
  
  ---
  udevadm info -a -p $(udevadm info -q path -n pcanusb33)
  ```
  
- socket interface: https://www.pragmaticlinux.com/2021/07/automatically-bring-up-a-socketcan-interface-on-boot/

- udev rules : http://www.reactivated.net/writing_udev_rules.html

  

- PCAN: https://www.peak-system.com/fileadmin/media/linux/implementation-details.html


### PAD Configuration PS Controller (Sony)

- https://github.com/RobotnikAutomation/robotnik_pad

  - ds4drv automatic install: `sudo ./ds4drv-install.sh`
  - This step also modifies the `udev`  file: `cat /etc/udev/rules.d/50-ds4drv.rules`

    - Since PS4 Hidraw mode creates two jsX devices.
      - one by DS4DRV
      - one by OS upon pairing (only buttons, no acc)
    - There could be a race condition between the name of the devices, hence, we need a rules at the udev level, and prioritize js0 as the OS version, and then, js1 will be registered for ds4drv.
  - Check service: `$ systemctl status ds4drv.service`
  - Configuration setting: `ds4drv.conf`
  - >  :rotating_light: Please install `pip install six==1.13` or above, so ps4drv does not fail 
  - >  :tipping_hand_man: If not working, try `sudo` , sigh

  - > :tipping_hand_man: if systemctl cannot find package for ds4drv, make sure installed using `sudo python3.6 -m pip install -U ds4drv` instead of pip tool to be clear
    >
    > :tipping_hand_man: if does not work, try clearpath branch: https://github.com/clearpathrobotics/ds4drv

- Bluetooth dongle (plugable usb bluetooth 4.0 @ usb 2.0 port):

  - check bluetooth socket layer init status

    ```bash
    $ dmesg | egrep -i 'blue|firm' | cut -c 16-
    ```

  - Check:

    ```bash
    $ sudo systemctl status bluetooth.service # <-- make sure it is working
    $ rfkill list
    $ hcitool dev
    ```
  
  - Connect:
  
    ```bash
    $ sudo bluetoothctl
    
    #----- Command:
    [bluetooth]# scan on
    [bluetooth]# trust MAC
    [bluetooth]# agent on
    [bluetooth]# pair MAC
    ```
  
  - Check if jsX live is connected:
  
    ```
    ls /dev/input
    ```
  
  - Check udev name for js0 as "Sony Entertainment ***":
  
    ```
    udevadm info -a /dev/input/js0
    ```



### Pixhawk PX4 Flight Controller (IMU)

- PX4: https://docs.px4.io/main/en/dev_setup/building_px4.html

- ROS Guide: http://wiki.ros.org/RobotnikAutomation/Tutorials/Use%20Pixhawk%20in%20AGV

  ```bash
  $ sudo apt-get install ros-melodic-mavros ros-melodic-mavros-extras
  ```

- Steps:

  1. Identify the serial number:

     ```bash
     $ udevadm info -a /dev/ttyUSB0 | grep serial
     
     # --- Output:
         SUBSYSTEMS=="usb-serial"
         ATTRS{serial}=="FTA31EZ3"
         ATTRS{serial}=="0000:00:15.0"
     ```

  2. Create / Modify udev:

     ```bash
     $ sudo vim /etc/udev/rules.d/50-pixhawk.rules
     
     ## -- Paste Below:
     KERNEL=="ttyUSB[0-9]*", OWNER="summit", GROUP="dialout", MODE="0666"
     KERNEL=="ttyUSB[0-9]*", ATTRS{idProduct}=="6001", ATTRS{serial}=="FTA31EZ3", NAME="%k", SYMLINK="ttyUSB_PX4", GROUP="dialout", MODE="0666"
     ```

     If using USB-to-microUSB:

     ```bash
     KERNEL=="ttyUSB[0-9]*", OWNER="summit", GROUP="dialout", MODE="0666"
     SUBSYSTEM=="tty", ATTRS{idVendor}=="26ac", ATTRS{idProduct}=="0011", NAME="%k", SYMLINK="tty_PX4", GROUP="dialout", MODE="0666"
    ```
  
  3. reload and restart rules:
  
    ```bash
     sudo service udev reload 
     sudo service udev restart 
     sudo udevadm trigger
    ```



### [:star: A better version] UWARL ROS Catkin Workspace Setup

- Clone:

  ```bash
  # workspace:
  $ cd ~ && mkdir -p ~/UWARL_catkin_ws/src
  # clone --> to the src/ 
  $ git clone --recursive git@github.com:UW-Advanced-Robotics-Lab/SUMMIT-catkin_ws.git ~/UWARL_catkin_ws/src
  # recursive submodules:
  $ cd ~/UWARL_catkin_ws/src && git submodule update --init
  ```

- Dependencies:

  ```bash
  #### Manual install:
  $ sudo apt-get install -y ros-melodic-transmission-interface ros-melodic-effort-controllers ros-melodic-joint-state-controller ros-melodic-navigation ros-melodic-ros-control ros-melodic-ros-controllers ros-melodic-velocity-controllers ros-melodic-control-toolbox ros-melodic-cmake-modules ros-melodic-serial ros-melodic-joystick-drivers ros-melodic-rosbridge-server ros-melodic-robot-localization ros-melodic-twist-mux ros-melodic-imu-tools ros-melodic-teb-local-planner ros-melodic-slam-gmapping ros-melodic-ackermann-msgs ros-melodic-rosbridge-suite
  
  $ sudo apt-get install ros-melodic-robot-state-publisher
  $ sudo apt-get install ros-melodic-velodyn
  
  #### Auto install dependencies:
  # ROS Noetic
  $ sudo apt-get install python3-rosdep
  # ROS Melodic and earlier
  $ sudo apt-get install python-rosdep
  
  $ rosdep install --from-paths src --ignore-src -r -y
  ```

- Setup ROS RC configurations as described in [[⭐ A better version - Jack] RC Config for ROS and devices](####[⭐ A better version - Jack] RC Config for ROS and devices)

### [:no_entry_sign: Manual] catkin_ws

1. Install dependencies:

   ```bash
   $ sudo apt-get install -y ros-melodic-transmission-interface ros-melodic-effort-controllers ros-melodic-joint-state-controller ros-melodic-navigation ros-melodic-ros-control ros-melodic-ros-controllers ros-melodic-velocity-controllers ros-melodic-control-toolbox ros-melodic-cmake-modules ros-melodic-serial ros-melodic-joystick-drivers ros-melodic-rosbridge-server ros-melodic-robot-localization ros-melodic-twist-mux ros-melodic-imu-tools ros-melodic-teb-local-planner ros-melodic-slam-gmapping ros-melodic-ackermann-msgs ros-melodic-rosbridge-suite
   ```

2. Clone repos:

   1. System Monitor:`$ git clone https://github.com/RobotnikAutomation/system_monitor.git`
   2. Robot State: `$ sudo apt-get install ros-melodic-robot-state-publisher`
   3. Velodyne: `$ sudo apt-get install ros-melodic-velodyne`
   4. Teb Local Planner: `git clone https://github.com/rst-tu-dortmund/teb_local_planner.git`
   5. :red_circle: (UWARL) `git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-summit_xl_robot.git`
   6. :orange: (UWARL) `git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-summit_xl_common.git`
   7. (UWARL) `git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-summit_xl_sim.git`
   8. (UWARL) `git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robotnik_msgs.git`
   9. (UWARL) BASE HW: `git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robotnik_base_hw.git`
   10. :orange: (UWARL) `git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robotnik_sensors.git`
   11. :orange: (UWARL) `git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-multimap_server.git`

3. Result:

   Your `catkin_ws` will be as below:

   ```
   .
   ├── barrett-ros-pkg
   ├── rcomponent
   ├── robotnik_pad
   ├── system_monitor
   ├── teb_local_planner
   ├── uwarl-multimap_server
   ├── uwarl-robotnik_base_hw
   ├── uwarl-robotnik_msgs
   ├── uwarl-robotnik_sensors
   ├── uwarl-summit_xl_common
   ├── uwarl-summit_xl_robot
   └── uwarl-summit_xl_sim
   
   ```

4. Build base_hw dpkg:

   1. `sudo dpkg -i uwarl-robotnik_base_hw/lib/ros-melodic-robotnik-base-hw-lib_****_amd64.deb`

   2. >  :warning: In Melodic, you will see errror on dependency `melodic-msgs`, which is not available in melodic server, and required a local build, which will be done later with catkin build, just ignore this error

   3. > :notebook: we can actually build one :D
      >
      > ```bash
      > $ cd uwarl-robotnik_msgs
      > $ catkin build --this
      > $ bloom-generate rosdebian --os-name ubuntu --ros-distro melodic
      > $ fakeroot debian/rules binary
      > ```
      >
      > - now `dpkg`

5. Install all dependencies;

   ```bash
   # ROS Noetic
   $ sudo apt-get install python3-rosdep
   # ROS Melodic and earlier
   $ sudo apt-get install python-rosdep
   
   $ rosdep install --from-paths src --ignore-src -r -y
   ```

6. ✅ ==~~TO-DO: concatenate entire packages into a new repo with every repos as submodules~~==

   

### [⭐ A better version - Jack] RC Config for ROS and devices

- Lets use system boot as a method to auto boot services, as they can be restarted easily with status logs

- User system Permissions:

  ```
  sudo usermod -a -G dialout $USER 
  sudo usermod -a -G root $USER
  ```

- Just modify the file from `uwarl-robot_configs` repository as needed

- Configuration:

  1. Clone configurations: 

     ```bash
     $ cd ~ && git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robot_configs.git
     ```

  2. Make sure directories and ip are right in `~/uwarl-robot_configs/summit/user_services/environment`

  3. Add to `~/.zshrc`:

     ```bash
      sudo cp ~/uwarl-robot_configs/summit/user_services/environment ~/.ros/
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

- add to `~/zshrc/bashrc` for terminals:

  ```bash
  ## >>> Custom entries:
  source /home/uwarl/uwarl-robot_configs/summit/summitxl_ros_config.zsh
  # source /home/uwarl/uwarl-robot_configs/summit/summitxl_ros_config.bash # bash
  ## <<<< EOF .
  ```

  

### [🛑 robotnik] RC Config for ROS and devices

#### Boot/Startup Scripts:

1. User system Permissions:

   ```bash
   sudo usermod -a -G dialout $USER 
   sudo usermod -a -G root $USER
   sudo usermod -a -G tty $USER 				# for Pixhawk
   ```

2. Auto-login: `sudo systemctl edit getty@ttyX` with X=1,2,3,4

   Add : 

   ```bash
   [Service] 
   ExecStart= 
   ExecStart=-/sbin/agetty --autologin root --noclear %I 38400 linux
   
   [Service] 
   ExecStart= 
   ExecStart=-/sbin/agetty --autologin uwarl --noclear %I 38400 linux
   ```

   Change username to root in X=1 and summit / uwarl-orin in X = [2, 3, 4]

   Save, exit, then:

   ```bash
   systemctl enable getty@ttyX.service
   ```

#### RC:

1. Editor: `$ vim ~/.zshrc`

2. Autoboot:

   ```bash
   ## SUMMIT XL ###
   # AUTOBOOT
   echo "ROBOTNIK SUMMIT XLS"
       Terminal=`tty`
       case $Terminal in
           "/dev/tty1") sleep 5;
           ds4drv;; # PS4 Configuration
           "/dev/tty2") sleep 5;
           roscore;;
           "/dev/tty3") sleep 20;
           roslaunch summit_xl_bringup summit_xl_complete.launch;;
           "/dev/tty4") sleep 20;
           cd /home/summit/catkin_ws/src/summit_xl_robot/summit_xl_web;
           python -m SimpleHTTPServer;;
       esac
   ```

3. ROS Configure 

   Custom:

   ```zsh
   ## ROS RELATED ###
   source /opt/ros/melodic/setup.zsh
   source ~/UWARL_catkin_ws/devel/setup.zsh
   source ~/uwarl-robot_configs/summitxl_params.env
   
   # ROS:
   #export ROS_MASTER_URI=http://192.168.0.200:11311/
   #export ROS_IP=192.168.0.120
   
   # kill processor:
   alias kill-ros="ps aux  | grep -e ros | awk '{print $2}' | xargs -i -exec kill -9 {}"
   ```

   Original (from summit PC, copy as needed):

   ```bash
   #export ROS_MASTER_URI=http://summit-171102A:11311
   
   export ROS_MASTER_URI=http://192.168.0.200:11311
   #export ROS_MASTER_URI=http://129.97.71.92:11311
   #export ROS_MASTER_URI=http://localhost:11311
   
   # WAM Robot
   #export ROS_IP=192.168.115.102
   #export ROS_IP=192.168.0.23 # Ethernet IP of WAM
   #export ROS_HOSTNAME=192.168.0.23
   #################################
   
   #export ROS_IP=192.168.0.200
   #export ROS_IP=129.97.71.92
   
   
   #export ROS_MASTER_URI=http://127.0.1.1:11311
   # export ROS_IP=127.0.1.1
   
   # U of Waterloo
   # Velodyne VLP16 IP
   # export ROS_IP=192.168.0.11
   # LapTop IP
   # export ROS_HOSTNAME=192.168.0.100
   # LapTop IP in Robohub
   # Mohamed's laptop
   #export ROS_HOSTNAME=129.97.71.92
   # Lab's laptop
   #export ROS_HOSTNAME=129.97.71.95
   
   #For Lenovo P51 (Jeongwoo is using)
   #export ROS_HOSTNAME=192.168.0.102
   
   alias cw='cd ~/catkin_ws'
   alias cs='cd ~/catkin_ws/src'
   alias cm='cd ~/catkin_ws && catkin_make'
   alias bre='gedit ~/.bashrc'
   alias brs='source ~/.bashrc'
   alias kros="ps aux  | grep -e ros | awk '{print $2}' | xargs -i -exec kill -9 {}"
   ```

4. Summit Params Config:

   1. Clone Configuration repo: 
      ```bash
      $ git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robot_configs.git
      ```

   2. add `source ~/uwarl-robot_configs/summitxl_params.env` into `~/.zshrc` if not yet
   3. Robot Configuration Description:
      - ROBOT_ID indicates the name of the robot. This is the name of the namespace under all the nodes will be working. This is also used as the prefix of all the subcomponents.(*summit_xl*)

      - ROBOT_XACRO indicates the path where the xacro file is. (inside the robot folder in robot_description)(*summit_xl.urdf.xacro*)

      - ROBOT_FRONT_LASER_MODEL indicates the model of the laser that the robot is using. The model is the name of the launch file.(*sick_tim561/hokuyo_ug01/hokuyo_ust*)

      - ROBOT_REAR_LASER_MODEL indicates the model of the laser that the robot is using. The model is the name of the launch file.(*sick_tim561/hokuyo_ug01/hokuyo_ust*)

      - ROBOT_HAS_FRONT_LASER indicates if the robot has a laser in front. (*true/false*)

      - ROBOT_HAS_REAR_LASER indicates if the robot has a laser in rear. (*true/false*)

      - ROBOT_HAS_FRONT_PTZ_CAMERA indicates if the robot has the ptz camera in front. (*true/false*)

      - ROBOT_HAS_REAR_PTZ_CAMERA indicates if the robot has the ptz camera in front. (*true/false*)

      - ROBOT_HAS_GPS indicates if the robot has gps. (*true/false*)

      - ROBOT_HAS_FRONT_RGBD_CAMERA indicates if the robot has a front rgbd camera. (*true/false*)

      - ROBOT_FRONT_RGBD_CAMERA_ID camera id to identify in the bus

      - ROBOT_HAS_REAR_RGBD_CAMERA indicates if the robot has a front rgbd camera. (*true/false*)

      - ROBOT_REAR_RGBD_CAMERA_ID camera id to identify in the bus

      - ROBOT_PAD_MODEL pad model used. (*ps4/ps3/logitechf710/xbox360*)

      - ROBOT_GEARBOX establishes the motor gearbox value. (*24V: 12.52 | 48V: 9.56*)

      - ROBOT_HAS_ENCODER indicates if the robot has encoders. (*true/false*)

      - ROBOT_KINEMATICS kinematic configuration of the robot. (*skid/omni/steel_skid/steel_omni*)

      - ROBOT_HAS_ARM indicates if the robot has an arm (*true/false*

   

## Local Summit-PC Catkin-ws:

### UWARL Repo Versions Backed:

1. https://github.com/UW-Advanced-Robotics-Lab/uwarl-summit_xl_common : modifications found => https://github.com/UW-Advanced-Robotics-Lab/uwarl-summit_xl_common/pull/2
2. (optional) https://github.com/UW-Advanced-Robotics-Lab/uwarl-summit_xl_sim : not found local summit-pc
3. https://github.com/UW-Advanced-Robotics-Lab/uwarl-summit_xl_robot : remote head does not exist anymore
4. https://github.com/UW-Advanced-Robotics-Lab/uwarl-robotnik_msgs : nothing changed, outdated
5. https://github.com/UW-Advanced-Robotics-Lab/uwarl-robotnik_base_hw : compiled locally, nothing changed, outdated
6. https://github.com/UW-Advanced-Robotics-Lab/uwarl-robotnik_sensors : local changes found & outdate => https://github.com/UW-Advanced-Robotics-Lab/uwarl-robotnik_sensors/pull/1
7. https://github.com/UW-Advanced-Robotics-Lab/uwarl-multimap_server : master, local changes => https://github.com/UW-Advanced-Robotics-Lab/uwarl-multimap_server/pull/1


@fwthree3 may take a look and leave comment at each PR I opened or below to briefly recall things have been changed.

### Robotnik:

- https://github.com/RobotnikAutomation/system_monitor: master, 4 commits behind
### Other Vendors:

- https://github.com/ros/robot_state_publisher : noetic-level, 3 commits behind [Oct.03,2022]
- https://github.com/ros-drivers/velodyne : master, 186 commits behind [Oct.03,2022]
- https://github.com/rst-tu-dortmund/teb_local_planner : kinetic-devel, 65 commits behind [Oct.03, 2022]

### Unused:

- https://github.com/RobotnikAutomation/axis_camera : master, 12 commits behind [Oct.03,2022]

### Unknown:

-  `multimap_server_msgs-master` ?? not tracked, local compiled for remote ROS https://github.com/RobotnikAutomation/multimap_server_msgs

---



# Jetson AGX ORIN

## RT Kernel

> :rotating_light:"real-time" does not mean "faster". It means "lower and stable latency". Response times may even be a little longer than in a standard Linux kernel, but they will always be the same. [(cite:peak-sys)](https://www.peak-system.com/fileadmin/media/linux/index.htm)

### Reference

- **JetPack 5.0.2 | Jetson Linux r35.1** : available from here
- Official linux instruction: https://docs.nvidia.com/jetson/archives/r35.1/DeveloperGuide/text/SD/Kernel/KernelCustomization.html#using-the-jetson-linux-real-time-kernel-package
- Jetson Linux Doc:https://developer.download.nvidia.com/embedded/L4T/r35_Release_v1.0/Jetson_Linux_Release_Notes_r35.1.pdf

### Instruction on compiling on ORIN:

1. Install the latest kernel

2. and download the kernel source

3. Apply RT patches & Compile:

   > :no_entry_sign: Do not use the guide below, please refer to [Logbook:Jetson-setup.md] for the logs on RT Kernel

   ```bash
   uwarl-orin•Linux_for_Tegra/source/public» cd kernel                                                                                                                                                                                  [14:11:18]
   uwarl-orin•source/public/kernel» ls                                                                                                                                                                                                  [14:11:21]
   kernel-5.10  nvethernetrm  nvgpu  nvidia
   
   uwarl-orin•source/public/kernel» ./kernel-5.10/scripts/rt-patch.sh apply-patches                                                                                                                                                     [14:11:22]
   The PREEMPT RT patches have been successfully applied!
   uwarl-orin•source/public/kernel» cd -                                                                                                                                                                                                [14:11:26]
   ~/JX_linux/Linux_for_Tegra/source/public
   uwarl-orin•Linux_for_Tegra/source/public» ./nvbuild.sh -o $PWD/kernel_out
   
   
   [waitttting]
   
   # prepare kernel source tree
   $ cd kernel_out/arch/arm64/boot
   
   # back old image:
   $ sudo mv /boot/Image /boot/Image.bak.date
   
   # place new-compiled image
   $ sudo cp Image /boot
   
   ### Ifff NVME installed
   # NOTE: if NVME is used for boot with jetsonhack, then:
   $ sudo mount /dev/mmcblk0p1 /mnt
   $ cp -r /boot/* /mnt/boot/
   #is required to make it effective, as the boot actually boot from emmc/boot always, and then directed to nvme by service
   ####
   
   # reboot:
   sudo reboot
   
   # check
   $ uname -a
   
   #------ Result ------#
   # Before:
   > Linux ubuntu 5.10.104-tegra #1 SMP PREEMPT Wed Aug 10 20:17:07 PDT 2022 aarch64 aarch64 aarch64 GNU/Linux
   # After:
   > Linux ubuntu 5.10.104-rt63-tegra #1 SMP PREEMPT RT Thu Nov 10 15:11:56 EST 2022 aarch64 aarch64 aarch64 GNU/Linux
   
   
   ### Build PCAN with custom kernel with NETDEV:
   uwarl-orin•~/JX_linux/peak-linux-driver-8.15.2» export kernel_loc="$HOME/JX_linux/Linux_for_Tegra/source/public/kernel/"                                                                                                                              
   uwarl-orin•~/JX_linux/peak-linux-driver-8.15.2» make -C driver NET=NETDEV_SUPPORT KERNEL_LOCATION=$kernel_loc
   # install:
   uwarl-orin•~/JX_linux/peak-linux-driver-8.15.2» sudo make install KERNEL_LOCATION=$kernel_out
   ```


### compiling on external PC

- `sudo apt install flex`

- and require cross compile

  - ```
    export CROSS_COMPILE_AARCH64_PATH={path}/Toolchain_gcc_9.3/
    export CROSS_COMPILE_AARCH64={path}/Toolchain_gcc_9.3/bin/aarch64-buildroot-linux
    ```

## install libbarrett

1. Install dependencies `$ ./scripts/install_dependencies.sh`

   1. This will fail at builing the `libconfig-1.4.5`, due to outdated aux-build kernel guesses (the outdated one is 2006, last modified is 2022)

   2. So let's update:

      ```bash
      $ cd ~/Downloads/libconfig-1.4.5
      $ wget http://git.savannah.gnu.org/gitweb/\?p\=config.git\;a\=blob_plain\;f\=config.sub\;hb\=HEAD
      
      $ wget http://git.savannah.gnu.org/gitweb/\?p\=config.git\;a\=blob_plain\;f\=config.guess\;hb\=HEAD
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

### ~~2.4.1-(3) v2 : How to Build Libbarrett v2.0.0 on ubuntu 20 ?~~ [Not working]

> :stop_sign: No GOOD :sweat:  Attempted to install libbarrett 2.0.0 on ubuntu 20.
>
> 1. Follow previous v3.0.0 installation guide
>
> 2. Now, checkout v2.0.0 branch
>
>    ```bash
>    cd ~/uwarl-libbarrett
>    git checkout uwarl/melodic/dev2.0.1
>    ```
>
> 3. Manually install dependencies needed:
>
>    ```bash
>    sudo apt-get install -y build-essential python-dev python-argparse git cmake
>    sudo apt-get install -y libgsl0-dev libncurses5-dev pkg-config libboost-all-dev
>    
>    # install Eigen:
>    cd ~/JX_Linux
>    wget https://gitlab.com/libeigen/eigen/-/archive/3.2.10/eigen-3.2.10.tar.bz2
>    tar --bzip2 -xf eigen-3.2.10.tar.bz2
>    cd eigen-3.2.10/
>    mkdir -p build && cd build
>    cmake ../ && make && sudo make install
>    ```
>
> 4. Install a specific old version of libboost (1.65.1.0ubuntu1): https://stackoverflow.com/questions/8430332/uninstall-boost-and-install-another-version
>
> 5. Build and install:
>
>    ```bash
>    cd ~/uwarl-libbarrett
>    # clean old makes:
>    make clean
>    # specify eigen path , as latest version will have conflicts with some of the type casts:
>    cmake -D Eigen_INCLUDE_DIRS=/home/uwarl-orin/JX_Linux/eigen-3.2.10/ 
>    # make, for a while:
>    make -j8
>    # install:
>    sudo make install
>    ```

> 1. check boost version:
>
>    ```bash
>    dpkg -s libboost-dev | grep 'Version'
>    ```
>
> 2. Install boost 1.65.1 [https://www.boost.org/doc/libs/1_65_1/more/getting_started/unix-variants.html]
>
>    ```bash
>    $ cd ~/JX_Linux
>    $ wget http://downloads.sourceforge.net/project/boost/boost/1.65.1/boost_1_65_1.tar.gz
>    $ tar --bzip2 -xf ~/JX_Linux/boost_1_65_1.tar.bz2
>    $ cd boost_1_65_1
>    $ ./bootstrap.sh
>    $ ./b2 install
>    ```



# Axis Camera (AXIS M5013 Network Camera)

- Noetic ROS : https://wiki.ros.org/axis_camera
  - Github: https://github.com/ros-drivers/axis_camera/tree/noetic-devel
- Updated to M5013_5_51_7_6 from 5.50.3.1 



# Velodyn (VLP 16)

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

  

# TP Link Router (Archer C7 v2)

- Updated to 3.15.3 Build 180305 Rel.52658n (2018)





<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>