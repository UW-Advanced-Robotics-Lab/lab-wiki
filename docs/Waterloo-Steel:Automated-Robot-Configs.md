<toc>

# Table of Contents
[*Last generated: Wed 27 Sep 2023 02:15:06 PM EDT*]
- [Table of Contents](#table-of-contents)
- [1. A brief about `uwarl-robot_configs`](#1-a-brief-about-uwarl-robot_configs)
  - [1.1 How to Setup Workstation:](#11-how-to-setup-workstation)
    - [1.1.1 How to register your PC in common:](#111-how-to-register-your-pc-in-common)
  - [1.2 How to Setup Platform Hardware:](#12-how-to-setup-platform-hardware)
  - [1.3 How to Use Platform Toolchain and Maintain Workspace:](#13-how-to-use-platform-toolchain-and-maintain-workspace)
  - [1.4 How to Launch the Robot:](#14-how-to-launch-the-robot)
  - [1.5 How to Modify and Commit to Config Toolchains:](#15-how-to-modify-and-commit-to-config-toolchains)
- [2. ⭐ Unified Development :construction:  \[Local PC / Summit / WAM\] (Melodic/Noetic):](#2--unified-development-construction--local-pc--summit--wam-melodicnoetic)
  - [2.1 How to commit:](#21-how-to-commit)
  - [2.2 How to Add a new modules under workspace/src:](#22-how-to-add-a-new-modules-under-workspacesrc)
  - [2.3 \[The Branching Strategy\] How to branch for modifications:](#23-the-branching-strategy-how-to-branch-for-modifications)
  - [2.4 Rebasing Branches:](#24-rebasing-branches)
  - [2.5 Merging Your Branch:](#25-merging-your-branch)
- [3. ROS UWARL\_catkin\_ws Usage Guide:](#3-ros-uwarl_catkin_ws-usage-guide)
  - [3.1 Modifications:](#31-modifications)
  - [3.2 Commit and Push:](#32-commit-and-push)
  - [3.3 Pull latest repo:](#33-pull-latest-repo)
  - [3.4 Restart over the catkin workspace:](#34-restart-over-the-catkin-workspace)
  - [3.5 Shortcuts:](#35-shortcuts)
    - [3.5.1 Short for ROS workspace:](#351-short-for-ros-workspace)
    - [3.5.2 Short for OS Env.:](#352-short-for-os-env)
    - [3.5.3 Short for UWARL\_catkin\_ws/src Commit:](#353-short-for-uwarl_catkin_wssrc-commit)
    - [3.5.4 Short for Robot Config Toolchain:](#354-short-for-robot-config-toolchain)
    - [3.5.5 Shorts for Git (Pretty)](#355-shorts-for-git-pretty)
    - [3.5.6 Short Generation Tool for Markdown .md files:](#356-short-generation-tool-for-markdown-md-files)
    - [3.5.7 Short for Tmux Multi-pane Session:](#357-short-for-tmux-multi-pane-session)
      - [3.5.7.a) tmux configuration file:](#357a-tmux-configuration-file)
    - [3.5.8 SUMMIT Systemctl Service:](#358-summit-systemctl-service)
    - [3.5.9 JETSON Service:](#359-jetson-service)
    - [3.5.10 Debug and Profiling in ROS](#3510-debug-and-profiling-in-ros)
    - [3.5.11 ROS Console Logging Level (An easy way):](#3511-ros-console-logging-level-an-easy-way)
- [4. Tools:](#4-tools)
  - [4.1 Remote Desktop Auto-Sleep and Auto-Wake Scheduling:](#41-remote-desktop-auto-sleep-and-auto-wake-scheduling)
  - [4.2 Remote Desktop without physical monitor (Headless Monitor):](#42-remote-desktop-without-physical-monitor-headless-monitor)
- [A. Appendix:](#a-appendix)
  - [A.1 File Tree:](#a1-file-tree)
  - [A.2 ZSHRC Terminal Output After Installing:](#a2-zshrc-terminal-output-after-installing)
  - [A.3 Environment Configurations:](#a3-environment-configurations)
    - [A.3.1 summitxl\_params.env](#a31-summitxl_paramsenv)

---
</toc>


# 1. A brief about `uwarl-robot_configs`

This repo will keep track of the configuration files.
This repo will serve as auto-configuration tool to install `~/UWARL_catkin_ws` from repo: https://github.com/UW-Advanced-Robotics-Lab/UWARL_catkin_ws and load necessary submodules needed per hardware configuration automatically.

> :warning: For more/latest setup tips, please refer to the [Lab Wiki Guide](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Instructions) for details.

## 1.1 How to Setup Workstation:
Please go to: [> Link to Wiki Page: Platform Workstation Setup <](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Workstation-Setup)

### 1.1.1 How to register your PC in common:

Please go to: [> Link to Wiki Page : Register your PC in common.sh <](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Workstation-Setup#143-hot_pepper-register-your-pc--in-commonsh)

## 1.2 How to Setup Platform Hardware:
Please go to:  [> Link to Wiki Page: Platform Hardware Setup <](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Hardware-Setup)

## 1.3 How to Use Platform Toolchain and Maintain Workspace:
Please go to:  [> Link to Wiki Page: Platform Development <](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Development)

## 1.4 How to Launch the Robot:
Please go to:  [> Link to Wiki Page: Platform Launch Instruction <](https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Launch-Instruction)

## 1.5 How to Modify and Commit to Config Toolchains:
1. Make sure you checkout your own branch before modifying someone's branch:
   ```bash
   $ cd_config
   $ git branch -v
   #### OUTPUT:
   #     universal/ros1/data-analysis/session-feb-2023 da577d7 [behind 3] [ New: tmux multi session sync launch ] + a shortcut function would auto-launch everything in multiple sub-widows in tmux
   #     universal/ros1/data-analysis/session-jan-2023 616a10f [ begin of data analysis development (jx) ]
   #   * universal/ros1/data-analysis/session-wed-2023 46ab84a [ahead 3] Merge branch 'universal/ros1/data-analysis/session-wed-2023' of github.com:UW-Advanced-Robotics-Lab/uwarl-robot_configs into universal/ros1/data-analysis/session-wed-2023
   #     universal/ros1/robohub/session-dec-2022       25118a9 Merge pull request #8 from UW-Advanced-Robotics-Lab/universal/ros1/robohub/session-dec-2022
   #     universal/ros1/robohub/session-dec-2022-deck  4cb0a25 + deck configs
   #     universal/ros1/robohub/session-jan-2023       012c854 + suspending scripts
   #     waterloo_steel/universal/main                 25118a9 [behind 36] Merge pull request #8 from UW-Advanced-Robotics-Lab/universal/ros1/robohub/session-dec-2022
   
   $ git checkout -b universal/ros1/data-analysis/session-wed-2023_register_my_pc
   $ git push -u origin universal/ros1/data-analysis/session-wed-2023_register_my_pc
   ```
2. Make a PR (Pull Requests) on GitHub UI to merge-in your changes
---
# 2. ⭐ Unified Development :construction:  [Local PC / Summit / WAM] (Melodic/Noetic):

> 🔥 (hot-takes) on **[Hardware v2]** : A unified multi-platform configuration
>
> - `UWARL_catkin_ws/src`:  A single common catkin workspace that can be deployed dynamically across multiple platforms. This repository will track other ROS components as submodules on particular commit hask token (without tracking physical files and changes).
> - `uwarl-robot_configs`: An all-star installation toolkit that will configure any hardware automatically with simple bash scripts.
> - Supported OS: **Ubuntu 18.04** and **Ubuntu 20.04** (includes auto-install for ROS-Noetic)

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
   > It will install peak can for Jetson and adlink
   > It will install libbarrett for Jetson

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
   $ cd_ws
   $ commit_ws # it will automatically log all the submodule status for this commit, and prompt any residual modifications
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
       "uwarl-zed_ros_wrapper" # <----- just added
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

## 2.3 [The Branching Strategy] How to branch for modifications:
1. [Optional] Make sure the current 'workspace' and 'config' is clean, no local modifications:
   ```bash
   $ check_ws_status
   $ check_config_status
   ```

2. [Recommended] Makre sure the current 'workspace' and 'config' is the latest:
   ```bash
   $ sync_latest
   ```

3. Branch out your 'workspace':
   ```bash
   # cd:
   $ cd_ws
   
   # branching strategy:
   # [Main branch:] `waterloo_steel/universal/ros1/main`
   # [A common session branch: ]
   $ git checkout -b universal/{node}/session-{month}-{year}
   # OR:
   # [A user defined sub-feature branch, derived from a specific session branch: ]
   $ git checkout -b {node}/session-{month}-{year}/{feature}
   # OR:
   # [A general user defined branch: ]
   $ git checkout -b usr/{name}/{node}/{feature}
   
   ### NOTE:
   # {node}: ros1, ros1/robohub, main, checkpoint, ...
   # {feature}: demo, fix, fix-numerical-err, ...
   ```

4. [Optional] Publish your 'workspace':
   ```bash
   $ cd_ws
   $ git push -u origin {your-branch-name-defined-above}
   ```

5. Branch out your 'config':
   ```bash
   $ cd_config
   $ git checkout -b {your-branch-name-defined-above}
   ```

6. Targeting your config to the new branch:
   ```bash
   $ cd_config scripts
   $ vim common.sh
   
   # edit:
   2| #################################################################
   3| ## USER PARAM: ##
   4| export UWARL_catkin_ws_branch="{your-branch-name-defined-above}"
   ```

7. [Optional] Publish your 'config':
   ```bash
   $ cd_config
   $ git push -u origin {your-branch-name-defined-above}
   ```

8. Branching submodules:
   ```bash
   $ cd_ws
   $ cd {a-specific-submodule}
   # Branching: (if this is a continuous development, major:)
   $ git checkout -b usr/{name}/{node}/{feature}
   # OR: (if this is a minor feature or fixes, minor:)
   $ git checkout -b {your-branch-name-defined-above}
   ```
   
9.  Modify and Publish changes of your submodules:
   ```bash
   # Commit:
   $ git commit 
   
   # Publish:
   $ git push -u origin {...}
   ```
   
10. Publish All Your Changes as A Checkpoint in Workspace:
   ```bash
   $ commit_ws
   ```

## 2.4 Rebasing Branches:
> :warning: It is recommended to rebase your branch to the latest version of your target branch, that you branched off. So we can resolve MERGE CONFLICTS locally, and pick up latest changes.

**On your local machine:**
1. Make sure you do not have any changes:
   ```bash
   # [1] basic:
   $ cd {git-folder}
   $ git status
   
   # [2] Workspace with submodules:
   $ check_ws_status
   
   # [3] Config:
   $ check_config_status
   
   # [4] Folder contains submodules:
   $ cd {git-folder}
   $ check_status
   ```
2. Check out the main branch:
   ```bash
   $ checkout {main}
   # Ex:
   $ checkout waterloo_steel/universal/ros1/main
   ```
3. Pull the latest:
   ```bash
   # dry run:
   $ git fetch
   # update the local to the latest from the origin (remote):
   $ git pull
   ```
4. Checkout the original branch:
   ```bash
   $ git checkout -
   ```
5. Rebase:
   ```bash
   # [Opt. 1]: just rebase directly
   $ git rebase {main}
   
   # [Opt. 2]: interactive rebase, if you need to squash some of the commits
   $ git rebase -i {main}
   ```
6. [* if Merge Conflicts]:
   1. You have to resolve it in Editor (VSCode)
   2. Once, you are done: `$ git rebase --continue`
   3. Iterating, till completion.
7. Publish your changes:
   ```bash
   $ git push -f # brutal force is needed, as the tree root has been updated
   ```

## 2.5 Merging Your Branch:
1. Pre-requisite: Rebasing Branches to Main (first) --> [2.4 Rebasing Branches:](#24-Rebasing-Branches)
2. On GitHub Interface, Create a [PULL REQUEST], assigning reviewers and tags.
3. Merge, once review is completed.

# 3. ROS UWARL_catkin_ws Usage Guide:

## 3.1 Modifications:

1. switch workspace : `git checkout {branch-name}`
2. add modules: `$ git submodule add {git-repo}`
3. remove submodules: `$ git submodule deinit {git-repo}` and you may need delete the submodules in `.gitmodules` file
4. Create a new branch of workspace: `git checkout -b universal/{node}/{feature}`

## 3.2 Commit and Push:

1. Commit all changes under submodules
2. Make sure you run this: `$ ./git-status-all.sh` to log all status into `git-status-all.log`
3. commit all current workspace changes: `$ git add . && git commit -a`
4. Push workspace `$ git push` or upload a branch `$ git push -u {your-branch-name}`

## 3.3 Pull latest repo:

```bash
$ cd_ws/src && git status # make sure no local changes
$ update_ws
```

## 3.4 Restart over the catkin workspace:

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

## 3.5 Shortcuts:
```bash
# sync all toolchain and workspace:
$ sync_latest
```
### 3.5.1 Short for ROS workspace:
```bash
### ROS Workspace Specific:
## Note: you may add optional arguments afterwards.
# cd into workspace from anywhere
$ cd_ws
# update (pull recursively in a batch) of the entire workspace with all required submodules (as noted in common.sh) from anywhere
$ update_ws
# clean ws from anywhere (build files from catkin-build)
$ clean_ws
# build ws from anywhere (w/ catkin-build)
$ build_ws
# source 'ws/devel/.zsh' from anywhere
$ source_ws
# source ~/.zshrc from anywhere and then source 'ws/devel/.zsh'
$ source_all
```

### 3.5.2 Short for OS Env.:
```bash
# source ~/.zshrc from anywhere
$ source_zsh

# open directory:
$ open . 
# open file:
$ open [file-name]
```

### 3.5.3 Short for UWARL_catkin_ws/src Commit:
```bash
# cd into workspace from anywhere
$ cd_ws
# check wworkspace status from anywhere
$ check_ws_status
# commit the current workspace milestone:
$ commit_ws
```
### 3.5.4 Short for Robot Config Toolchain:
```bash
# cd into robot_configs from anywhere
$ cd_config
# check robot_configs from anywhere
$ check_config_status
# source ~/.zshrc from anywhere and then source 'ws/devel/.zsh'
$ source_all
# update the workspace with toolchain
$ update_ws

# cd into installation libraries by configs toolchain:
$ cd_linux
```

### 3.5.5 Shorts for Git (Pretty) 
```bash
## Git History:
# pretty compact git log tree:
$ git_log
# ...  and include line changes:
$ git_log -p

## Git Status Recursive:
# check status of the directory and its submodules if any.
$ check_status 
$ check_status [some-subdirectory]
```

### 3.5.6 Short Generation Tool for Markdown .md files:
```bash
# auto-gen Table of Contents for a specific markdown file
$ md_toc README.md 
# auto-gen Table of Contents for a specific directory containing all markdown files
$ md_toc_dir docs
# auto-gen ToC for MODIFIED Changes Only based on git status
$ md_toc_dir git
```

### 3.5.7 Short for Tmux Multi-pane Session:
```bash
# start tmux session:
$ tmux 
# start tmux session with multiple panes:
$ tmux_multi            # 2 panes
$ tmux_multi 4          # 4 panes
# auto-init multiple commands inseparate terminal panes inside one tmux session
$ tmux_sync [session_name] [cmd_1] ... 

# detach session to background of OS:
$ tmux detach
# list available sessions
$ tmux ls
# reatach
$ tmux a

# [winin tmux session] apply custom configurations:
$ tmux_src # see configuration file from `uwarl-robot_configs/desktop/tmux.conf`

# kill all session:
$ tmux_kill
```
- Example of bash automation launching multiple programs iterating through rosbags: `waterloo_steel/waterloo_steel_demo/waterloo_steel_analyzer/shortcuts/batch_tmux_vins.sh`

#### 3.5.7.a) tmux configuration file:
1. [CMD + B] + [SHIFT + |] : vertical split
2. [CMD + B] + [SHIFT + -] : horizontal split
3. [Alt + Arrow Key] : traverse pane without prefix keys ~~[CMD + B]~~
4. [CMD + B] + u : capture pane: to show a menu of URLS to open
5. [CMD + B] + c : new window
6. [CMD + B] + p : previous window
7. Mouse is on, history limit: [5000]

### 3.5.8 SUMMIT Systemctl Service:
```bash
## Automated Instruction [May 24, 2023]:
# modify summitxl_params.env, and update env with:
$ source_all 

### How to build and install summit workspace:
# 1. build:
$ build_ws
# 2. stop system:
$ summit_systemctl stop
$ summit_systemctl status
# 3. source
$ source_all
# 4. reinstall service
$ summit_systemctl reinstall
# 5. start new system:
$ summit_systemctl start
$ summit_systemctl status
# check status:
$ summit_systemctl status
# now, it will autolaunch the summit in the backend.

### For any other workspace, please use similar idea based on the given scripts for summit workspace.
```

### 3.5.9 JETSON Service:
```bash
## Jetson info:
jetson_info

## Restart Udev:
restart_udev
```

### 3.5.10 Debug and Profiling in ROS
1. build with debug: 
   ```bash
   $ build_ws_debug 
   # OR:
   $ build_ws --cmake-args -DCMAKE_BUILD_TYPE=Debug
   ```
2. rosrun with valgrind
   ```bash
      # normal program run:
      $ rosrun vins vins_node $cam_config_file_path

      # run with valgrind:
      $ rosrun_valgrind vins vins_node $cam_config_file_path

      # -> check error causing memory dump:
      $ cat $HOME/valgrind_log.txt
      ##### OUTPUT:
      # ==134393== Memcheck, a memory error detector
      # ==134393== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
      # ==134393== Using Valgrind-3.15.0 and LibVEX; rerun with -h for copyright info
      # ==134393== Command: /home/parallels/UWARL_catkin_ws/devel/lib/vins/vins_node /home/parallels/UWARL_catkin_ws/src/vins-research-pkg/VINS-Fusion/config/uwarl_d455/mono_rgb_imu_config_dual.yaml
      # ==134393== Parent PID: 134030
      # ==134393==
      # ==134393== Thread 7:
      # ==134393== Invalid read of size 8
      # ==134393==    at 0x4936B20: shared_count (shared_count.hpp:433)
      # ==134393==    by 0x4936B20: shared_ptr (shared_ptr.hpp:422)
      # ==134393==    by 0x4936B20: FeatureTracker::trackImage(double, cv::Mat const&, cv::Mat const&) (feature_tracker.cpp:199)
      # ==134393==    by 0x48B184B: Estimator::inputImage(double, cv::Mat const&, cv::Mat const&) (estimator.cpp:167)
      # ==134393==    by 0x19BCAB: sync_process() (rosNodeTest.cpp:126)
      # ==134393==    by 0x56B2FAB: ??? (in /usr/lib/aarch64-linux-gnu/libstdc++.so.6.0.28)
      # ==134393==    by 0x4E72623: start_thread (pthread_create.c:477)
      # ==134393==    by 0x596B49B: thread_start (clone.S:78)
      # ==134393==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
      # ==134393==
   ```
### 3.5.11 ROS Console Logging Level (An easy way):
- **Step 2.ii [OPTIONAL]** under wiki page: https://github.com/UW-Advanced-Robotics-Lab/lab-wiki/wiki/Waterloo-Steel%3APlatform-Workstation-Setup#143-hot_pepper-register-your-pc-in-commonh

# 4. Tools:
## 4.1 Remote Desktop Auto-Sleep and Auto-Wake Scheduling:

```bash
$ sudo cp ~/uwarl-robot_configs/desktop/suspend_until $HOME
# Takes a 24hour time HH:MM as its argument
# Example:
#
$ suspend_until 9:30
#     suspend_until 18:45
#
# You can create a root cron job that calls this script to execute at a
# specific time in the evening and then awake in the morning:
#
$ sudo crontab -e
#
# Now enter something like to run the suspend script at 23:30:
#
30 23 * * * /home/myhomefolder/suspend_until 07:30 
```

## 4.2 Remote Desktop without physical monitor (Headless Monitor):
```bash
$ sudo apt-get install xserver-xorg-video-dummy -y 
$ sudo cp ~/uwarl-robot_configs/desktop/etc/X11/xorg.conf /etc/X11/xorg.conf
```

# A. Appendix:

## A.1 File Tree:

```bash
# lastly modified by Jack [Nov. 25, 2022] @[#6c20a3]
.
.
├── docs                                              # [documents]
│   └── media                                              # : media folders
│       └── zshrc_terminal_output_dec_01_2022.png
├── README.md                                              # : instructions
├── scripts                                           # [bash scripts]
│   ├── auto-config_UWARL_catkin_ws.zsh                    # : auto-install `UWARL_catkin_ws`
│   ├── auto-install_xrdp_screen.sh                        # : install xrdp screen
│   ├── common.sh                                          # : common configurations
│   ├── git_functions.sh                                   # : some bash functions
│   └── shortcuts.sh                                       # : aliased shortcuts
├── summit                                            # [summit specific]
│   ├── install_geographiclib_datasets.sh                  # : a necessary script to config summit
│   ├── rgbd_summit.rviz                                   # : rviz [ARCHIVED]
│   ├── ros-melodic-robotnik-msgs_2.2.0-0bionic_amd64.deb  # : a custom built deb package for melodic summit hardware
│   ├── summitxl_params.env                                # : summit parameters
│   └── user_services                                      # [user system services]
│       ├── environment                                         # : `./ros/environment` to configure ros namespace at the boot (for auto-launching services)
│       ├── README.md                                           # : Guide
│       ├── roscorelaunch@.service                              # : create `roscore + launch` systemctl service
│       ├── roscore.service                                     # : create `roscore` systemctl service
│       └── roslaunch@.service                                  # : create `roslaunch` systemctl service
└── wam                                               # [wam specific]
    └── barrett.zip                                        # : a zip copy of barrett config       
```

## A.2 ZSHRC Terminal Output After Installing:
![Terminal Output Figure](./docs/media/zshrc_terminal_output_dec_26_2022.png)

## A.3 Environment Configurations:

### A.3.1 summitxl_params.env

Robot Configuration Description:

```
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
```











<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>