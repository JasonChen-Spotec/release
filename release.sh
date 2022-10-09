#!/bin/bash
echo "发版版本: $1"

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

productNames=( 'All' 'Admin' 'Ib' 'Client' 'Ec-website' 'Mobile' )
list_input "请选择要发布的版本?" productNames selected_product

echo "发布项目: $selected_product"


releaseTmdAdmin(){
  cd /Users/jianchen/work/tmd/tmd-admin
  echo '开始tag项目: tmd-admin'
  pwd
  git pull origin dev
  yarn release $1
}

releaseTmdIB(){
  cd /Users/jianchen/work/tmd/tmd-IB-web
  echo '开始tag项目: tmd-IB-web'
  pwd
  git pull origin dev
  yarn release $1
}

releaseTmdPC(){
  cd /Users/jianchen/work/tmd/tmd-pc-web
  echo '开始tag项目: tmd-pc-web'
  pwd
  git pull origin dev
  yarn release $1
}

releaseEcWebsite(){
  cd /Users/jianchen/work/tmd/ec-website
  echo '开始tag项目: ec-website'
  pwd
  git pull origin dev
  yarn release $1
}

releaseMobile(){
  cd /Users/jianchen/work/tmd/tmd-mobile-next
  echo '开始tag项目: tmd-mobile-next'
  pwd
  git pull origin dev
  yarn release $1
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

