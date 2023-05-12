<toc>

# Table of Contents
[*Last generated: Fri 12 May 2023 11:28:27 EDT*]
- [**0. Common**](#0-Common)
  - [0.1 Remote & Collaboration](#01-Remote-Collaboration)
    - [0.1.a AnyDesk : remote screen & remote VPN ssh](#01a-AnyDesk-remote-screen-remote-VPN-ssh)
    - [0.1.b NoMachine : Local Network Remote Screen](#01b-NoMachine-Local-Network-Remote-Screen)
    - [0.1.c TeamViewers : remote screen only](#01c-TeamViewers-remote-screen-only)
    - [0.1.d Remote Desktop : remote screen](#01d-Remote-Desktop-remote-screen)
- [**1. Ubuntu**](#1-Ubuntu)
  - [1.1 Install Ubuntu](#11-Install-Ubuntu)
    - [1.1.1 Bootable USB](#111-Bootable-USB)
  - [1.2 Ubuntu Initial Setup](#12-Ubuntu-Initial-Setup)
    - [1.2.1 Basic Tools:](#121-Basic-Tools)
      - [1.2.1.a) Net-tools:](#121a-Net-tools)
      - [1.2.1.b) Open-SSH](#121b-Open-SSH)
      - [1.2.1.c)* (Optional) NoMachine (see hardware-setup guide common):](#121c-Optional-NoMachine-see-hardware-setup-guide-common)
      - [1.2.2.d)* (optional) Remote Desktop Auto-Sleep and Auto-Wake Scheduling:](#122d-optional-Remote-Desktop-Auto-Sleep-and-Auto-Wake-Scheduling)
    - [1.2.2 Optional Advanced Tools:](#122-Optional-Advanced-Tools)
      - [1.2.2.a) Zenith](#122a-Zenith)
    - [1.2.x Note:](#12x-Note)
  - [1.3 Ubuntu Workspace Setup:](#13-Ubuntu-Workspace-Setup)
    - [1.3.0 (Desktop) Share Wifi Through Ethernet:](#130-Desktop-Share-Wifi-Through-Ethernet)
    - [1.3.1 ZSH and oh-my-zsh](#131-ZSH-and-oh-my-zsh)
    - [1.3.2 TMUX: virtual terminal within terminal](#132-TMUX-virtual-terminal-within-terminal)
    - [1.3.2 VIM:](#132-VIM)
    - [1.3.3 SSH Keys & Github](#133-SSH-Keys-Github)
    - [1.3.4 VSCode Remote SSH:](#134-VSCode-Remote-SSH)
  - [1.4 [:star:] UWARL ROS Catkin Workspace Setup](#14-star-UWARL-ROS-Catkin-Workspace-Setup)
    - [1.4.1 Clone configurations:](#141-Clone-configurations)
    - [1.4.2 Select Configuration Branch:](#142-Select-Configuration-Branch)
    - [1.4.3 :hot_pepper: Register your PC  in `common.sh`:](#143-hot_pepper-Register-your-PC-in-commonsh)
    - [1.4.4 :hot_pepper: Register PC Submodules Mapping in `auto-config_UWARL_catkin_ws.zsh`](#144-hot_pepper-Register-PC-Submodules-Mapping-in-auto-config_UWARL_catkin_wszsh)
    - [1.4.5 Install the repo and configure hardware with auto-script:](#145-Install-the-repo-and-configure-hardware-with-auto-script)
    - [1.4.6 *Reboot is Required if it is the first time installing libbarrett !!](#146-Reboot-is-Required-if-it-is-the-first-time-installing-libbarrett-)
    - [1.4.7 Catkin Build:](#147-Catkin-Build)
    - [1.4.8 Commit Config settings:](#148-Commit-Config-settings)
  - [1.5 How to use Configuration Toolchain:](#15-How-to-use-Configuration-Toolchain)
    - [1.5.1 Modifications:](#151-Modifications)
    - [1.5.2 Commit and Push:](#152-Commit-and-Push)
    - [1.5.3 Pull latest repo:](#153-Pull-latest-repo)
    - [1.5.4 Restart over the catkin workspace:](#154-Restart-over-the-catkin-workspace)
    - [1.5.5 Shortcuts:](#155-Shortcuts)
  - [1.x Tips](#1x-Tips)
    - [1.x.1 Commonly used command:](#1x1-Commonly-used-command)
    - [1.x.2 Manually backup a directory of files:](#1x2-Manually-backup-a-directory-of-files)
- [**2. Mac**](#2-Mac)
- [**3. Windows**](#3-Windows)

---
</toc>
> :speaking_head: In this page, you may find useful step-by-step instructions to set-up your workstation:

# 0. Common

## 0.1 Remote & Collaboration

### 0.1.a AnyDesk : remote screen & remote VPN ssh

- For details, see in https://anydesk.com/en

### 0.1.b NoMachine : Local Network Remote Screen 

- We use this tool to access Jetson Orin without monitor with GUI
- Best for local network
- minimal computer resources needed

### 0.1.c TeamViewers : remote screen only

- Basic, but recommend AnyDesk over TeamViewers

### 0.1.d Remote Desktop : remote screen

- Worst in terms of performance
- high cost on computer resources
- Best for windows???

# 1. Ubuntu

[@jack.xu@uwaterloo.ca]

## 1.1 Install Ubuntu 

### 1.1.1 Bootable USB

> search for bootable USB

## 1.2 Ubuntu Initial Setup 

### 1.2.1 Basic Tools:

#### 1.2.1.a) Net-tools:

```bash
$ sudo apt install net-tools
# now you can check ip:
$ ifconfig
```

#### 1.2.1.b) Open-SSH

```bash
$ sudo apt update
$ sudo apt install openssh-server
# allow bypass firewall
$ sudo ufw allow ssh 
# check ssh status:
$ sudo systemctl status ssh
```

- to connect to this server:

  ```bash
  $ ssh username@ip_address
  # search for local network ip in case
  $ ip a 
  ```

#### 1.2.1.c)* (Optional) NoMachine (see hardware-setup guide common):

- NO Machine: https://downloads.nomachine.com

  - Please check your OS version via: 

    ```bash
    $ arch
    ```

- See detailed setup **without monitor** in **[[Waterloo-Steel/Platform-Hardware-Setup.md]](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Hardware-Setup#013-star-NO-MACHINE-preferred-without-monitor-attached)** 

  > 📣 You will see all available local NoMachine through the APP, and allow us to remote screen from **Mac, WIN, Ipad, and Ubuntu.**

#### 1.2.2.d)* (optional) Remote Desktop Auto-Sleep and Auto-Wake Scheduling:

- Please see detailed guide in [[Waterloo-Steel/Platform-Hardware-Setup.md]](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Hardware-Setup#014-remote-desktop-auto-sleep-and-auto-wake-scheduling)

### 1.2.2 Optional Advanced Tools:

#### 1.2.2.a) Zenith

```bash
$ sudo apt install curl
$ curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
# then install:
$ deb-get install zenith
$ deb-get update
$ deb-get upgrade
```

### 1.2.x Note:

> :notebook: Now you may access Ubuntu remotely, and setup following locally on Ubuntu or remotely 



## 1.3 Ubuntu Workspace Setup:

### 1.3.0 (Desktop) Share Wifi Through Ethernet:

- This is the preferred environment. PCW computers will be using Ubuntu 20.04. [Reference](https://docs.phillycommunitywireless.org/en/latest/device-configs/shared-connection/)
  1. Open your Settings > Network.
  2. Under the Wired section, click the plus sign to create a new settings profile. Name the profile "Shared" or whatever you want.
  3. In the IPv4 tab, choose "Shared to other computers". Click Apply. Your computer should now be networked with the AP. 10.42.0.0/24 is the default subnet used by Ubuntu for this setup, but there's not necessarily a guarantee that your computer will use that subnet. If the next step returns no results, run ip address or ifconfig and look for the IP of your Ethernet interface (usually eth0) there.

### 1.3.1 ZSH and oh-my-zsh

- install zsh first 

  ```bash
  $ sudo apt install zsh
  # change to default in zsh
  $ sudo chsh -s $(which zsh)
  $ sudo chsh -s $(which zsh) $USER
  ```

- **Oh-my-zsh** (THE hipster dev tool + coke)

  ```bash
  $ sudo apt install curl
  $ sudo apt install git
  $ sudo apt install vim
  $ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  # to modify themes:
  $ sudo vim ~/.zshrc
  ## Recommended themes: `ys` and `jonathan`
  $ source ~/.zshrc
  ```

  > :information_source:  https://github.com/ohmyzsh/ohmyzsh
  >
  > :information_source: Themes: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

### 1.3.2 TMUX: virtual terminal within terminal

- https://linuxize.com/post/getting-started-with-tmux/

- Pretty/Easy-to-use Custom Mod: https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/ (except ctrl-b mod)

- ```bash
  $ sudo apt install tmux
  ```

> :notebook: Do not use multiple `ssh` clients, as they will make the system a bit heavier. 

> 🔥 Tmux can still run in the background, even if the computer is disconnected from the internet. 

> :warning: Normal ssh sessions without tmux will terminate the program if your ssh client is disconnected

### 1.3.2 VIM:

1. set github editor to vim:

   ```bash
   $ git config --global core.editor "vim"
   ```

   > or have env variable in zshrc: `export GIT_EDITOR=vim`

2. Why VIM? ---> personal preference

### 1.3.3 SSH Keys & Github

1. generate key 

   ```bash
   $ ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. copy the public key 

   ```bash
   $ cat ~/.ssh/id_ed25519.pub
   ```

3. paste to github SSH keys under personal account profile

### 1.3.4 VSCode Remote SSH:

> 🎫 I  often use VSCode Remote SSH to modify codebase --Jack

1. Open VSCode, and make sure **[Remote-SSH]** is installed in **EXTENSIONS: MARKETPLACE** on left tab

2. **[CMD + P]** to open command pallette , and type command "***> SSH***" and select **[Remote SSH: Connect to Host ...]**

3. Enter host username and ip: 

   ```bash
   $ ssh username@ip_address
   ```

4. Now you can open folder in local VSCode editor and modify the remote files

5. :happy:

## 1.4 [:star:] UWARL ROS Catkin Workspace Setup

> Install Catkin Workspace + Hardware Setup + ROS in one script


> 🔥 (hot-takes) on **[Hardware v2]** : A unified multi-platform configuration
>
> - `UWARL_catkin_ws/src`:  A single common catkin workspace that can be deployed dynamically across multiple platforms. This repository will track other ROS components as submodules on particular commit hask token (without tracking physical files and changes).
> - `uwarl-robot_configs`: An all-star installation toolkit that will configure any hardware automatically with simple bash scripts.
> - Supported OS: **Ubuntu 18.04** and **Ubuntu 20.04** (includes auto-install for ROS-Noetic)

0. :rotating_light: Pre-req:

     1. **Make sure SSH authenticated with Github, see instruction @ **

     2. **ZSH as default Shell**

     

### 1.4.1 Clone configurations: 

```zsh
$ cd ~ && git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robot_configs.git
```

### 1.4.2 Select Configuration Branch:

```bash
$ cd ~/uwarl-robot_configs
# check all available branches:
$ git branch -a
# EX: select `universal/ros1/data-analysis/session-feb-2023`:
$ git checkout universal/ros1/data-analysis/session-feb-2023
```

### 1.4.3 :hot_pepper: Register your PC  in `common.sh`:

```bash
$ vim ~/uwarl-robot_configs/scripts/common.sh
```

1. Define Package Dependency:

   > :warning: Please add submodules iff you needed them to reduce overall `build_ws` compile time for different workstation with different purposes.

   > :notebook: These will tell the script everytime you call `update_ws` what submodules to download from, else it will just be an empty folder under `UWARL_catkin_ws/src` without any contents.

   ```bash
   # $USER = "oem":
   SUBMODULES_FOR_JX_OEM=(
       ## SUMMIT Side:
       "multimap_server_msgs"
       "system_monitor"
       "uwarl-multimap_server"
       "uwarl-robot_localization_utils"
       # "uwarl-robotnik_base_hw"  # not needed for simulation !  # [x86_64 only]
       "uwarl-robotnik_msgs"
       "uwarl-robotnik_sensors"
       # "uwarl-summit_xl_common"
       "uwarl-summit_xl_robot"
       "waterloo_steel"
       ## WAM Side:
       "uwarl-barrett_wam_hw"      # : Enabled for local dev.  # [x86_64, aarch64/arm64]
       "uwarl-barrett_wam_msgs"
       "uwarl-realsense_ros"       # [L515 Support]
   )
   ```

2. Define New PC and Network Parameters:

   ```bash
   export ROS_JX_IN_NETWORK_PARALLEL_PC_IP=192.168.1.100
   ```
   
3. In `function source_ros() ` , register PC as below:

   1. Out of network:

      ```bash
          elif [[ $USER = "jx" ]]; then
              # manual config:
              export UWARL_ROBOT_PC_NAME="JX_DESKTOP_JACK"
              export ROS_DISTRO=noetic
              export DISPLAY=$DISPLAY_DEFAULT
              export PYTHONPATH_ROS=/usr/bin/python3
              export PYTHONPATH=$PYTHONPATH_ROS
              # welcome:
              ic_wrn " - NON-Robot PC User [$UWARL_ROBOT_PC_NAME] detected!"
              # ros core:
              sync_ros_core_if_in_robot_network_else_localhost $ROS_EXTERNAL_PC_IN_NETWORK_IP 
      ```

   2. In-network PC, where the PC IP is binded to a specific IP, and connected to `UWARL_171102A_5G`

      ```bash
      ### [ Robot Network: UWARL-171102A_5G Wifi ] ###
      # DHCP , may change:
      export ROS_JX_IN_NETWORK_PARALLEL_PC_IP=192.168.1.100
      # export ROS_P51_IN_NETWORK_LENOVO_PC_IP=192.168.1.x
      # export ROS_JX_IN_NETWORK_OEM_PC_IP=192.168.1.x
      # export ROS_P50s_IN_NETWORK_LENOVO_PC_IP=192.168.1.x
      
      # [USER:] please change this one if you want to direct it to your own PC to host ROSCORE:
      export ROS_EXTERNAL_PC_IN_NETWORK_IP=$ROS_JX_IN_NETWORK_PARALLEL_PC_IP 
      ```


### 1.4.4 :hot_pepper: Register PC Submodules Mapping in `auto-config_UWARL_catkin_ws.zsh`

- add attributes as below after **line 80**

  > [Optional]:
  >
  > - You may uncomment `install_misc_utilities # misc apt ` 
  >   - to install some apt packages (tree, tmux, git, zsh, vim)
  > - You may uncomment `install_librealsense_if_not`
  >   - to install driver for librealsense cameras
  > - You may install PCAN by adding:
  >   - NETDEV:  `install_pcan_if_not NETDEV_SUPPORT`
  >   - NON_NETDEV: `install_pcan_if_not NETDEV_SUPPORT`
  > - You may install Dlink Dongle for wifi dongle provided in the lab:
  >   - `install_dlink_dongle`
  > - You may add `install_libbarrett_if_not` for `wam_node` hardware dependency

```bash
    "JX_DESKTOP_JACK")
        load_submodules "${SUBMODULES_FOR_JX_DESKTOP[@]}"
        install_misc_utilities # misc apt 
        install_libbarrett_if_not
        install_librealsense_if_not # for Intel Sensors
    ;;
```

### 1.4.5 Install the repo and configure hardware with auto-script:

```zsh
$ cd ~ && ./uwarl-robot_configs/scripts/auto-config_UWARL_catkin_ws.zsh
```

> :notebook: this script will install automatically based on the **user name** (e.g. uwarl-orin) to identify the PC space
>
> :fire: This will install ROS Noetic for you, if you have ubuntu 20.04 focal (like Jetson) , otherwise, you have to install manually OR add a script to it as well?

### 1.4.6 *Reboot is Required if it is the first time installing libbarrett !!

### 1.4.7 Catkin Build:    

```bash
# source robot config env & ros
$ source ~/.zshrc
# build:
$ build_ws # from anywhere, which will does the job for you :P (Jack is too lazy)
# source:
$ source_ws # lemme know if we should auto-source after build, :wink:
```

### 1.4.8 Commit Config settings:

```bash
$ cd_config
$ git status
$ git commit -a
# push to remote:
$ git push
```


## 1.5 How to use Configuration Toolchain:

### 1.5.1 Modifications:

1. switch workspace : `git checkout {branch-name}`
2. add modules: `$ git submodule add {git-repo}`
3. remove submodules: `$ git submodule deinit {git-repo}` and you may need delete the submodules in `.gitmodules` file
4. Create a new branch of workspace: `git checkout -b waterloo_steel/adlink-mxe211-melodic/{node}/{feature}`

### 1.5.2 Commit and Push:

1. Commit all changes under submodules
2. Make sure you run this: `$ ./git-status-all.sh` to log all status into `git-status-all.log`
3. commit all current workspace changes: `$ git add . && git commit -a`
4. Push workspace `$ git push` or upload a branch `$ git push -u {your-branch-name}`

### 1.5.3 Pull latest repo:

```bash
$ cd_ws/src && git status # make sure no local changes
$ update_ws
```

### 1.5.4 Restart over the catkin workspace:

```bash
# delete current workspace
$ cd $HOME
$ rm -rf UWARL_catkin_ws 
# reinstall everything and build:
$ cd_config
$ ./scripts/auto-config_UWARL_catkin_ws.zsh
$ build_ws
$ source_ws
```

### 1.5.5 Shortcuts:

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

# auto-gen Table of Contents for a specific markdown file
$ md_toc README.md 
# auto-gen Table of Contents for a specific directory containing all markdown files
$ md_toc_dir docs
```

## 1.x Tips

### 1.x.1 Commonly used command:

1. `$ uname -r`: OS check 
2. `$ cat /prov/version_signature`: identify kernel
3. `$ arp -a` : Scan Local Network Devices and IPs
4. `$ tree -L 1`: list hierarchy of directory in depth=1

### 1.x.2 Manually backup a directory of files:

1. EX: backup home directory [[cite:how-to-backup]](https://www.pragmaticlinux.com/2021/05/how-to-backup-your-home-directory-in-linux/)

   ```bash
   sudo rsync -a --info=progress2 --exclude="lost+found" --exclude=".cache" /home/ /mnt/usbdrive/
   ```



# 2. Mac

[TODO]



# 3. Windows

[TODO]








<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>