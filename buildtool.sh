#!/bin/bash
echo "[0/8] Preparing Building!"
if [ ! -d build ]; then
mkdir build
fi
buildnumber=$(date +%s)
mainrepodir=$(pwd) #set the main repository directory to make sure that when we do cd operation we can go back using this variable
if [ ! -f ${mainrepodir}/devTool/staticTemplate/expandStatic ]; then
echo "Did you import the repo partially? I cant seems to find the expandStatic Template!"
exit
fi
echo "[1/8] Compressing "