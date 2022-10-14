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

source $PARENT_DIR/release/shell-utils/checkbox_input.sh

productNames=( 'All' 'Admin' 'Ib' 'Client' 'Ec-website' 'Mobile' )
checkbox_input "Which hawker centres do you prefer?" productNames selected_products

text_input "please entry release branch: " branch 'dev'

echo "release branch: $branch"

versions=( 'patch' 'minor' 'major' 'use release-it select')
list_input "Select increment (next version, major.minor.patch):" versions version

echo "发布项目:  $(join selected_products)  version: $version "


releaseProducts="$(join selected_products)"

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

if [[ $releaseProducts =~ "All" ]]
then
  releaseTmdAdmin
  releaseTmdIB
  releaseTmdPC
  releaseEcWebsite
  releaseMobile
else
  if [[ $releaseProducts =~ "Admin" ]]
  then
    echo "release Admin start"
    releaseTmdAdmin
  fi
  if [[ $releaseProducts =~ 'Ib' ]]
  then
    echo "release Ib start"
    releaseTmdIB
  fi
  if [[ $releaseProducts =~ 'Client' ]]
  then
    echo "release Client start"
    releaseTmdPC
  fi
  if [[ $releaseProducts =~ 'Ec-website' ]]
  then
    echo "release Ec-website start"
    releaseEcWebsite
  fi
  if [[ $releaseProducts =~ 'Mobile' ]]
  then
    echo "release Mobile start"
    releaseMobile
  fi
fi



