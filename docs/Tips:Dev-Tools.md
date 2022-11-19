<toc>

# Table of Contents
[*Last generated: Fri 18 Nov 2022 20:12:57 EST*]
- [**Git:**](#Git)
  - [A better Git Graph:](#A-better-Git-Graph)
- [**Linux:**](#Linux)
  - [Docker:](#Docker)
  - [Environment container comparison:](#Environment-container-comparison)


</toc>

---
# Git:

- For introduction, please read [[Documentation/Coding-Guidelines.md]](./Documentation:Coding-Guidelines.md)

## A better Git Graph:

```bash
$ git config --global alias.lg "log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate=full"

# >>>> Better than `$ git log`:
### Now, you can use:
$ git lg 
### OR, with line changes:
$ git lg -p
```

# Linux:

1. `$ uname -r`: OS check 
2. `$ cat /prov/version_signature`: identify kernel
3. `$ arp -a` : Scan Local Network Devices and IPs
4. `$ tree -L 1`: list hierarchy of directory in depth=1

## Docker:

- containerizing application with all dependencies without users to manually setup the environment
- available in all OS
- encapsulates the entire OS, so you can swap out the entire OS

- DOC: https://docs.docker.com/engine/

## Environment container comparison:

| Tool Name | Intro | Pro | Con|
|:-:|:-:|:-:|:-:|
| Docker | encapsulate OS environment | run the same OS on different OS platform | Huge |
| pyenv | python version manager | - | - |
| virtualenv | to encapsulate python dependencies | switching different python with different python packages with an ease | stuck with host OS |
| Anaconda | to maintain python virtualenv + additional sci-lib | Easier to work with | large packages |
| Vagrant | to provision a machine with an OS | Offer higher degree of isolation than Docker, and runs as isolated processes within the host OS | Heavier, larger and longer time to build |

> :notebook: [Isolation Level]: pyenv < virtualenv <= Anaconda < Docker < Vagrant 