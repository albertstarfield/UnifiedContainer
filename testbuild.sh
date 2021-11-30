#!/bin/bash
#super simplistic testbuild automation
rm -rf build/*
bash build.sh
rm -rf testenv
mkdir testenv
cp build/UnifiedContainer_* testenv
cd testenv
mv UnifiedContainer_* UnifiedContainer
./UnifiedContainer