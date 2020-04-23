#!/bin/bash

git config --global user.name "Docker builder" &&
git config --global user.email "docker-builder@myhamsterknowskungfu.meow" &&
cd /usr/src &&
/GetPatchAndCompileKernel.sh
