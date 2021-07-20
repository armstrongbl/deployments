#!/bin/bash

GROUP=ncoadmin
USER=netcool
LOG=/tmp/after-install.log
BASEDIR=/opt/viasat/deployments/makefile_lib/products
chmod 775 /opt/viasat/deployments/makefile_lib/utils/chkversion

#run installer as root
echo "Installing ITNM"
make -f $BASEDIR/itnm_core_4.2.mk install PATH_MAKEFILE_MEDIA=/opt/viasat/nms/ibmrepo > $LOG
sleep 3
rm -rf /opt/viasat/deployments
