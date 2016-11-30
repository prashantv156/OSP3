#!/bin/bash
#Script to test KVFS

printf "\nIn run test script"

ROOT="$HOME/root/"
MOUNT="/mnt/mount"

df
printf "\n"
printf "Clearing all files"
rm -rf $ROOT/*

printf "\nMaking directories"
mkdir $MOUNT/testdir1
mkdir $MOUNT/testdir2
mkdir $MOUNT/testdir3
mkdir $MOUNT/testdir4
mkdir $MOUNT/testdir5

mkdir $MOUNT/testdir1/test
mkdir $MOUNT/testdir3/test3/
mkdir $MOUNT/testdir4/test
mkdir $MOUNT/testdir4/test/test2

printf "\nCalling ls\n"
ls -all /mnt/
#ls -all $MOUNT/
printf "\n------------------------------\n"
ls -all $MOUNT/testdir4/test

printf "\nRemove dir\n"
rmdir $MOUNT/testdir5
cd $MOUNT/testdir5

printf "\nWriting to files\n"
cd $MOUNT/testdir1
printf "Test file 1\n" > temp1.txt
printf "Test file 2\n" > temp2.txt
cat temp1.txt
cat temp2.txt

printf "\nDeleting file\n"
cd ..
rm -rf $MOUNT/testdir1/temp1.txt

printf "\nSymbolic link\n"
mkdir $MOUNT/link
ln -s $MOUNT/testdir1 $MOUNT/link
ln -s $MOUNT/testdir2 $MOUNT/link2
ln -s $MOUNT/testdir2 link3

printf "\nReadlink link\n"
readlink $MOUNT/link
printf "\nReadlink link2 \n"
readlink $MOUNT/link2
printf "\nReadlink testdir1\n"
readlink testdir1
printf "\nReadlink link3\n"
readlink link3

printf "\nHard link\n"
cd $MOUNT/testdir2
printf "Link file 1\n" > link1.txt
link link1.txt link2.txt
cat link2.txt

printf "\nchmod - Permission denied expected\n"
echo "Remove write permission" > $MOUNT/perm.txt
chmod -w $MOUNT/perm.txt
echo "Write again" > $MOUNT/perm.txt


