#!/bin/bash - 
#===============================================================================
#
#          FILE: buildQtWorkSpace.sh
# 
#         USAGE: ./buildQtWorkSpace.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: ywolf (), Lingfeng.hu@nokia-sbell.com
#  ORGANIZATION: nsn
#       CREATED: 11/13/2017 12:47
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

rsync -arvz linhu@10.131.138.167:/cplane/linhu/trunk/ --exclude-from 'cplaneExcludeFileList.txt' ./trunk/

