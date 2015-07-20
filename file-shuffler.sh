#! /bin/bash

# This script temporarily moves each item in a directory first to another
# directory, then back, before moving on to the next item. An item may be a
# file a subdirectory. Useful in case you forgot to turn on compression for a
# zpool, but now need to re-write that data to the pool so you need to shuffle
# it off and shuffle it right back on. If you have more data than fits into
# your temporary storage directory, this will do it in smaller pieces for you.
# Ideally, run this with screen. Possible future possibilities include
# accepting the two paths below as arguments and copy, delete, copy back,
# delete (as opposed to move, move).

# Set SOURCEDIR to be the directory of files you want to move
SOURCEDIR="/path/to/files/to/be/shuffled/"
# Set TEMPDIR to be the directory you want to temporarily move each file to
# before moving it back to SOURCEDIR
TEMPDIR="/some/other/place/"

###

# spaces in paths are a problem, so for reasons I don't fully understand, set
# the internal field seperator to newlines only -- is there a better way?

IFS=$'\n'

counter=0

for item in $SOURCEDIR*; do
    counter=$((counter+1))
done

echo $SOURCEDIR has $counter items
total=$counter

counter=1

for item in $SOURCEDIR*; do
    echo XXXXX $counter outta $total
    echo ..... $item
    echo ..... moving to temp ...
    mv "$item" "$TEMPDIR"
    echo ..... moving back to where it came from ...
    # find the path to the item in temp by swapping the paths in the dir vars
    tempitem=${item/$SOURCEDIR/$TEMPDIR}
    mv "$tempitem" "$SOURCEDIR"
    echo ..... finished with this one.
    counter=$((counter+1))
done
