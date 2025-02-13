#!/usr/bin/env bash
PWD=`pwd`
docker build -f rebuildxtf.Dockerfile -t xtf-builder .
docker run -it --ulimit nofile=16384:16384 -v $PWD:/temp/xtf xtf-builder 
cp $PWD/WEB-INF/dist/xtf.jar $PWD/WEB-INF/lib/
