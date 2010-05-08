#!/bin/bash

webby build

rsync -azv -e ssh \
  --exclude "*.swp" \
  output/ \
  jmettraux@rubyforge.org:/var/www/gforge-projects/ruote

