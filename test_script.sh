#!/bin/bash

# NOTE: This script assumes you are running on a VCL machine, have already installed FUSE and OpenSSL, and compiled the code as described in the project description. Run this script from inside the src directory of your project.
# PASSING THESE TESTS DOES NOT GUARANTEE A PASSING GRADE ON THE PROJECT. This is simply to give you an idea of some potential tests to guide you in testing your own code. It is up to you to ensure you thoroughly test all of the functions you implemented.


# Setup directories
mkdir ~/kvfs_test
sudo mkdir /mnt/kvfs
sudo chown idmunje /mnt/kvfs/
export ROOTDIR=~/kvfs_test
export MOUNTDIR=/mnt/kvfs

# Run program
./kvfs $ROOTDIR $MOUNTDIR

# Test1 File Creation
touch $MOUNTDIR/hello.txt
filename=$(echo -n '/hello.txt' | md5sum)
if ls $MOUNTDIR | grep -q $filename; then
	echo File Creation: PASS
else
	echo File Creation: FAIL
fi

# Test2 Read/Write
cat kvfs.c > $MOUNTDIR/hello.txt
if diff -q kvfs.c $MOUNTDIR/hello.txt; then
	echo Read/Write: PASS
else
	echo Read/Write: FAIL
fi

# Test3 Change Directory
cd $MOUNTDIR
if pwd | grep -q $MOUNTDIR; then
	echo Change Directory: PASS
else
	echo Change Directory: FAIL
fi
cd $OLDPWD

# Test4 Stat
if stat $MOUNTDIR/hello.txt > /dev/null; then
	echo Stat: PASS
else
	echo Stat: FAIL
fi

# Test5 Filesystem Status
if df $MOUNTDIR > /dev/null; then
	echo Filesystem Status: PASS
else
	echo Filesystem Status: FAIL
fi

# Test6 Directory Creation
mkdir $MOUNTDIR/folder
filename=$(echo -n '/folder' | md5sum)
if ls $MOUNTDIR | grep -q $filename; then
	echo Directory Creation: PASS
else
	echo Directory Creation: FAIL
fi

# Test7 Directory Removal
rmdir $MOUNTDIR/folder
filename=$(echo -n '/folder' | md5sum)
if ls $MOUNTDIR | grep -q $filename; then
	echo Directory Removal: FAIL
else
	echo Directory Removal: PASS
fi

# Test8 chmod
chmod 744 $MOUNTDIR/hello.txt
if stat --printf="%a" $MOUNTDIR/hello.txt | grep -q 744; then
	echo chmod: PASS
else
	echo chmod: FAIL
fi

# Test9 Link
echo checking link in folder:
pwd
ln $MOUNTDIR/hello.txt $MOUNTDIR/hello.c
filename=$(echo -n '/hello.c' | md5sum)
if ls $MOUNTDIR | grep -q $filename; then
	echo Link: PASS
else
	echo Link: FAIL
fi

# Test10 Rename
mv $MOUNTDIR/hello.c $MOUNTDIR/bye.c
filename=$(echo -n '/bye.c' | md5sum)
if ls $MOUNTDIR | grep -q $filename; then
	echo Rename: PASS
else
	echo Rename: FAIL
fi

# Cleanup
fusermount -u $MOUNTDIR
rm $ROOTDIR/*
rmdir ~/kvfs_test
sudo rmdir /mnt/kvfs


