#!/bin/bash

cd out
git init
git branch -m main
git add .
git commit -m "new deployment"
git push -f --set-upstream git@github.com:sbaldasty/sbaldasty.github.io.git main
rm -rf .git