#!/bin/bash

LOCAL_COMMIT_ID=$(git rev-parse --short HEAD)  

echo "███████╗██╗   ██╗███╗   ██╗██╗  ██╗███████╗██╗   ██╗    ████████╗ ██╗ ██╗██████╗ "
echo "██╔════╝██║   ██║████╗  ██║██║ ██╔╝██╔════╝╚██╗ ██╔╝    ╚══██╔══╝███║███║╚════██╗"
echo "█████╗  ██║   ██║██╔██╗ ██║█████╔╝ █████╗   ╚████╔╝        ██║   ╚██║╚██║ █████╔╝"
echo "██╔══╝  ██║   ██║██║╚██╗██║██╔═██╗ ██╔══╝    ╚██╔╝         ██║    ██║ ██║ ╚═══██╗"
echo "██║     ╚██████╔╝██║ ╚████║██║  ██╗███████╗   ██║          ██║    ██║ ██║██████╔╝"
echo "╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝   ╚═╝          ╚═╝    ╚═╝ ╚═╝╚═════╝ "
echo -e "Commit:      $LOCAL_COMMIT_ID\n"


if [ ! -d "Buildroot-YuzukiSBC/FunKey/" ];then
    echo "Copy FunKey File"
    cp -rf ExtBuild/* Buildroot-YuzukiSBC/
else
    echo "FunKey File Exist"
fi
echo "Set Develop Env"
# For develop
export SOURCE_PATH=$(pwd)
export FunKey_PATH=$SOURCE_PATH/FunKey
# Add alias 
alias croot="cd $FunKey_PATH"
alias cconfig="cd $FunKey_PATH/configs"
alias cout="cd $FunKey_PATH/output"
alias cplat="cd $FunKey_PATH/board/funkey_t113"
cd Buildroot-YuzukiSBC
