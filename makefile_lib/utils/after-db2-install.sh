#!/bin/bash

LOG=/tmp/after-install.log
BASEDIR=/opt/viasat/deployments/makefile_lib/products
chmod 775 /opt/viasat/deployments/makefile_lib/utils/chkversion

#run installer as root
echo "Installing DB2"
echo "Check $LOG for more info"
make -f $BASEDIR/db2_11_5.mk install PATH_MAKEFILE_MEDIA=/opt/viasat/ibmrepo > $LOG
sleep 3
rm -rf /opt/viasat/deployments
