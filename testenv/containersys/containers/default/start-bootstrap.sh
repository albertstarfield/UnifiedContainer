#!/bin/bash
echo BOOTLOADER revision 027
containerID=$(cat containerID)
cd $(dirname $0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD







###############################ROOT MANAGER ##########################


if [ ${BLINDBOOT} == "1" ]; then
echo "WARNING THIS IS USING BAREBONE BLIND BOOTING METHOD!"
echo "YOUR PROGRAM WILL NOT WORK PROPERLY!"
command="chroot"
command+=" rootfs"
command+=" /bin/env -i"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" HOME=/root"
command+=" /bin/bash"
fi


if [ -f ${maindir}/NOPTRACE ] && [ ${BLINDBOOT} == "0" ] ; then
#chroot version
echo "[Progress] Sanitizing Mount points"
echo "system control fs"
mount --bind /dev rootfs/dev
mount --bind /proc rootfs/proc
mount --bind /sys rootfs/sys
echo "[Progress] system storage Cachemount"
mount --bind /mnt/g/Users/albertstarfield/Documents/QuestandachievementFolder/studio/Projects/UnifiedContainer/test/containersys/tmp/pacmanCache rootfs/InstallCache
echo "[Progress] manager storage Expose"
if [ -d /sdcard ] && [ -f grantStorage ]; then
mount --bind /sdcard rootfs/exposed"
fi
if [ -d /home ] && [ -f grantStorage ]; then
mount --bind /home rootfs/exposed"
fi
echo "[Progress] System Library Expose"
if [ -d /system ] && [ -f grantSystemLibrary ]; then
mount --bind /system rootfs/systemfs"
fi
if [ -d /usr/lib ] && [ -f grantSystemLibrary ]; then
mount --bind / rootfs/systemfs"
fi

echo "chrootdefine"
command="chroot"
command+=" rootfs"
command+=" /bin/env -i"
command+=" HOME=/root"
command+=" TERM=$TERM"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" LANG=C.UTF-8"
command+=" HOME=/root"
command+=" /bin/ash --login"
fi
if [ ! -f ${maindir}/NOPTRACE ]  && [ ${BLINDBOOT} == "0" ] ; then
  echo "prootdefine"
  #proot version
command="proot"
command+=" "
command+=" -0"
command+=" -r rootfs"
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
command+=" -b /mnt/g/Users/albertstarfield/Documents/QuestandachievementFolder/studio/Projects/UnifiedContainer/test/containersys/tmp/pacmanCache:rootfs/InstallCache"
command+=" -w /root"
command+=" /bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/ash --login"
fi

###################################ROOT MANAGER #######################################
echo "[Progress] Check Param"
com="$@"
echo "[Progress] Init check"
if [ "$2" == "/init" ]; then
echo a > boot
fi


echo EXEC
if [ -z "$1" ];then
    exec $command
else
    $command -c "$com"
fi
if [ "$2" == "/init" ]; then
rm boot
fi
#unmounting for non ptrace version
if [ -f ${maindir}/NOPTRACE ]; then
umount -lf rootfs/dev
umount -lf rootfs/sys
umount -lf rootfs/proc
umount -lf rootfs/InstallCache
if [ -f grantStorage ]; then
umount -lf rootfs/exposed
fi
fi
echo Removing container Bootup flag
rm svcID

