#!/bin/bash

GROUP=ncoadmin
USER=netcool
LOG=/tmp/after-install.log
BASEDIR=/opt/viasat/deployments/makefile_lib/products


#run installer as root
echo "Installing OMNIBus"
make -f $BASEDIR/omnibus_core_8_1_0_19.mk install PATH_MAKEFILE_MEDIA=/opt/viasat/ibmrepo > $LOG
sleep 3
rm -rf /opt/viasat/deployments
