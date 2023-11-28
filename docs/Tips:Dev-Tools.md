<toc>

# Table of Contents
[*Last generated: Tue 28 Nov 2023 14:57:32 EST*]
- [**1. Git:**](#1-Git)
  - [1.1 A better Git Graph:](#11-A-better-Git-Graph)
- [**2. Linux:**](#2-Linux)
  - [2.1 Frequently Used:](#21-Frequently-Used)
  - [2.2 Docker:](#22-Docker)
  - [2.3 Environment container comparison:](#23-Environment-container-comparison)
  - [2.4 Network:](#24-Network)
    - [2.4.1 File Server - Samba](#241-File-Server-Samba)
      - [2.4.1.a Add network share folder](#241a-Add-network-share-folder)
      - [2.4.1.b Set User and password](#241b-Set-User-and-password)
    - [2.4.2 Network Firewalls:](#242-Network-Firewalls)
    - [2.4.3 Wake-On-LAN:](#243-Wake-On-LAN)

---
</toc>



# 1. Git:

- For introduction, please read [[Documentation/Coding-Guidelines.md]](./Documentation:Coding-Guidelines.md)

## 1.1 A better Git Graph:

- Now comes free with `uwarl_robot-config` , via `$ git_log`

```bash
$ git config --global alias.lg "log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate=full"

# >>>> Better than `$ git log`:
### Now, you can use:
$ git lg 
### OR, with line changes:
$ git lg -p
```

# 2. Linux:

## 2.1 Frequently Used:

1. `$ uname -r`: OS check 
2. `$ cat /prov/version_signature`: identify kernel
3. `$ arp -a` : Scan Local Network Devices and IPs
4. `$ tree -L 1`: list hierarchy of directory in depth=1

## 2.2 Docker:

- containerizing application with all dependencies without users to manually setup the environment
- available in all OS
- encapsulates the entire OS, so you can swap out the entire OS

- DOC: https://docs.docker.com/engine/

## 2.3 Environment container comparison:

| Tool Name | Intro | Pro | Con|
|:-:|:-:|:-:|:-:|
| Docker | encapsulate OS environment | run the same OS on different OS platform | Huge |
| pyenv | python version manager | - | - |
| virtualenv | to encapsulate python dependencies | switching different python with different python packages with an ease | stuck with host OS |
| Anaconda | to maintain python virtualenv + additional sci-lib | Easier to work with | large packages |
| Vagrant | to provision a machine with an OS | Offer higher degree of isolation than Docker, and runs as isolated processes within the host OS | Heavier, larger and longer time to build |

> :notebook: [Isolation Level]: pyenv < virtualenv <= Anaconda < Docker < Vagrant 

## 2.4 Network:

### 2.4.1 File Server - Samba

#### 2.4.1.a Add network share folder

- Add folders to network share:

```bash
$. sudo vim /etc/samba/smb.conf

## edit with:
[sambashare]
   comment = Samba on ubuntu
   path = /home/jx/samba_share
   read only = no
   browsable = yes
   guest ok = no

[vinsanalysis]
   comment = vins analysis results
   path = /home/jx/UWARL_catkin_ws/src/vins-research-pkg/research-project/output/vins_analysis
   read only = no
   browsable = yes
   guest ok = no
```

- restart service:

```bash
$ sudo systemctl restart smbd.service
```

#### 2.4.1.b Set User and password

```bash
$ sudo smbpasswd -a jx
```



### 2.4.2 Network Firewalls:

- check your network security:

```bash
$ sudo ufw status numbered  

### OUTPUT:
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 3389                       ALLOW IN    Anywhere
[ 2] 22                         ALLOW IN    Anywhere
[ 3] Samba                      ALLOW IN    Anywhere
...
```

- This is important to protect your Linux Desktop from malicious attack



### 2.4.3 Wake-On-LAN:

- Activate your PC to enable wake-on-lan feature
- Use `ifconfig` to find your network IP at ethernet port and its assigned MAC address
- evoke to wake from other PC: `$ wakeonlan -i 192.x.x.x xx:xx:xx:xx:xx:xx`











<eof>

---
[*> Back To Top <*](#Table-of-Contents)
</eof>