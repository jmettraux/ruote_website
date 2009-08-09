#!/bin/bash

webby build

rsync -azv -e ssh \
  output/ \
  jmettraux@rubyforge.org:/var/www/gforge-projects/openwferu

# not deleting, old pages and japanese website are subsisting ...

