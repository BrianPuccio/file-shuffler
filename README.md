# file-shuffler

This script temporarily moves each item in a directory first to another directory, then back, before moving on to the next item. An item may be a file a subdirectory. Useful in case you forgot to turn on compression for a zpool, but now need to re-write that data to the pool so you need to shuffle it off and shuffle it right back on. If you have more data than fits into your temporary storage directory, this will do it in smaller pieces for you. Ideally, run this with screen.

Possible future possibilities include accepting the two paths below as arguments and copy, delete, copy back, delete (as opposed to move, move).
