#!/bin/bash

VERSION=`date +"%Y-%m-%d"`
REPO="dynalite"
COGREPO="cogniac/${REPO}"
CODE_DIR=".CODEDIR"
BRANCH="master"
PRODUCTION=1  # production version includes git tags
KEEP=0  # push this container to docker repo? Default to upload

# Prepare code
rm -rf ${CODE_DIR}
mkdir -p ${CODE_DIR}

git_tags=''
topdir=$PWD

usage()
{
    echo "usage: deploy.sh [[-p] | [--production], [-s] | [--staging], [-k] | [--keep]]"
}


while [ "$1" != "" ];
do
    case $1 in
        -p | --production) PRODUCTION=1
                            echo "creating production build"
                            ;;
        -s | --staging) PRODUCTION=0
                            echo "creating non production build"
                            ;;
        -k | --keep) KEEP=1
                     echo "not pushing to docker repo"
                     ;;
        * )          usage
                     exit 1
    esac
    shift
done

echo "PRODUCTION=${PRODUCTION}"

dirs=("dynalite")
for item in ${dirs[*]}
do
    git clone --depth=1 --branch=$BRANCH git@github.com:Cogniac/${item}.git $CODE_DIR/${item}
    cd $CODE_DIR/${item}
    tag=`git log -1 --pretty=%h`
    echo ${item} ${tag}
    cd ${topdir}
done

echo $tag

docker build -t $COGREPO:$tag  .

if [ ${KEEP} -eq 0 ]; then
    docker push $COGREPO:$tags
fi
