<toc>

# Table of Contents
[*Last generated: Thu  2 Mar 2023 15:56:45 EST*]
- [**1. Ubuntu**](#1-Ubuntu)
  - [1.1 Install Ubuntu](#11-Install-Ubuntu)
    - [1.1.1 Bootable USB](#111-Bootable-USB)
  - [1.2 Ubuntu Initial Setup](#12-Ubuntu-Initial-Setup)
    - [1.2.1 Basic Tools:](#121-Basic-Tools)
      - [1.2.1.a) Net-tools:](#121a-Net-tools)
      - [1.2.1.b) Open-SSH](#121b-Open-SSH)
      - [1.2.1.c) NoMachine:](#121c-NoMachine)
    - [1.2.2 Optional Advanced Tools:](#122-Optional-Advanced-Tools)
      - [1.2.2.a) Zenith](#122a-Zenith)
    - [1.2.x Note:](#12x-Note)
  - [1.3 Ubuntu Workspace Setup:](#13-Ubuntu-Workspace-Setup)
    - [1.3.1 ZSH and oh-my-zsh](#131-ZSH-and-oh-my-zsh)
    - [1.3.2 TMUX: virtual terminal within terminal](#132-TMUX-virtual-terminal-within-terminal)
    - [1.3.2 VIM:](#132-VIM)
    - [1.3.3 SSH Keys & Github](#133-SSH-Keys-Github)
    - [1.3.4 VSCode Remote SSH:](#134-VSCode-Remote-SSH)
  - [1.4 [:star:] UWARL ROS Catkin Workspace Setup](#14-star-UWARL-ROS-Catkin-Workspace-Setup)
  - [1.x Tips](#1x-Tips)
    - [1.x.1 Commonly used command:](#1x1-Commonly-used-command)
    - [1.x.2 Manually backup a directory of files:](#1x2-Manually-backup-a-directory-of-files)
- [**2. Mac**](#2-Mac)
- [**3. Windows**](#3-Windows)

---
</toc>
> :speaking_head: In this page, you may find useful step-by-step instructions to set-up your workstation:

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

#### 1.2.1.c) NoMachine:

- NO Machine: https://downloads.nomachine.com

  - Please check your OS version via: 

    ```bash
    $ arch
    ```

- See detailed setup **without monitor** in **[Waterloo-Steel/Platform-Setup.md]** 

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

### 1.3.1 ZSH and oh-my-zsh

- install zsh first 

  ```bash
  $ sudo apt install zsh
  # change to default in zsh
  $ sudo chsh -s $(which zsh)
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

0. :rotating_light: Pre-req:

    1. **Make sure SSH authenticated with Github, see instruction @ **

    2. **ZSH as default Shell**

1. Clone configurations: 

   ```zsh
   $ cd ~ && git clone git@github.com:UW-Advanced-Robotics-Lab/uwarl-robot_configs.git
   ```

2. Select Configuration Branch:

   ```bash
   $ cd ~/uwarl-robot_configs
   # check all available branches:
   $ git branch -a
   # EX: select `universal/ros1/data-analysis/session-feb-2023`:
   $ git checkout universal/ros1/data-analysis/session-feb-2023
   ```

3. :hot_pepper: **Register your PC ** in `common.sh`:

   ```bash
   $ vim ~/uwarl-robot_configs/scripts/common.sh
   ```

   1. Define Package Dependency:

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
      export ROS_JX_OEM_PC_IP=10.42.0.1
      export ROS_JX_OEM_PC_HOSTNAME=10.42.0.1
      export ROS_JX_OEM_PC_DISTRO=noetic
      ```

   3. In `function source_ros() ` , register Out-of-network as below:

      ```bash
          elif [[ $USER = "oem" ]] && [[ $LOCAL_PC_IP = "$ROS_JX_OEM_PC_IP" ]]; then
              ic_wrn " - NON-Robot PC User [Jack's Parallel VM] detected!"
              ic_wrn " > We have detected a registered out-of-network PC, now forcing local host for ROS_MASTER_URI !"
              ros_core_sync "LOCAL-HOSTS"
              export ROS_IP=$ROS_JX_OEM_PC_IP
              export ROS_HOSTNAME=$ROS_JX_OEM_PC_HOSTNAME
              export ROS_MASTER_URI=http://localhost:11311/
              export ROS_DISTRO=$ROS_JX_OEM_PC_DISTRO
              export DISPLAY=$DISPLAY_DEFAULT
              export PYTHONPATH_ROS=/usr/bin/python3
              export PYTHONPATH=$PYTHONPATH_ROS
      ```

4. ::hot_pepper: **Register PC Submodules Mapping** in `auto-config_UWARL_catkin_ws.zsh`

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
       elif [[ $USER = "oem" ]] && [[ $LOCAL_PC_IP = "$ROS_JX_OEM_PC_IP" ]]; then
           ic " > Loading parallels workspace submodules:"
           # install_misc_utilities # misc apt 
           # install_librealsense_if_not # for Intel Sensors
           load_submodules "${SUBMODULES_FOR_JX_OEM[@]}"
   ```

5. Install the repo and configure hardware with auto-script:

   ```zsh
   $ cd ~ && ./uwarl-robot_configs/scripts/auto-config_UWARL_catkin_ws.zsh
   ```

   > :notebook: this script will install automatically based on the **user name** (e.g. uwarl-orin) to identify the PC space
   >
   > :fire: This will install ROS Noetic for you, if you have ubuntu 20.04 focal (like Jetson) , otherwise, you have to install manually OR add a script to it as well?

6. Reboot is Required if it is the first time installing libbarrett !!

7. Catkin Build:    

   ```bash
   # source robot config env & ros
   $ source ~/.zshrc
   # build:
   $ build_ws # from anywhere, which will does the job for you :P (Jack is too lazy)
   # source:
   $ source_ws # lemme know if we should auto-source after build, :wink:
   ```

8. Commit Config settings:

   ```bash
   $ cd_config
   $ git status
   $ git commit -a
   # push to remote:
   $ git push
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