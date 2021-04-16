#!/bin/bash

LOG=/tmp/nms_uninstall.log
BASEDIR=/opt/viasat/deployments/makefile_lib

#Determine System Role
SYSTEM_HOSTNAME=`hostname | cut -d"." -f1`
SYSTEM_ROLE=`cat ${BASEDIR}/utils/hostmanifest | grep ${SYSTEM_HOSTNAME} | cut -f2`
PA_NAME=`cat ${BASEDIR}/utils/hostmanifest | grep ${SYSTEM_HOSTNAME} | cut -f4` 
echo "System Role is ${SYSTEM_ROLE}.  PA_NAME is ${PA_NAME}"


#run installer as root
echo "Un-installing Netcool Omnibus"
make -f $BASEDIR/products/omnibus_core_8_1_0_19.mk uninstall PATH_MAKEFILE_MEDIA=/opt/viasat/nms/ibm/software NETCOOL_PA_NAME=${PA_NAME} > $LOG
