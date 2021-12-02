#!/bin/bash
export folder=rootfs #rootfs folder configuration

containerID=$(cat containerID)
cd $(dirname $0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD







###############################ROOT MANAGER ##########################


if [ ${BLINDBOOT} == "1" ]; then
echo "WARNING THIS IS USING BAREBONE BLIND BOOTING METHOD!"
echo "YOUR PROGRAM WILL NOT WORK PROPERLY!"
command="chroot"
command+=" ${folder}"
command+=" /bin/busybox env -i"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" HOME=/root"
command+=" /bin/ash"
fi


if [ -f ${maindir}/NOPTRACE ] && [ ${BLINDBOOT} == "0" ]  ; then
#chroot version
echo "Checking whether it is mounted or not"
currentContainerDir=$(pwd)
if [ ! -z $(mount | grep ${currentContainerDir}) ]; then # Make sure that the unifiedContainer wont do repeated Mount and Unmounting when there is an loop issues that can cause Destruction on iSH and brick it
echo "[Progress] Sanitizing Mount points"
echo "system control fs"
mount --bind /dev ${folder}/dev
mount --bind /proc ${folder}/proc
mount --bind /sys ${folder}/sys
echo "[Progress] system storage Cachemount"
mount --bind /mnt/c/tmp/UnifiedContainer/testenv/containersys/tmp/pacmanCache rootfs/InstallCache
echo "[Progress] manager storage Expose"
if [ -d /sdcard ] && [ -f grantStorage ]; then
mount --bind /sdcard ${folder}/exposed"
fi
if [ -d /home ] && [ -f grantStorage ]; then
mount --bind /home ${folder}/exposed"
fi
echo "[Progress] System Library Expose"
if [ -d /system ] && [ -f grantSystemLibrary ]; then
mount --bind /system ${folder}/systemfs"
fi
if [ -d /usr/lib ] && [ -f grantSystemLibrary ]; then
mount --bind / ${folder}/systemfs"
fi

fi

echo "chrootdefine"
command="chroot"
command+=" ${folder}"
command+=" /bin/busybox env -i"
command+=" HOME=/root"
command+=" TERM=$TERM"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" LANG=C.UTF-8"
command+=" HOME=/root"
command+=" /bin/ash"
fi
if [ ! -f ${maindir}/NOPTRACE ]  && [ ${BLINDBOOT} == "0" ] ; then
  echo "prootdefine"
  #proot version
command="proot"
command+=" -0"
command+=" ${symlinkfix}"
command+=" -r $folder"
if [ -n "$(ls -A binds)" ]; then
    for f in binds/* ;do
      . $f
    done
fi
command+=" -b /dev"
command+=" -b ${presistentStorage}/${containerID}:/presistent_storage"
if [ -d /sdcard ] && [ -f grantStorage ]; then
command+=" -b /sdcard:/exposed"
fi
if [ -d /home ] && [ -f grantStorage ]; then
  command+=" -b /home:/exposed"
fi
echo Exposing systemLib
if [ -d /system ] && [ -f grantSystemLibrary ]; then
  command+=" -b /system:/systemfs"
fi
if [ -d /usr/lib ] && [ -f grantSystemLibrary ]; then
  command+=" -b /:/systemfs"
fi
command+=" -b /proc"
## uncomment the following line to have access to the home directory of termux
#command+=" -b /data/data/com.termux/files/home:/root"
############ uncomment the following line to mount /sdcard directly to /
#command+=" -b /sdcard"
command+=" -b /mnt/c/tmp/UnifiedContainer/testenv/containersys/tmp/pacmanCache:${folder}/InstallCache"
command+=" -w /root"
command+=" -k UnifiedContainer-IsolationKernelLauncher-rev30"
command+=" /bin/busybox env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=$TERM"
command+=" LANG=C.UTF-8"
command+=" PS1=$(cat containerID)\$"
command+=" /bin/ash"
fi

###################################ROOT MANAGER #######################################
#echo "[Progress] Check Param"
com="$@"
#echo "[Progress] Init check"
if [ "$2" == "/init" ]; then
touch boot
fi


#echo EXEC
if [ -z "$1" ];then
    exec $command
else
    #We need to write a commandqueue to the rootfs then execute as script due to the ash from busybox doesnt intrepret additional parameter ex: "/bin/ash -c apk add a" the ash only recognize as  rather than $ apk add a command
    if [ -f ${maindir}/NOPTRACE ]; then
    echo "$command" "$com" 
    fi
    echo "$com" | tee ${folder}/manualcommandqueue
    chmod 777 ${folder}/manualcommandqueue
    $command -c "/manualcommandqueue" #execute the manual command queue
    rm ${folder}/manualcommandqueue # clean out the command queue afterwards
fi
if [ "$2" == "/init" ]; then
rm boot
fi
#unmounting for non ptrace version
if [ -f ${maindir}/NOPTRACE ]; then
#umount -lf ${folder}/dev
#umount -lf ${folder}/sys
#umount -lf ${folder}/proc
#umount -lf ${folder}/InstallCache
echo "unmount operations on non proot mode will be deprecated due to the potential to wreck the system"
if [ -f grantStorage ]; then
echo "unmount operations on non proot mode will be deprecated due to the potential to wreck the system"
#umount -lf ${folder}/exposed
fi
fi
echo Removing container Bootup flag
rm svcID

