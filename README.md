![Screenshot](Graphic_Material/BannerLogo.png "logo")

[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/Questandachievement7Developer/UnifiedContainer) 
[![DISCORD](https://img.shields.io/badge/Chat-On%20Discord-738BD7.svg?style=for-the-badge)](https://discord.gg/krVd2b9)
![version](https://img.shields.io/badge/alpha-0.05-green)
# :computer: Unified Container :computer: 

> Project Bay or also known as Unified Container is a linux container manager Userspace proot backend that allows to create and share linux container in ease without any difficulty on creating one, Inspired from these programs <br>
[TermuxArch](https://github.com/SDRausty/TermuxArch) <br>
[MFDGaming Ubuntu](https://github.com/MFDGaming/ubuntu-in-termux) <br>
[Neo Oli Ubuntu](https://github.com/Neo-Oli/termux-ubuntu) <br>
[Multipass](https://github.com/canonical/multipass) <br>
[Docker](https://github.com/docker) <br>
## :white_check_mark: What its use and its advantages ?
1. It can be used for anything really build a desktop, do a portable sharable reasearch container etc
2. Its architechture is simple yet effective so system delivery is more efficient
3. Have less dependencies on daemons due to the nature of simplistic architechture
4. Faster error troubleshooting since you can simply flick reset switch for every container
5. Structured Workflow
##  :question: Where can it be installed?
### :gear: PTrace Capable Kernel machines
1. Termux ( Originally built for )
2. Ubuntu
3. Debian
4. Archlinux
5. Manjaro
6. CentOS
### :gear: NON PTRACE Machines
1. WSL Distro
2. ~~iSH ( iOS shell )~~ ( Doesnt work due to the missing instruction set  )
3. Darwin x86_64 (macOS) (UNTESTED!)

### :camera: Tech demo screenshot
> Using blender Container

![Screenshot](Graphic_Material/TermuxTechDemo.jpg "termux")
![Screenshot](Graphic_Material/ChromeTechDemo.jpg "chrome")



## :floppy_disk: How to install
```
1. git clone https://github.com/Questandachievement7Developer/UnifiedContainer .
2. chmod +x ./unifyServer 
3. ./unifyServer
```

## :battery: How to Get started
```
add Container $ ./unifyServer add <container name>
launchContainerService $ ./unifyServer launch <container name>
Import container $ ./unifyServer import "<git repo link>"
enter the container shell $ ./unifyServer shell <container name>

for further help do $ ./unifyServer help
```

## :heartpulse: How to share Container configuration?
For container configuration check this refrence
you can clone it and modify to get started quickly
| Container | Link | 
| ------- | ------ | 
|   importTest    |    :computer: [Repo container](https://github.com/Questandachievement7Developer/container_importExample)     |
| matrixcontainer | :computer: [Repo Container](https://github.com/Questandachievement7Developer/container_matrix)|
| empiresserver | :computer: [Repo Container](https://github.com/Questandachievement7Developer/containers_EmpiresandAllies) |

## :clipboard: Tested Systems

| Device | Status | 
| ------- | ------ | 
| Samsung Galaxy Tab S2  (Termux) (armv7l) | Manager runs but pacman return 404 | 
| Samsung Galaxy Note 8 (Termux) (aarch64) | Works really well |
| Asus X505Z Windows 10 Ubuntu WSL (x86_64) (NOPTRACE) | Works and crashed the whole system ( Because its windows ) |
| ASROCK DESKTOP Windows 10 Ubuntu WSL (x86_64) (NOPTRACE) | Works stable  |
| Asus A442UR  Windows 10 Ubuntu 18.04 WSL (Ubuntu 18.04) (NOPTRACE)      |  Works but crashes the system randomly |
| Samsung Galaxy A50 (aarch64) (Termux) | Works well |
| ASROCK Desktop Manjaro (x86_64) | Works Well |

## Feels confused about the installation setup or anything wanted to implemented in this version?
Feel free to contact to these: <br>
:email: questandachievement@gmail.com  <br>
Personal Discord Yuuta kun#5097 <br>
Our community discord [Discord group](https://discord.gg/krVd2b9)
> Don't hestitate to ask we will help you and we won't kill you if you ask so many questions xd
