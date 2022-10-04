#!/bin/bash

# how many build jobs for make to use.
export MAKEFLAGS='-j12'

export LFS=/mnt/lfs

# name of lfs user 
export LFS_USER=lfs

# the name of your host machines user (not root)
export HOST_USER=tic
