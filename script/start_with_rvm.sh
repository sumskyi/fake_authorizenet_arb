#!/bin/bash

export HOME=/home/vlad
export PATH=/home/vlad/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib64/jvm/jre/bin:/home/vlad/.rvm/bin:/home/vlad/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

`cd /home/vlad/public_html/fake_authorize_net && script/rails s -p 40776`

