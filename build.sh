#!/bin/bash
echo "[0/5] Preparing Building!"
if [ ! -d build ]; then
mkdir build
fi
timeinitiated=$(date +%s)
buildnumber=$(date +%s)
srcdir=$(pwd)/src
builddir=$(pwd)/build
devTooldir=$(pwd)/devTool
tmpDir=$(pwd)/tmpbuild
mainrepodir=$(pwd) #set the main repository directory to make sure that when we do cd operation we can go back using this variable
if [ ! -f ${mainrepodir}/devTool/staticTemplate/expandStatic ]; then
echo "Did you import the repo partially? I cant seems to find the expandStatic Template!"
exit
fi
rm -rf ${tmpDir}
mkdir ${tmpDir}

cd ${srcdir}
echo "[1/5] Compiling localrepo into rootfsprootRepoCache"
cd ${srcdir}/localrepo
rm -rf rootfsprootRepoCache
tar czf ../rootfsprootRepoCache *
echo "[2/5] Copying into the temporary assembly folder"
mkdir ${tmpDir}/mainProgram
cp -r ${srcdir}/* ${tmpDir}/mainProgram
echo "[3/5] Compiling Program!"
cd ${tmpDir}/mainProgram
rm -rf ${tmpDir}/mainProgram/localrepo
tar -czf ../bin *
cd ${tmpDir}
rm -rf ${tmpDir}/mainProgram
echo "[4/5] Creating SSA!"
SSAFileTarget="UnifiedContainer_${buildnumber}"
touch ${SSAFileTarget}
cat ${mainrepodir}/devTool/staticTemplate/expandStatic > ${SSAFileTarget}
md5sum bin >> ${SSAFileTarget} 2>&1 # Do not include the ${tmpDir} to make sure it doesn't record the dir which broke the md5sum logic
cat ${tmpDir}/bin >> ${SSAFileTarget}
chmod +x ${SSAFileTarget}
echo "[5/5] Finalizing and Cleaning up"
cp ${SSAFileTarget} ${builddir}
rm -rf ${tmpDir}
timefinished=$(date +%s)
timeittook=$(( ${timefinished} - ${timeinitiated} ))
echo "done! Built in ${timeittook} Seconds"
