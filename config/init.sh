#!/bin/bash
set -ex

cd ~

TMP_DIR=`mktemp -d --suffix=-home`

# すべてのファイルを一時的に退避
sudo mv * .[^\.]* $TMP_DIR

git clone --depth 1 https://github.com/keisuke123/ISUCON7-qual-20180704.git ~/

# 退避したファイルを戻す
sudo cp -r $TMP_DIR/* $TMP_DIR/.[^\.]* ~/

# 以下は怖いのでコメントアウトしておきます
# 必要なところだけ使ってください。
: <<'#__COMMENT__'

# /etc/nginx/nginx.conf のシンボリックリンク
if [ ! -e ~/config/nginx.conf ]; then
  sudo cp /etc/nginx/nginx.conf ~/config/nginx.conf
  sudo mv /etc/nginx/nginx.conf /tmp # 念の為 /tmp に移動
fi
sudo ln -s ~/config/nginx.conf /etc/nginx/nginx.conf

# /etc/mysql/ のシンボリックリンク
if [ ! -e ~/config/mysql ]; then
  sudo cp -r /etc/mysql ~/config
  sudo mv /etc/mysql /tmp # 念の為 /tmp に移動
fi
sudo ln -s ~/config/mysql /etc/mysql

# git にすべてのファイルを追加
#git add -A
#git commit -m "Initial commit"
#git push -u origin master

#__COMMENT__

cd ~/config

./install.sh

make restart
