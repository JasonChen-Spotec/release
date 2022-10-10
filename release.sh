#!/bin/bash
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

PARENT_DIR=$(dirname "$DIR")
source $PARENT_DIR/release/shell-utils/list_input.sh
source $PARENT_DIR/release/shell-utils/text_input.sh

text_input "please entry release branch: " branch 'dev'

echo "release branch: $branch"

productNames=( 'All' 'Admin' 'Ib' 'Client' 'Ec-website' 'Mobile' )
list_input "Please select product:" productNames selected_product

versions=( 'patch' 'minor' 'major' 'use release-it select')
list_input "Select increment (next version, major.minor.patch):" versions version

echo "发布项目: $selected_product  version: $version "

releaseTmdAdmin(){
  cd $PARENT_DIR/tmd-admin
  echo '开始tag项目: tmd-admin'
  pwd
  git checkout $branch
  git pull origin $branch
  if [ $version == 'other' ]
  then
    yarn release
  else
    yarn release $version
  fi
}

releaseTmdIB(){
  cd $PARENT_DIR/tmd-IB-web
  echo '开始tag项目: tmd-IB-web'
  pwd
  git checkout $branch
  git pull origin $branch
  if [ $version == 'other' ]
  then
    yarn release
  else
    yarn release $version
  fi
}

releaseTmdPC(){
  cd $PARENT_DIR/tmd-pc-web
  echo '开始tag项目: tmd-pc-web'
  pwd
  git checkout $branch
  git pull origin $branch
  if [ $version == 'other' ]
  then
    yarn release
  else
    yarn release $version
  fi
}

releaseEcWebsite(){
  cd $PARENT_DIR/ec-website
  echo '开始tag项目: ec-website'
  pwd
  git checkout $branch
  git pull origin $branch
  if [ $version == 'other' ]
  then
    yarn release
  else
    yarn release $version
  fi
}

releaseMobile(){
  cd $PARENT_DIR/tmd-mobile-next
  echo '开始tag项目: tmd-mobile-next'
  pwd
  git checkout $branch
  git pull origin $branch
  if [ $version == 'other' ]
  then
    yarn release
  else
    yarn release $version
  fi
}

if [ $selected_product == "Admin" ]
then
  releaseTmdAdmin
elif [ $selected_product == 'Ib' ]
then
  releaseTmdIB
elif [ $selected_product == 'Client' ]
then
  releaseTmdPC
elif [ $selected_product == 'Ec-website' ]
then
  releaseEcWebsite
elif [ $selected_product == 'Mobile' ]
then
  releaseMobile
else
  releaseTmdAdmin
  releaseTmdIB
  releaseTmdPC
  releaseEcWebsite
  releaseMobile
fi

