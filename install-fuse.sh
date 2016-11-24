#!/bin/bash

echo "Collecting fuse 2.9.7"
wget https://github.com/libfuse/libfuse/releases/download/fuse-2.9.7/fuse-2.9.7.tar.gz
tar -xvzf fuse-2.9.7.tar.gz
cd fuse-2.9.7
echo "Installing fuse"
./configure
make -j8
sudo make install
echo "fuse installation completed"
exit 0
