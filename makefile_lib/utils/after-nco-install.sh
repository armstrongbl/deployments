#!/bin/bash

LOG=/tmp/after-install.log
BASEDIR=/opt/viasat/deployments/makefile_lib/

#Determine System Role
SYSTEM_HOSTNAME=`hostname | cut -d"." -f1`
SYSTEM_ROLE=`cat ${BASEDIR}/utils/hostmanifest | grep ${SYSTEM_HOSTNAME} | cut -f2`
echo "System Role is ${SYSTEM_ROLE}"


#run installer as root
echo "Installing Netcool Omnibus"
echo "Check $LOG for more info"
##make -f $BASEDIR/prducts/omnibus_core_8_1_0_19.mk install PATH_MAKEFILE_MEDIA=/opt/viasat/nms/ibm/software > $LOG
