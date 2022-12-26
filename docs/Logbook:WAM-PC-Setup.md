<toc>

# Table of Contents
[*Last generated: Mon 26 Dec 2022 10:53:36 EST*]
- [**Install Libbarrett hardware (external PC) direct support through PEAK USB CAN (PCAN)**](#Install-Libbarrett-hardware-external-PC-direct-support-through-PEAK-USB-CAN-PCAN)
- [**CF WAM Internal PC Setup:**](#CF-WAM-Internal-PC-Setup)
  - [Re-Install CF:](#Re-Install-CF)
  - [Install End-of-service ROS:](#Install-End-of-service-ROS)
- [**Make a image copy of the entire CF card:**](#Make-a-image-copy-of-the-entire-CF-card)
- [**WAM External PC**](#WAM-External-PC)
  - [ADLINK Box | Ubuntu 18.04 Melodic | libbarrett 2.0.0](#ADLINK-Box-Ubuntu-1804-Melodic-libbarrett-200)
- [**Config:**](#Config)
  - [Zero Cal:](#Zero-Cal)

---
</toc>

---
# Install Libbarrett hardware (external PC) direct support through PEAK USB CAN (PCAN)
- install ros pkg barrett from manufacture: https://support.barrett.com/wiki/WAM/InstallBarrettRosPkg
	- install under catkin_ws/src
- install libbarrett : https://support.barrett.com/wiki/Libbarrett/Installation
	- clone `git clone https://git.barrett.com/software/libbarrett` into `src`
	- `cd ~/libbarrett/scripts` and install `sh ./install_dependencies.sh`

# CF WAM Internal PC Setup:
## Re-Install CF:
- Clear CF card and delete all occupied spaces
- install on a Ubuntu PC by running scripts in https://support.barrett.com/wiki/WAM/CreateCF
	- Download the install bash script, and modify the grep such that it installed at the disk you specified under /dev/sd##
## Install End-of-service ROS:
- http://wiki.ros.org/SnapshotRepository

- build a custom local rosdep: https://chowdera.com/2022/01/202201171917303691.html

- install hydro dependencies
```
sudo apt-get install ros-hydro-sensor-msgs
sudo apt-get install ros-hydro-sensor-msgs


----
rosdep install --from-paths src/ --ignore-src --rosdistro hydro
```

# Make a image copy of the entire CF card:

[Click here to check the original reference](https://askubuntu.com/questions/227924/sd-card-cloning-using-the-dd-command)

1. check disks `$ sudo fdisk -l`
2. unmount the SD card `$ sudo umount /dev/sdb`
3. Create an image `$ sudo dd if=/dev/sdb of=/media/uwarl-orin/VIP_FILE_BAK/WAM_SYSTEM_IMG_BACKUP/wam-internal-back-2022-oct-04.img bs=1M status=progress`
4. Write to disk from an image (MUCH SLOWER): `sudo dd if=/media/uwarl-orin/VIP_FILE_BAK/WAM_SYSTEM_IMG_BACKUP/wam-internal-back-2022-oct-04.img of=/dev/sdb bs=1M status=progress`

# WAM External PC

## ADLINK Box | Ubuntu 18.04 Melodic | libbarrett 2.0.0
- [EOL: May, 2023!!] ROS Melodic: https://wiki.ros.org/melodic/Installation/Ubuntu
- libbarrett (non-RT): https://git.barrett.com/software/libbarrett/-/tree/dev-2.0.0
      - manually change config after installation, or use modified UWARL version: https://github.com/UW-Advanced-Robotics-Lab/uwarl-libbarrett
- (*) PeakCAN (RT + **NETDEV_SUPPORT**): https://www.peak-system.com/fileadmin/media/linux/index.htm
  - https://support.barrett.com/wiki/Hand/282/SoftwareSetup/Linux NO_NETDEV_SUPPORT

- barrett-ros-pkg (release-2.0.0): https://git.barrett.com/software/barrett-ros-pkg/-/tree/release-2.0.0
- RT kernel patch: https://stackoverflow.com/questions/51669724/install-rt-linux-patch-for-ubuntu
- download libbarrett 3.0.0, and manually install CAN and dependencies based on the bash scripts `$ cat install_dependencies.sh`

# Config:
## Zero Cal:
with `/etc/barrett/*` default, and `/UWARL_drivers/barrett/*` customized to Waterloo steel
```bash
{22-07-22 18:01}uwarl-MXE210-18:~/UWARL_drivers uwarl% diff -r barrett/ /etc/barrett
diff --color -r barrett/calibration_data/wam7w/zerocal.conf /etc/barrett/calibration_data/wam7w/zerocal.conf
1,2c1
< home = ( -0.0001095700572, -1.868457755, -0.003420908008, 3.087304199, 0.001106996437, 0.137188488, -0.006267436993 );
< zeroangle = ( 4.667903538, 4.980835618, 4.649495768, 5.850602725, 2.110757564, 0.788466125, 4.420932631 );
---
> home = ( 0, -2, 0, 3.13, 0, 0, 0 );
Only in barrett/calibration_data/wam7w: zerocal.conf.1
Only in barrett/calibration_data/wam7w: zerocal.conf.2
Only in barrett/calibration_data/wam7w: zerocal.conf.3
Only in barrett/calibration_data/wam7w: zerocal.conf.4
Only in barrett/calibration_data/wam7w: zerocal.conf.5
```
> 📢 Now, available @ https://github.com/UW-Advanced-Robotics-Lab/uwarl-libbarrett 


<eof>

---
[*> Back To Top <*](#Table of Contents)
</eof>