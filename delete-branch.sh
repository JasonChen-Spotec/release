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
source $PARENT_DIR/release/shell-utils/text_input.sh

text_input "please entry delete branch name: " branch

echo "delete branch: $branch"

echo $PARENT_DIR

deleteBranchTmdAdmin(){
  cd $PARENT_DIR/tmd-admin

  echo '开始delete branch项目: tmd-admin'
  pwd
  git ps origin --delete $branch
}

deleteBranchTmdIB(){
  cd $PARENT_DIR/tmd-IB-web
  echo '开始delete branch项目: tmd-IB-web'
  pwd
  git ps origin --delete $branch
}

deleteBranchTmdPC(){
  cd $PARENT_DIR/tmd-pc-web
  echo '开始delete branch项目: tmd-pc-web'
  git ps origin --delete $branch
}

deleteBranchEcWebsite(){
  cd $PARENT_DIR/ec-website
  echo '开始delete branch项目: ec-website'
  pwd
  git ps origin --delete $branch
}

deleteBranchMobile(){
  cd $PARENT_DIR/tmd-mobile-next
  echo '开始delete branch项目: tmd-mobile-next'
  pwd
  git ps origin --delete $branch
}


if [[ $branch =~ ^ec-release-[1-9]{1}.[0-9]{1}.x$ ]]
then
  deleteBranchTmdAdmin
  deleteBranchTmdIB
  deleteBranchTmdPC
  deleteBranchEcWebsite
  deleteBranchMobile
else
echo '分支名不符合要求, 请使用^ec-release-[1-9]{1}.[1-9]{1}.x$ 格式'
fi


