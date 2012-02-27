#!/bin/sh
#
# This command is used to run puppet, based on the hostname 
/usr/bin/puppet apply --modulepath="`pwd`/modules" -v `hostname`.pp
