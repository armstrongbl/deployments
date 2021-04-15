#!/bin/bash

LOG=/tmp/after-install.log
BASEDIR=/opt/viasat/deployments/makefile_lib/products

#run installer as root
echo "Installing DB2"
echo "Check $LOG for more info"
make -f $BASEDIR/db2_11_5.mk install PATH_MAKEFILE_MEDIA=/opt/viasat/nms/ibm/software > $LOG
