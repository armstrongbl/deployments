################################################################################
#                       _
#                      / \   ___ ___ _   _  ___  ___ ___
#                     / _ \ / __/ __| | | |/ _ \/ __/ __|
#                    / ___ \ (_| (__| |_| | (_) \__ \__ \
#                   /_/   \_\___\___|\__,_|\___/|___/___/
# 
#                    Accurate Operational Support Systems
#              (c) 2015-2019 Accuoss, Inc. All rights reserved.
################################################################################
################################################################################
## ACCUOSS LIBERTY LICENSE ( ALL )                                            ##
## (c) 2015-2019 Accuoss, LLC. All rights reserved.                           ##
## Permission is hereby granted, free of charge, to any person obtaining a    ##
## copy of this software and associated documentation files (the "Software"), ##
## to deal in the Software without restriction, including without limitation  ##
## the rights to use, copy, modify, merge, publish, distribute, sublicense,   ##
## and/or sell copies of the Software, and to permit persons to whom the      ##
## Software is furnished to do so, subject to the following conditions:       ##
##                                                                            ##
## The above copyright notice and this permission notice shall be included in ##
## all copies or substantial portions of the Software.                        ##
##                                                                            ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    ##
## THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    ##
## FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        ##
## DEALINGS IN THE SOFTWARE.                                                  ##
################################################################################
#<<<<<<< HEAD
# IBM Jazz for Service Management 1.1.3.1
# IBM WebSphere Application Server V8.5.5.20
#=======

#>>>>>>> 4ca845fd8c2c74d02d79e0b16b312f184433e6a6
################################################################################
MAKE_FILE	:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
MAKE_DIR	:= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
################################################################################
# MAKE_FILE NAME, MUST BE BEFORE ANY OTHER MAKEFILE INCLUDES
################################################################################

include ${MAKE_DIR}../include/includes

# REDHAT VERSION CHECK MUST BE AFTER INCLUDES FOR CMD_GREP
REDHAT6_CHECK   :=$(shell $(CMD_GREP) -i "release 6" /etc/redhat-release)

################################################################################
# INSTALLATION TUNABLES
################################################################################
MAKE_PRODUCT			= JazzSM
MAKE_PRODUCT_PREREQS	= DSH,ODP

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL			:= /opt/IBM
PATH_INSTALL_JAZZSM		= $(PATH_INSTALL)/JazzSM
PATH_INSTALL_WEBSPHERE	= $(PATH_INSTALL)/WebSphere

PATH_INSTALL_JAZZSM_START = $(PATH_INSTALL_JAZZSM)/profile/bin/startServer.sh
PATH_INSTALL_JAZZSM_STOP = $(PATH_INSTALL_JAZZSM)/profile/bin/stopServer.sh
PATH_INSTALL_JAZZSM_STATUS = $(PATH_INSTALL_JAZZSM)/profile/bin/serverStatus.sh

################################################################################
# TEMPORARY MAKE DIRECTORY
################################################################################
PATH_TEMP_BASE		:= $(MAKE_PRODUCT).make
PATH_TEMP_TEMPLATE	:= $(PATH_TMP)/$(PATH_TEMP_BASE).XXXXXXXX
PATH_TEMP_DIR		:= $(shell $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null)

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_INSTALL	:= $(PATH_MAKEFILE_REPOSITORY)/jazzsm_1_1_3_was_8_5_5_15_install
PATH_REPOSITORY_UPGRADE := $(PATH_MAKEFILE_REPOSITORY)/jazzsm_1_1_3_was_8_5_5_20_upgrade

PATH_REPOSITORY_JAZZSM_EXT_PACKAGE=com.ibm.tivoli.tacct.psc.install.was85.extension_
PATH_REPOSITORY_JAZZSM_JVM_PACKAGE=com.ibm.websphere.IBMJAVA.v70_
PATH_REPOSITORY_JAZZSM_WAS_PACKAGE=com.ibm.websphere.BASE.v85_

PATH_MAKEFILE_UPGRADE_MEDIA=$(PATH_MAKEFILE_MEDIA)/WAS_Updates
################################################################################
# INSTALLATION USERS, SETTINGS AND PATHS
################################################################################
JAZZSM_USER			:= netcool
JAZZSM_PASSWD		:= $(JAZZSM_USER)
JAZZSM_GROUP		:= ncoadmin
JAZZSM_SHELL		:= /bin/bash
JAZZSM_HOME			:= $(PATH_HOME)/$(JAZZSM_USER)

JAZZSM_IMSHARED		:= $(JAZZSM_HOME)/$(PATH_IM_SHARED_PATH)
JAZZSM_CMD_IMCL		:= $(JAZZSM_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)
JAZZSM_CMD_IMUTILSC	:= $(JAZZSM_HOME)/$(PATH_IM_IMUTILSC_RELATIVE_PATH)
JAZZSM_USERINSTC        := $(PATH_REPOSITORY_INSTALL)/im.linux.x86_64/userinstc

JAZZSM_SOAP_PROPS	:= $(PATH_INSTALL_JAZZSM)/profile/properties/soap.client.props
JAZZSM_SOAP_SECURITY		:= com.ibm.SOAP.securityEnabled
JAZZSM_SOAP_SECURITY_V		:= true
JAZZSM_SOAP_USERID			:= com.ibm.SOAP.loginUserid
JAZZSM_SOAP_USERID_V		= $(WAS_JAZZSM_USER)
JAZZSM_SOAP_PASSWORD		:= com.ibm.SOAP.loginPassword
JAZZSM_SOAP_PASSWORD_V		= $(WAS_JAZZSM_PASSWD)

JAZZSM_SSLCLIENT_PROPS		:= $(PATH_INSTALL_JAZZSM)/profile/properties/ssl.client.props
JAZZSM_SSLCLIENT_PROTO		:= com.ibm.ssl.protocol
JAZZSM_SSLCLIENT_PROTO_V 	:= TLSv1.2

JAZZSM_CMD_PWDENCODER	:= $(PATH_INSTALL_JAZZSM)/profile/bin/PropFilePasswordEncoder.sh
 
ifdef REDHAT6_CHECK
JAZZSM_PACKAGES		=	$(PACKAGES_COMMON) \
						firefox.x86_64 \
						gtk2-engines.x86_64 \
						libcanberra-gtk2.x86_64 \
						PackageKit-gtk-module.x86_64
else
JAZZSM_PACKAGES		=	$(PACKAGES_COMMON) \
						firefox.x86_64 \
						libcanberra-gtk2.x86_64
endif

################################################################################
# JAZZ FOR SERVICE MANAGEMENT
################################################################################
WAS_JAZZSM_USER=smadmin
WAS_JAZZSM_PASSWD=netcool
WAS_JAZZSM_PROFILE=JazzSMProfile
WAS_JAZZSM_CONTEXTROOT=/ibm/console
WAS_JAZZSM_CELL=JazzSMNode01Cell
WAS_JAZZSM_NODE=JazzSMNode01
WAS_JAZZSM_SERVERNAME=server1

WAS_CMD_WSADMIN=$(PATH_INSTALL_WEBSPHERE)/AppServer/bin/wsadmin.sh

WAS_WC_DEFAULTHOST=16310
WAS_WC_DEFAULTHOST_SECURE=16311
WAS_BOOTSTRAP_ADDRESS=16312
WAS_SOAP_CONNECTOR_ADDRESS=16313
WAS_IPC_CONNECTOR_ADDRESS=16314
WAS_WC_ADMINHOST=16315
WAS_WC_ADMINHOST_SECURE=16316
WAS_DCS_UNICAST_ADDRESS=16318
WAS_ORB_LISTENER_ADDRESS=16320
WAS_SAS_SSL_SERVERAUTH_LISTENER_ADDRESS=16321
WAS_CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS=16322
WAS_CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS=16323
WAS_REST_NOTIFICATION_PORT=16324

################################################################################
# SERVER INFORMATION
################################################################################
HOST_FQDN	:= $(shell $(CMD_HOSTNAME) -f)
HOST		:= $(shell $(CMD_HOSTNAME))
TIMESTAMP	=  $(shell $(CMD_DATE) +'%Y%m%d_%H%M%S')

################################################################################
# INSTALLATION MEDIA, DESCRIPTIONS, FILES, AND CHECKSUMS
################################################################################
MEDIA_ALL_DESC	=	\t$(MEDIA_STEP1_D)\n \
					\t$(MEDIA_STEP2a1_D)\n \
					\t$(MEDIA_STEP2a2_D)\n 
					

MEDIA_ALL_FILES	=	$(MEDIA_STEP1_F) \
					$(MEDIA_STEP2a1_F) \
					$(MEDIA_STEP2a2_F)
				

MEDIA_STEP1_D	:= IBM Prerequisite Scanner V1.2.0.17, Build 20150827
MEDIA_STEP2a1_D := IBM WebSphere Application Server V8.5.5.4 for Jazz for Service\n\t\tManagement 1.1.2.0 for Linux Multilingual (CN553ML)
MEDIA_STEP2a2_D := Jazz for Service Management V1.1.2.1 for Linux Multilingual (CN6WAML)


MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/precheck_unix_20150827.tar
MEDIA_STEP2a1_F := $(PATH_MAKEFILE_MEDIA)/WSPAS8.5.5.15_FOR_JSM_LNX_ML.tar.gz
MEDIA_STEP2a2_F := $(PATH_MAKEFILE_MEDIA)/JSM1.1.3.5_FOR_LNX_ML.zip

MEDIA_STEP1_B	:= fda01aa083b92fcb6f25a7b71058dc045b293103731ca61fda10c73499f1473ef59608166b236dcf802ddf576e7469af0ec063215326e620092c1aeeb1d19186
MEDIA_STEP2a1_B := 29dedc306c8ed15735f25983de5332c47c1d8dd5acf4c1de8b3aa98fc6361cd3e8c92d273434e5adb4d827f86b96dc18a3af5436e47c689f482f16d6635bd0cf
MEDIA_STEP2a2_B := 53895461a94489f5532892806f1fc9b692032dcee5a6585258e950667dfad3b961a4252ec7fd119ef515bf821ebab3e87fae17822797524a2d91cab71c59ea08

################################################################################
# COMMAND TO BE INSTALLED BEFORE USE
################################################################################
CMD_IBM_IMUTILSC	:= $(PATH_REPOSITORY_INSTALL)/im.linux.x86_64/tools/imutilsc
CMD_IBM_MANAGEPROFILES	:= $(PATH_INSTALL_WEBSPHERE)/AppServer/bin/manageprofiles.sh

################################################################################
# JAZZSM RESPONSE FILE TEMPLATE (INSTALLATION)
################################################################################
#<repository location='$(PATH_REPOSITORY_INSTALL)/im.linux.x86_64' temporary='true'/>
JAZZSM_INSTALL_RESPONSE_FILE=$(PATH_TMP)/jazzsm_install_response.xml
define JAZZSM_INSTALL_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(JAZZSM_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_INSTALL)/im.linux.x86_64'/>
    <repository location='$(PATH_REPOSITORY_INSTALL)/'/>
    <repository location='$(PATH_REPOSITORY_INSTALL)/JazzSMRepository/disk1'/>
    <repository location='$(PATH_REPOSITORY_INSTALL)/WASRepository/disk1'/>
  </server>
  <profile kind="self" installLocation="$(JAZZSM_HOME)/$(PATH_IM_RELATIVE_PATH)" id="IBM Installation Manager">
	<data value="x86_64" key="cic.selector.arch"/>
  </profile>
  <install>
	<!-- IBM® Installation Manager 1.8.9.3 -->
      <offering id="com.ibm.cic.agent" features="agent_core,agent_jre,agent_web" version="1.8.9003.20190204_1751" profile="IBM Installation Manager"/>
  </install>
  <profile installLocation="$(PATH_INSTALL_WEBSPHERE)/AppServer" id="IBM WebSphere Application Server V8.5">
	<data value="x86" key="cic.selector.arch"/>
	<data value="java8" key="user.wasjava"/>
	<data value="java8" key="user.internal.use.only.prev.wasjava"/>
  </profile>
  <install>
	<!-- IBM WebSphere Application Server 8.5.5.15 -->
    <offering id="com.ibm.websphere.BASE.v85" features="core.feature,ejbdeploy,thinclient,embeddablecontainer,com.ibm.sdk.6_64bit" version="8.5.5015.20190128_1828" profile="IBM WebSphere Application Server V8.5"/>
	<!-- IBM WebSphere SDK Java Technology Edition (Optional) 7.0.9.30 -->
    <offering id="com.ibm.websphere.IBMJAVA.v70" features="com.ibm.sdk.7" version="7.0.9030.20160224_1826" profile="IBM WebSphere Application Server V8.5"/>
	<!-- Jazz for Service Management extension for IBM WebSphere 8.5 1.1.2.1 -->
    <offering id="com.ibm.tivoli.tacct.psc.install.was85.extension" features="main.feature" version="1.1.2001.20191018-0333" profile="IBM WebSphere Application Server V8.5"/>
  </install>
  <profile id='Core services in Jazz for Service Management' installLocation='$(PATH_INSTALL_JAZZSM)'>
    <data key='eclipseLocation' value='$(PATH_INSTALL_JAZZSM)'/>
    <data key='user.import.profile' value='false'/>
    <data key='cic.selector.os' value='linux'/>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='cic.selector.ws' value='gtk'/>
    <data key='cic.selector.nl' value='en'/>
    <data key='user.BOOTSTRAP_ADDRESS' value='$(WAS_BOOTSTRAP_ADDRESS)'/>
    <data key='user.CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS' value='$(WAS_CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)'/>
    <data key='user.SOAP_CONNECTOR_ADDRESS' value='$(WAS_SOAP_CONNECTOR_ADDRESS)'/>
    <data key='user.CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS' value='$(WAS_CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS)'/>
    <data key='user.DCS_UNICAST_ADDRESS' value='$(WAS_DCS_UNICAST_ADDRESS)'/>
    <data key='user.IPC_CONNECTOR_ADDRESS' value='$(WAS_IPC_CONNECTOR_ADDRESS)'/>
    <data key='user.ORB_LISTENER_ADDRESS' value='$(WAS_ORB_LISTENER_ADDRESS)'/>
    <data key='user.WC_defaulthost_secure' value='$(WAS_WC_DEFAULTHOST_SECURE)'/>
    <data key='user.REST_NOTIFICATION_PORT' value='$(WAS_REST_NOTIFICATION_PORT)'/>
    <data key='user.WC_defaulthost' value='$(WAS_WC_DEFAULTHOST)'/>
    <data key='user.WC_adminhost_secure' value='$(WAS_WC_ADMINHOST_SECURE)'/>
    <data key='user.SAS_SSL_SERVERAUTH_LISTENER_ADDRESS' value='$(WAS_SAS_SSL_SERVERAUTH_LISTENER_ADDRESS)'/>
    <data key='user.WC_adminhost' value='$(WAS_WC_ADMINHOST)'/>
    <data key='user.TIP_CONTEXT_ROOT' value='$(WAS_JAZZSM_CONTEXTROOT)'/>
    <data key='user.WAS_HOME' value='$(PATH_INSTALL_WEBSPHERE)/AppServer'/>
    <data key='user.CREATE_NEW_WAS_PROFILE' value='true'/>
    <data key='user.WAS_PROFILE_PATH' value='$(PATH_INSTALL_JAZZSM)/profile'/>
    <data key='user.WAS_PROFILE_NAME' value='$(WAS_JAZZSM_PROFILE)'/>
    <data key='user.WAS_HOST_NAME' value='$(HOST_FQDN)'/>
    <data key='user.WAS_SERVER_NAME' value='$(WAS_JAZZSM_SERVERNAME)'/>
    <data key='user.WAS_NODE' value='$(WAS_JAZZSM_NODE)'/>
    <data key='user.WAS_USER_NAME' value='$(WAS_JAZZSM_USER)'/>
    <data key='user.WAS_PASSWORD' value='<WAS_JAZZSM_PASSWD>'/>
    <data key='user.WAS_CELL' value='$(WAS_JAZZSM_CELL)'/>
  </profile>
  <install modify='false'>
	<!-- IBM Dashboard Application Services Hub 3.1.3.5 -->
	<offering id="com.ibm.tivoli.tacct.psc.tip.install" features="com.ibm.tivoli.tacct.psc.install.server.feature.tip.install,com.ibm.tivoli.tacct.psc.install.server.feature.tip.config" version="3.1.3100.20191018-0333" profile="Core services in Jazz for Service Management"/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='com.ibm.cic.common.core.preferences.connectTimeout' value='30'/>
  <preference name='com.ibm.cic.common.core.preferences.readTimeout' value='45'/>
  <preference name='com.ibm.cic.common.core.preferences.downloadAutoRetryCount' value='0'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
  <preference name='com.ibm.cic.common.core.preferences.ssl.nonsecureMode' value='false'/>
  <preference name='com.ibm.cic.common.core.preferences.http.disablePreemptiveAuthentication' value='false'/>
  <preference name='http.ntlm.auth.kind' value='NTLM'/>
  <preference name='http.ntlm.auth.enableIntegrated.win32' value='true'/>
  <preference name='com.ibm.cic.common.core.preferences.preserveDownloadedArtifacts' value='true'/>
  <preference name='com.ibm.cic.common.core.preferences.keepFetchedFiles' value='false'/>
  <preference name='PassportAdvantageIsEnabled' value='false'/>
  <preference name='com.ibm.cic.common.core.preferences.searchForUpdates' value='false'/>
  <preference name='com.ibm.cic.agent.ui.displayInternalVersion' value='false'/>
  <preference name='com.ibm.cic.common.sharedUI.showErrorLog' value='true'/>
  <preference name='com.ibm.cic.common.sharedUI.showWarningLog' value='true'/>
  <preference name='com.ibm.cic.common.sharedUI.showNoteLog' value='true'/>
</agent-input>
endef
export JAZZSM_INSTALL_RESPONSE_FILE_CONTENT

################################################################################
# JAZZSM RESPONSE FILE TEMPLATE (UPGRADE)
################################################################################
#<repository location='$(PATH_REPOSITORY_INSTALL)/im.linux.x86_64' temporary='true'/>
JAZZSM_UPGRADE_RESPONSE_FILE=$(PATH_TMP)/jazzsm_upgrade_response.xml
define JAZZSM_UPGRADE_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(JAZZSM_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_UPGRADE)/jazz/JazzSMFPRepository/disk1'/>
 </server>
<profile id='IBM WebSphere Application Server V8.5' installLocation='/opt/IBM/WebSphere/AppServer'>
  <data key='cic.selector.arch' value='x86'/>
  <data key='user.wasjava' value='java8'/>
  <data key='user.internal.use.only.prev.wasjava' value='java8'/>
 </profile>
 <install>
    <!-- Jazz for Service Management extension for IBM WebSphere 8.5 1.1.2.1 -->
    <offering profile='IBM WebSphere Application Server V8.5' id='com.ibm.tivoli.tacct.psc.install.was85.extension' version='1.1.2001.20211109-1038' features='main.feature'/>
 </install>
  <profile id='Core services in Jazz for Service Management' installLocation='$(PATH_INSTALL_JAZZSM)'>
    <data key='cic.selector.os' value='linux'/>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='cic.selector.ws' value='gtk'/>
    <data key='cic.selector.nl' value='en'/>
    <data key='user.BOOTSTRAP_ADDRESS' value='$(WAS_BOOTSTRAP_ADDRESS)'/>
    <data key='user.CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS' value='$(WAS_CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)'/>
    <data key='user.SOAP_CONNECTOR_ADDRESS' value='$(WAS_SOAP_CONNECTOR_ADDRESS)'/>
    <data key='user.CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS' value='$(WAS_CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS)'/>
    <data key='user.DCS_UNICAST_ADDRESS' value='$(WAS_DCS_UNICAST_ADDRESS)'/>
    <data key='user.IPC_CONNECTOR_ADDRESS' value='$(WAS_IPC_CONNECTOR_ADDRESS)'/>
    <data key='user.ORB_LISTENER_ADDRESS' value='$(WAS_ORB_LISTENER_ADDRESS)'/>
    <data key='user.WC_defaulthost_secure' value='$(WAS_WC_DEFAULTHOST_SECURE)'/>
    <data key='user.REST_NOTIFICATION_PORT' value='$(WAS_REST_NOTIFICATION_PORT)'/>
    <data key='user.WC_defaulthost' value='$(WAS_WC_DEFAULTHOST)'/>
    <data key='user.WC_adminhost_secure' value='$(WAS_WC_ADMINHOST_SECURE)'/>
    <data key='user.SAS_SSL_SERVERAUTH_LISTENER_ADDRESS' value='$(WAS_SAS_SSL_SERVERAUTH_LISTENER_ADDRESS)'/>
    <data key='user.WC_adminhost' value='$(WAS_WC_ADMINHOST)'/>
    <data key='user.TIP_CONTEXT_ROOT' value='$(WAS_JAZZSM_CONTEXTROOT)'/>
    <data key='user.WAS_HOME' value='$(PATH_INSTALL_WEBSPHERE)/AppServer'/>
    <data key='user.CREATE_NEW_WAS_PROFILE' value='false'/>
    <data key='user.WAS_PROFILE_PATH' value='$(PATH_INSTALL_JAZZSM)/profile'/>
    <data key='user.WAS_PROFILE_NAME' value='$(WAS_JAZZSM_PROFILE)'/>
    <data key='user.WAS_HOST_NAME' value='$(HOST_FQDN)'/>
    <data key='user.WAS_SERVER_NAME' value='$(WAS_JAZZSM_SERVERNAME)'/>
    <data key='user.WAS_NODE' value='$(WAS_JAZZSM_NODE)'/>
    <data key='user.WAS_USER_NAME' value='$(WAS_JAZZSM_USER)'/>
    <data key='user.WAS_PASSWORD' value='<WAS_JAZZSM_PASSWD>'/>
    <data key='user.WAS_CELL' value='$(WAS_JAZZSM_CELL)'/>
  </profile>
  <install>
	<!-- IBM Dashboard Application Services Hub 3.1.3.13 -->
	<offering profile="Core services in Jazz for Service Management" id="com.ibm.tivoli.tacct.psc.tip.install" version="3.1.3100.20211109-1038" features="com.ibm.tivoli.tacct.psc.install.server.feature.tip.install,com.ibm.tivoli.tacct.psc.install.server.feature.tip.config"/>
  </install>
	<preference name="com.ibm.cic.common.core.preferences.eclipseCache" value="${sharedLocation}"/>
	<preference name="offering.service.repositories.areUsed" value="false"/>
</agent-input>
endef
export JAZZSM_UPGRADE_RESPONSE_FILE_CONTENT

################################################################################
# WAS  RESPONSE FILE TEMPLATE (UPGRADE)
################################################################################
WAS_UPGRADE_RESPONSE_FILE=$(PATH_TMP)/was_upgrade_response.xml
define WAS_UPGRADE_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(JAZZSM_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_UPGRADE)'/>
  </server>
<profile id="IBM WebSphere Application Server V8.5" installLocation="$(PATH_INSTALL_WEBSPHERE)/AppServer">
	<data key="cic.selector.arch" value="x86"/>
	<data key="user.wasjava" value="java8"/>
	<data key="user.internal.use.only.prev.wasjava" value="java8"/>
</profile>
<install>
<!-- IBM WebSphere Application Server 8.5.5.20 -->
	<offering profile="IBM WebSphere Application Server V8.5" id="com.ibm.websphere.BASE.v85" version="8.5.5020.20210708_1826" features="com.ibm.sdk.6_64bit,core.feature,ejbdeploy,embeddablecontainer,thinclient"/>
</install>
<preference value="${sharedLocation}" name="com.ibm.cic.common.core.preferences.eclipseCache"/>
<preference value="false" name="offering.service.repositories.areUsed"/>
</agent-input>
endef
export WAS_UPGRADE_RESPONSE_FILE_CONTENT

################################################################################
# JAZZSM RESPONSE FILE TEMPLATE (UNINSTALL SERVICES)
################################################################################
JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE=$(PATH_TMP)/jazzsm_uninstall_services_response.xml
define JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(JAZZSM_IMSHARED)'/>
  </variables>
  <server>
	<repository location='$(PATH_REPOSITORY_INSTALL)/im.linux.x86_64'/>
	<repository location='$(PATH_REPOSITORY_INSTALL)/'/>
	<repository location='$(PATH_REPOSITORY_INSTALL)/JazzSMRepository/disk1'/>
	<repository location='$(PATH_REPOSITORY_INSTALL)/WASRepository/disk1'/>
  </server>
  <profile id='Core services in Jazz for Service Management' installLocation='$(PATH_INSTALL_JAZZSM)'>
    <data key='eclipseLocation' value='$(PATH_INSTALL_JAZZSM)'/>
    <data key='user.import.profile' value='false'/>
    <data key='cic.selector.os' value='linux'/>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='cic.selector.ws' value='gtk'/>
    <data key='cic.selector.nl' value='en'/>
    <data key='user.BOOTSTRAP_ADDRESS' value='$(WAS_BOOTSTRAP_ADDRESS)'/>
    <data key='user.CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS' value='$(WAS_CSIV2_SSL_MUTUALAUTH_LISTENER_ADDRESS)'/>
    <data key='user.SOAP_CONNECTOR_ADDRESS' value='$(WAS_SOAP_CONNECTOR_ADDRESS)'/>
    <data key='user.CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS' value='$(WAS_CSIV2_SSL_SERVERAUTH_LISTENER_ADDRESS)'/>
    <data key='user.DCS_UNICAST_ADDRESS' value='$(WAS_DCS_UNICAST_ADDRESS)'/>
    <data key='user.IPC_CONNECTOR_ADDRESS' value='$(WAS_IPC_CONNECTOR_ADDRESS)'/>
    <data key='user.ORB_LISTENER_ADDRESS' value='$(WAS_ORB_LISTENER_ADDRESS)'/>
    <data key='user.WC_defaulthost_secure' value='$(WAS_WC_DEFAULTHOST_SECURE)'/>
    <data key='user.REST_NOTIFICATION_PORT' value='$(WAS_REST_NOTIFICATION_PORT)'/>
    <data key='user.WC_defaulthost' value='$(WAS_WC_DEFAULTHOST)'/>
    <data key='user.WC_adminhost_secure' value='$(WAS_WC_ADMINHOST_SECURE)'/>
    <data key='user.SAS_SSL_SERVERAUTH_LISTENER_ADDRESS' value='$(WAS_SAS_SSL_SERVERAUTH_LISTENER_ADDRESS)'/>
    <data key='user.WC_adminhost' value='$(WAS_WC_ADMINHOST)'/>
    <data key='user.TIP_CONTEXT_ROOT' value='$(WAS_JAZZSM_CONTEXTROOT)'/>
    <data key='user.WAS_HOME' value='$(PATH_INSTALL_WEBSPHERE)/AppServer'/>
    <data key='user.CREATE_NEW_WAS_PROFILE' value='false'/>
    <data key='user.WAS_PROFILE_PATH' value='$(PATH_INSTALL_JAZZSM)/profile'/>
    <data key='user.WAS_PROFILE_NAME' value='$(WAS_JAZZSM_PROFILE)'/>
    <data key='user.WAS_HOST_NAME' value='$(HOST_FQDN)'/>
    <data key='user.WAS_SERVER_NAME' value='$(WAS_JAZZSM_SERVERNAME)'/>
    <data key='user.WAS_NODE' value='$(WAS_JAZZSM_NODE)'/>
    <data key='user.WAS_USER_NAME' value='$(WAS_JAZZSM_USER)'/>
    <data key='user.WAS_CELL' value='$(WAS_JAZZSM_CELL)'/>
    <data key='user.WAS_PASSWORD' value='<WAS_JAZZSM_PASSWD>'/>
  </profile>
  <uninstall modify='false'>
    <offering profile='Core services in Jazz for Service Management' id='com.ibm.tivoli.tacct.psc.tip.install' version='3.1.3100.20191018-0333'/>
  </uninstall>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='com.ibm.cic.common.core.preferences.connectTimeout' value='30'/>
  <preference name='com.ibm.cic.common.core.preferences.readTimeout' value='45'/>
  <preference name='com.ibm.cic.common.core.preferences.downloadAutoRetryCount' value='0'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
  <preference name='com.ibm.cic.common.core.preferences.ssl.nonsecureMode' value='false'/>
  <preference name='com.ibm.cic.common.core.preferences.http.disablePreemptiveAuthentication' value='false'/>
  <preference name='http.ntlm.auth.kind' value='NTLM'/>
  <preference name='http.ntlm.auth.enableIntegrated.win32' value='true'/>
  <preference name='com.ibm.cic.common.core.preferences.preserveDownloadedArtifacts' value='true'/>
  <preference name='com.ibm.cic.common.core.preferences.keepFetchedFiles' value='false'/>
  <preference name='PassportAdvantageIsEnabled' value='false'/>
  <preference name='com.ibm.cic.common.core.preferences.searchForUpdates' value='false'/>
  <preference name='com.ibm.cic.agent.ui.displayInternalVersion' value='false'/>
  <preference name='com.ibm.cic.common.sharedUI.showErrorLog' value='true'/>
  <preference name='com.ibm.cic.common.sharedUI.showWarningLog' value='true'/>
  <preference name='com.ibm.cic.common.sharedUI.showNoteLog' value='true'/>
</agent-input>
endef
export JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE_CONTENT

################################################################################
# JAZZ FOR SERVICE MANAGEMENT START/STOP CONFIGURATION
################################################################################
JAZZSM_ETC_SERVICE=jazzsm
JAZZSM_ETC_INITD_USER=root
JAZZSM_ETC_INITD_GROUP=root
JAZZSM_ETC_INITD_FILE=/etc/init.d/$(JAZZSM_ETC_SERVICE)

JAZZSM_SYSTEMD_SCRIPT=$(PATH_INSTALL_JAZZSM)/profile/bin/$(JAZZSM_ETC_SERVICE)_init.sh
JAZZSM_SYSTEMD_SERVICE=/etc/systemd/system/$(JAZZSM_ETC_SERVICE).service

define JAZZSM_ETC_INITD_FILE_CONTENT
#!/bin/sh
# start/stop Jazz for Service Management services during the boot and shutdown
#
# $(JAZZSM_USER) is unix ID used to install products
# chkconfig -list to check the current startup settings
# chkconfig: 35 83 17
# description: Jazz for Service Management services startup/shutdown script

# Source function library.
. /etc/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up? If it is not we exit here.
[ "$${NETWORKING}" = "no" ] && exit 0

RETVAL=0

case "$$1" in
start)
	# Check that start command exists
	if [ ! -x $(PATH_INSTALL_JAZZSM_START) ]; then
		$(CMD_ECHO) "$(PATH_INSTALL_JAZZSM_START): does not exist or not executable, $(JAZZSM_ETC_SERVICE) not starting"
		exit 1
	fi

	[ "$$BOOTUP" != "verbose" ] && $(CMD_ECHO) -n "Starting IBM Jazz for Service Management:"
	$(CMD_SU) - $(JAZZSM_USER) -c "$(PATH_INSTALL_JAZZSM_START) $(WAS_JAZZSM_SERVERNAME) 1> /dev/null"
	RETVAL=$$?
	if [ $$RETVAL -eq 0 ]; then
		echo_success;
	else
		echo_failure;
	fi
	$(CMD_ECHO)
	;;

stop)
	# Check that stop command exists
	if [ ! -x $(PATH_INSTALL_JAZZSM_STOP) ]; then
		$(CMD_ECHO) "$(PATH_INSTALL_JAZZSM_STOP): does not exist or not executable, $(JAZZSM_ETC_SERVICE) not stopping"
		exit 1
	fi

	[ "$$BOOTUP" != "verbose" ] && $(CMD_ECHO) -n "Stopping IBM Jazz for Service Management:"
	$(CMD_SU) - $(JAZZSM_USER) -c "$(PATH_INSTALL_JAZZSM_STOP) $(WAS_JAZZSM_SERVERNAME) 1> /dev/null"
	RETVAL=$$?
	if [ $$RETVAL -eq 0 ]; then
		echo_success;
	else
		echo_failure;
	fi
	$(CMD_ECHO)
	;;

status)
	# Check that stop command exists
	if [ ! -x $(PATH_INSTALL_JAZZSM_STATUS) ]; then
		$(CMD_ECHO) "$(PATH_INSTALL_JAZZSM_STATUS): does not exist or not executable, $(JAZZSM_ETC_SERVICE) not statused"
		exit 1
	fi

	$(CMD_SU) - $(JAZZSM_USER) -c "$(PATH_INSTALL_JAZZSM_STATUS) $(WAS_JAZZSM_SERVERNAME)"
#	$(CMD_PS) -ef | $(CMD_GREP) -v grep | $(CMD_GREP) $(JAZZSM_USER) | $(CMD_GREP) -e $(PATH_INSTALL_JAZZSM)/profile/server -e $(WAS_JAZZSM_SERVERNAME)
	RETVAL=$$?
	;;

restart|reload)
	$$0 stop
	$$0 start
	RETVAL=$$?
	;;

*)
	$(CMD_ECHO) "Usage: $$0 { start | stop | status | restart | reload }"
	RETVAL=1
esac

exit $$RETVAL
endef
export JAZZSM_ETC_INITD_FILE_CONTENT

################################################################################
# SYSTEMD SERVICE CONFIGURATION FILE
################################################################################
define ETC_SYSTEMD_JAZZSM_SERVICE_CONTENT
[Unit]
Description=Netcool Jazz Service Management Services
After=network.target

[Service]
ExecStart=$(JAZZSM_SYSTEMD_SCRIPT) start
ExecStop=$(JAZZSM_SYSTEMD_SCRIPT) stop
ExecReload=$(JAZZSM_SYSTEMD_SCRIPT) reload
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=default.target
endef
export ETC_SYSTEMD_JAZZSM_SERVICE_CONTENT

################################################################################
# JAVA HEAP CONFIGURATION FILE
################################################################################
JAZZSM_JAVA_CONFIG_FILE=$(PATH_TMP)/jazzsm_java_config.py
define JAZZSM_JAVA_HEAP_CONTENT
AdminTask.setJVMInitialHeapSize('-serverName server1 -initialHeapSize 1024')
AdminTask.setJVMMaxHeapSize('-serverName server1 -maximumHeapSize 4098')
AdminConfig.save()
endef
export JAZZSM_JAVA_HEAP_CONTENT


################################################################################
# MAIN BUILD TARGETS
################################################################################
default:			help

all:				help \
					prerequisites \
					install

prerequisites:		install_packages

install:			preinstallchecks \
					preinstall \
					theinstall \
					postinstall

uninstall:			preuninstallchecks \
					preuninstall \
					theuninstall 

verify:			

preinstallchecks:	check_commands \
					check_media_exists \
					check_media_checksums \
					check_prerequisites

preinstall:		

theinstall:			install_jazzsm \
					configure_jazzsm \
					configure_TLSv1_2 \
					configure_root_ca \
					configure_heap_size \
					autostarton_jazzsm

postinstall:		clean

preuninstallchecks:	check_commands 

preuninstall:

theuninstall:		autostartoff_jazzsm \
					start_jazzsm_natively \
					uninstall_jazzsm

postuninstall:		remove_root_path \
					clean

clean:				remove_temp_dir \
					remove_jazzsm_install_response_file \
					remove_jazzsm_uninstall_response_file \
					clean_tmp

scrub:				uninstall \
					clean

# WARNING scrub_users WILL REMOVE USERS AND HOME DIRECTORIES INCLUDING ALL
# CONTENT AND ANY INSTALL MANAGERS IN SAME.  IF THE SAME USERNAME IS USED
# FOR MORE THAN ONE PRODUCT INSTALL, THEN THIS SHOULD BE DONE WITH EXTREME
# CAUTION
scrub_users:		remove_jazzsm_group \
					clean

################################################################################
# HELP INFORMATION
################################################################################
help:
	@$(CMD_PRINTF) "\n\
This makefile installs $(MAKE_PRODUCT)\n\
\n\
The following components are required for installation:\n"
	@$(foreach itr_m_d,$(MEDIA_ALL_DESC),\
		$(CMD_PRINTF) "$(itr_m_d) " ; \
	)
	@$(CMD_PRINTF) "\n\
So please confirm the following media files exist:\n"
	@$(foreach itr_u,$(MEDIA_ALL_FILES),\
		$(CMD_PRINTF) "\t$(itr_u)\n" ; \
	)
	@$(CMD_PRINTF) "\n\
Once all media files are available, execute this makefile as root or with\n\
'sudo' to make 'all'.\n\n\
\tsudo make -f $(MAKE_FILE) all\n\n"

################################################################################
# CONFIRM RUNNING MAKEFILE AS ROOT
################################################################################
check_whoami:
	@$(call func_print_caption,"CHECKING EFFECTIVE USER")
	@$(call func_check_whoami,$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# CONFIRM COMMANDS EXIST AND ARE EXECUTABLE
################################################################################
check_commands:		check_whoami
	@$(call func_print_caption,"CHECKING COMMANDS")
	@$(foreach itr_c,$(CMD_ALL),$(call func_command_check,$(itr_c)))
	@$(CMD_ECHO)

################################################################################
# CHECK MEDIA FILES EXIST AND ARE READABLE
################################################################################
check_media_exists:	check_commands
	@$(call func_print_caption,"CHECKING FOR INSTALLATION MEDIA")
	@$(call func_check_media_exists,$(MEDIA_ALL_FILES))
	@$(CMD_ECHO)

################################################################################
# CONFIRM MEDIA INTEGRITY VIA CHECKSUMS
################################################################################
check_media_checksums:	check_commands
	@$(call func_print_caption,"CHECKING INSTALLATION MEDIA CHECKSUMS")
	@$(call func_check_file_cksum,$(MEDIA_STEP1_F),$(MEDIA_STEP1_B))
	@$(call func_check_file_cksum,$(MEDIA_STEP2a1_F),$(MEDIA_STEP2a1_B))
	@$(call func_check_file_cksum,$(MEDIA_STEP2a2_F),$(MEDIA_STEP2a2_B))
#FUTURES	@$(call func_check_file_cksum,$(MEDIA_STEP2b_F),$(MEDIA_STEP2b_B))
	@$(CMD_ECHO)

################################################################################
# INSTALL PREREQUISITE PACKAGES
################################################################################
install_packages:	check_whoami
	@$(call func_print_caption,"INSTALLING PREREQUISITE PACKAGES")
	@$(call func_install_packages,$(JAZZSM_PACKAGES))
	@$(CMD_ECHO)

################################################################################
# CREATE TEMPORARY DIRECTORY
################################################################################
create_temp_dir:	check_whoami \
					check_commands
	@$(call func_print_caption,"CREATING TEMPORARY DIRECTORY")
	@$(CMD_TEST) -n "$(PATH_TEMP_DIR)" || { $(CMD_ECHO) \
		"Directory mktemp (FAIL): $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null" ; \
		exit 1; }
	@$(CMD_ECHO) "Directory mktemp (OK):   $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null"
	@$(call func_chmod,777,$(PATH_TEMP_DIR))
	@$(CMD_ECHO)

################################################################################
# REMOVE TEMPORARY DIRECTORY
################################################################################
remove_temp_dir:	check_whoami \
					check_commands
	@$(call func_print_caption,"REMOVING TEMPORARY DIRECTORIES")
	@$(CMD_RM) -rf $(PATH_TMP)/$(PATH_TEMP_BASE).*
	@$(CMD_ECHO)

################################################################################
# CHECK PREREQUISITES
################################################################################
check_prerequisites:	check_commands \
						create_temp_dir
	@$(call func_print_caption,"CHECKING PREREQUISITES FOR JAZZSM")
	@$(call func_tar_xf_to_new_dir,root,root,755,$(MEDIA_STEP1_F),$(PATH_TEMP_DIR)/$(MAKE_PRODUCT))
	@$(CMD_ECHO) "Prereq Check:            export JazzSM_FreshInstall=True; $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s"
	@$(CMD_ECHO)
	@export JazzSM_FreshInstall=True; $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s; rc=$$? ; \
	if [ $$rc -ne 0 -a $$rc -ne 3 -a "$(MAKE_FORCE)" != "TRUE" ] ; \
	then \
		$(CMD_ECHO) "Prereq Check (FAIL):     export JazzSM_FreshInstall=True; $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s" ; \
		exit 2; \
	fi
	@$(CMD_ECHO) "Prereq Check (OK):       export JazzSM_FreshInstall=True; $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s"
	@$(CMD_ECHO)

################################################################################
# CREATE THE ROOT PATH DIRECTORY IF IT DOESN'T EXIST
################################################################################
create_root_path:	check_whoami \
					check_commands
	@$(call func_print_caption,"CREATING ROOT INSTALL DIRECTORY IF NEEDED")
	@$(call func_mkdir,root,root,755,$(PATH_INSTALL))
	@$(CMD_ECHO)

# only remove root path if empty, do not backup/move as may not be last product
remove_root_path:	check_whoami \
					check_commands
	@$(call func_print_caption,"REMOVING ROOT INSTALL DIRECTORY IF EMPTY")
	@$(call func_rmdir_if_empty,$(PATH_INSTALL))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE GROUPS
################################################################################
create_jazzsm_group:	check_whoami \
						check_commands
	@$(call func_print_caption,"CONFIRMING/CREATING JAZZSM GROUP")
	@$(call func_create_group,$(JAZZSM_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# REMOVE GROUPS
################################################################################
remove_jazzsm_group:	check_whoami \
						check_commands \
						remove_jazzsm_user
	@$(call func_print_caption,"REMOVING JAZZSM GROUP")
	@$(call func_remove_group,$(JAZZSM_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE USERS
################################################################################
create_jazzsm_user:	check_whoami \
					check_commands \
					create_jazzsm_group
	@$(call func_print_caption,"CONFIRMING/CREATING JAZZSM USER")
	@$(call func_create_user,$(JAZZSM_USER),$(MAKE_PRODUCT),$(JAZZSM_GROUP),$(JAZZSM_HOME),$(JAZZSM_SHELL),$(JAZZSM_PASSWD))
	@$(CMD_ECHO)

################################################################################
# REMOVE USERS
################################################################################
remove_jazzsm_user:	check_whoami \
					check_commands
	@$(call func_print_caption,"REMOVING JAZZSM USER")
	@$(call func_remove_user,$(JAZZSM_USER),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# PREPARE JAZZ FOR SERVICE MANAGEMENT INSTALLATION MEDIA
# NOTE:  THIS INCLUDES WEBSPHERE
################################################################################
prepare_jazzsm_install_media:	check_whoami \
								check_commands \
								create_jazzsm_user
	@$(call func_print_caption,"PREPARING JAZZ FOR SERVICE MANAGEMENT INSTALLATION MEDIA")
	@if [ -d "$(PATH_REPOSITORY_INSTALL)" ];  \
	then \
		$(CMD_ECHO) "JazzSM Repo? (OK):       -d $(PATH_REPOSITORY_INSTALL) # already exists" ; \
	else \
		$(CMD_ECHO) "JazzSM Repo? (OK):       -d $(PATH_REPOSITORY_INSTALL) # non-existent" ; \
		$(call func_tar_zxf_to_new_dir,$(JAZZSM_USER),$(JAZZSM_GROUP),755,$(MEDIA_STEP2a1_F),$(PATH_REPOSITORY_INSTALL)) ; \
		$(call func_unzip_to_existing_dir,$(JAZZSM_USER),$(MEDIA_STEP2a2_F),$(PATH_REPOSITORY_INSTALL)) ; \
		$(call func_unzip_to_existing_dir,$(JAZZSM_USER),$(PATH_REPOSITORY_INSTALL)/IBM-was-8.5.5.9-linux64.zip,$(PATH_REPOSITORY_INSTALL)) ; \
		$(call func_unzip_to_existing_dir,$(JAZZSM_USER),$(PATH_REPOSITORY_INSTALL)/8.5.5-WS-WAS-FP015-part1.zip,$(PATH_REPOSITORY_INSTALL)) ; \
		$(call func_unzip_to_existing_dir,$(JAZZSM_USER),$(PATH_REPOSITORY_INSTALL)/8.5.5-WS-WAS-FP015-part2.zip,$(PATH_REPOSITORY_INSTALL)) ; \
		$(call func_unzip_to_existing_dir,$(JAZZSM_USER),$(PATH_REPOSITORY_INSTALL)/8.5.5-WS-WAS-FP015-part3.zip,$(PATH_REPOSITORY_INSTALL)) ; \
	fi ;
	@$(CMD_ECHO)



################################################################################
# PREPARE WAS UPGRADE INSTALLATION MEDIA
################################################################################
prepare_was_upgrade_media:   check_whoami \
                                          check_commands \

	@$(call func_print_caption,"PREPARING WAS UPGRADE INSTALLATION MEDIA")
	@if [ -d "$(PATH_REPOSITORY_UPGRADE)" ];  \
	then \
		$(CMD_ECHO) "WAS Repo? (OK):       -d $(PATH_REPOSITORY_UPGRADE) # already exists" ; \
	else \
		$(CMD_ECHO) "WAS Repo? (OK):       -d $(PATH_REPOSITORY_UPGRADE) # non-existent" ; \
		$(call func_unzip_to_new_dir,$(JAZZSM_USER),$(JAZZSM_GROUP),755,$(PATH_MAKEFILE_UPGRADE_MEDIA)/8.5.5-WS-WAS-FP020-part1.zip,$(PATH_REPOSITORY_UPGRADE)) ; \
		$(call func_unzip_to_existing_dir,$(JAZZSM_USER),$(PATH_MAKEFILE_UPGRADE_MEDIA)/8.5.5-WS-WAS-FP020-part2.zip,$(PATH_REPOSITORY_UPGRADE)) ; \
		$(call func_unzip_to_existing_dir,$(JAZZSM_USER),$(PATH_MAKEFILE_UPGRADE_MEDIA)/8.5.5-WS-WAS-FP020-part3.zip,$(PATH_REPOSITORY_UPGRADE)) ; \
	fi ;
	@$(CMD_ECHO)

###s#############################################################################
# PREPARE JAZZSM UPGRADE INSTALLATION MEDIA
################################################################################
prepare_jazzsm_upgrade_media:   check_whoami \
                                          check_commands \

	@$(call func_print_caption,"PREPARING JAZZ UPGRADE INSTALLATION MEDIA")
	@if [ -d "$(PATH_REPOSITORY_UPGRADE)/jazz" ];  \
	then \
		$(CMD_ECHO) "JAZZ Repo? (OK):       -d $(PATH_REPOSITORY_UPGRADE)/jazz # already exists" ; \
	else \
		$(CMD_ECHO) "JAZZ Repo? (OK):       -d $(PATH_REPOSITORY_UPGRADE)/jazz # non-existent" ; \
		$(call func_unzip_to_new_dir,$(JAZZSM_USER),$(JAZZSM_GROUP),755,$(PATH_MAKEFILE_UPGRADE_MEDIA)/jazz/1.1.3-TIV-JazzSM-multi-FP013_signed.zip,$(PATH_REPOSITORY_UPGRADE)/jazz) ; \
	fi ;
	@$(CMD_ECHO)


################################################################################
# CREATE THE JAZZSM HEAP CONFIGURATION FILE
################################################################################
create_jazzsm_java_heap_file:	check_commands 

	@$(call func_print_caption,"CREATING JAZZSM JAVA HEAP CONFIGURATION FILE")
	@$(CMD_ECHO) "$$JAZZSM_JAVA_HEAP_CONTENT" > $(JAZZSM_JAVA_CONFIG_FILE) || { $(CMD_ECHO) ; \
		 "JazzSM Resp File (FAIL): #$(JAZZSM_JAVA_CONFIG_FILE)" ; \
		exit 31; } ; \
	$(CMD_ECHO) "JazzSM JAVA HEAP File (OK):   #$(JAZZSM_JAVA_CONFIG_FILE)"
	@$(call func_chmod,444,$(JAZZSM_JAVA_CONFIG_FILE))
	@$(CMD_ECHO)

################################################################################
# CREATE THE JAZZSM INSTALLATION RESPONSE FILE
################################################################################
create_jazzsm_install_response_file:	check_commands \
										create_jazzsm_user \
										prepare_jazzsm_install_media
	@$(call func_print_caption,"CREATING JAZZSM INSTALLATION RESPONSE FILE")
	@$(call func_command_check,$(CMD_IBM_IMUTILSC))
	@$(CMD_ECHO) "Encrypt Password:        #$(CMD_IBM_IMUTILSC) encryptString..."
	@$(eval TEMP_WAS_JAZZSM_PASSWD_ENCRYPT=`$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_IBM_IMUTILSC) encryptString $(WAS_JAZZSM_PASSWD) -silent -noSplash"`)
	@$(CMD_ECHO) "Encrypt Password (OK):   #$(TEMP_WAS_JAZZSM_PASSWD_ENCRYPT) for $(WAS_JAZZSM_USER)"
	@$(CMD_ECHO) "$$JAZZSM_INSTALL_RESPONSE_FILE_CONTENT" | $(CMD_SED) -e "s/<WAS_JAZZSM_PASSWD>/$(TEMP_WAS_JAZZSM_PASSWD_ENCRYPT)/g" > $(JAZZSM_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "JazzSM Resp File (FAIL): #$(JAZZSM_INSTALL_RESPONSE_FILE)" ; \
		exit 3; } ; \
	$(CMD_ECHO) "JazzSM Resp File (OK):   #$(JAZZSM_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(JAZZSM_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_jazzsm_install_response_file:	check_commands
	@$(call func_print_caption,"REMOVING JAZZSM INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(JAZZSM_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# CREATE THE JAZZSM UPGRADE RESPONSE FILE
################################################################################
create_jazzsm_upgrade_response_file:	check_commands \
										create_jazzsm_user \
										prepare_jazzsm_upgrade_media
	@$(call func_print_caption,"CREATING JAZZSM UPGRADE RESPONSE FILE")
	@$(call func_command_check,$(CMD_IBM_IMUTILSC))
	@$(CMD_ECHO) "Encrypt Password:        #$(CMD_IBM_IMUTILSC) encryptString..."
	@$(eval TEMP_WAS_JAZZSM_PASSWD_ENCRYPT=`$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_IBM_IMUTILSC) encryptString $(WAS_JAZZSM_PASSWD) -silent -noSplash"`)
	@$(CMD_ECHO) "Encrypt Password (OK):   #$(TEMP_WAS_JAZZSM_PASSWD_ENCRYPT) for $(WAS_JAZZSM_USER)"
	@$(CMD_ECHO) "$$JAZZSM_UPGRADE_RESPONSE_FILE_CONTENT" | $(CMD_SED) -e "s/<WAS_JAZZSM_PASSWD>/$(TEMP_WAS_JAZZSM_PASSWD_ENCRYPT)/g" > $(JAZZSM_UPGRADE_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "JazzSM Resp File (FAIL): #$(JAZZSM_UPGRADE_RESPONSE_FILE)" ; \
		exit 3; } ; \
	$(CMD_ECHO) "JazzSM Resp File (OK):   #$(JAZZSM_UPGRADE_RESPONSE_FILE)"
	@$(call func_chmod,444,$(JAZZSM_UPGRADE_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_jazzsm_upgrade_response_file:	check_commands
	@$(call func_print_caption,"REMOVING JAZZSM UPGRADE RESPONSE FILE")
	@$(CMD_RM) -f $(JAZZSM_UPGRADE_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# UPGRADE JAZZSM TO  1.1.3.13
################################################################################
upgrade_jazzsm: check_whoami \
                                check_commands \
                                prepare_jazzsm_upgrade_media \
                                create_jazzsm_upgrade_response_file 

	@$(call func_print_caption,"UPGRADING JAZZSM")
	@if [ -d "$(PATH_INSTALL_JAZZSM)" ] ; \
	then \
		$(CMD_ECHO) "JazzSM Exists? (OK):     -d $(PATH_INSTALL_JAZZSM) # exists" ; \
	else \
		$(CMD_ECHO) "JazzSM Exists? (FAIL):   -d $(PATH_INSTALL_JAZZSM) # non-existent" ; \
		exit 7 ; \
	fi ;

	@$(call func_command_check,$(JAZZSM_CMD_IMCL))
	@$(CMD_ECHO) "Websphere Upgrade:          #In progress..."
	@$(CMD_SU) - $(JAZZSM_USER) -c "$(JAZZSM_CMD_IMCL) input \
		$(JAZZSM_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
		{ $(CMD_ECHO) "JazzSM Upgrade (FAIL):   $(CMD_SU) - $(JAZZSM_USER) -c \"$(JAZZSM_CMD_IMCL) input $(JAZZSM_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	exit 8; }
	@$(CMD_ECHO) "JazzSM Upgrade (OK):     $(CMD_SU) - $(JAZZSM_USER) -c \"$(JAZZSM_CMD_IMCL) input $(JAZZSM_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\""
	@$(CMD_ECHO)

################################################################################
################################################################################
# CREATE THE WEBSPHERE UPGRADE RESPONSE FILE
################################################################################
create_was_upgrade_response_file:	check_commands \
										create_jazzsm_user \
										prepare_was_upgrade_media
	@$(call func_print_caption,"CREATING WEBSPHERE UPGRADE RESPONSE FILE")
	@$(call func_command_check,$(CMD_IBM_IMUTILSC))
	@$(CMD_ECHO) "Encrypt Password:        #$(CMD_IBM_IMUTILSC) encryptString..."
	@$(eval TEMP_WAS_JAZZSM_PASSWD_ENCRYPT=`$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_IBM_IMUTILSC) encryptString $(WAS_JAZZSM_PASSWD) -silent -noSplash"`)
	@$(CMD_ECHO) "Encrypt Password (OK):   #$(TEMP_WAS_JAZZSM_PASSWD_ENCRYPT) for $(WAS_JAZZSM_USER)"
	@$(CMD_ECHO) "$$WAS_UPGRADE_RESPONSE_FILE_CONTENT" | $(CMD_SED) -e "s/<WAS_JAZZSM_PASSWD>/$(TEMP_WAS_JAZZSM_PASSWD_ENCRYPT)/g" > $(WAS_UPGRADE_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "Websphere Resp File (FAIL): #$(JAZZSM_INSTALL_RESPONSE_FILE)" ; \
		exit 3; } ; \
	$(CMD_ECHO) "Websphere Resp File (OK):   #$(WAS_UPGRADE_RESPONSE_FILE)"
	@$(call func_chmod,444,$(WAS_UPGRADE_RESPONSE_FILE))
	@$(CMD_ECHO)

################################################################################
# UPGRADE WAS TO 8.5.5.20
################################################################################
upgrade_was: check_whoami \
                                check_commands \
                                prepare_was_upgrade_media \
                                create_was_upgrade_response_file 

	@$(call func_print_caption,"UPGRADING WEBSPHERE")
	@if [ -d "$(PATH_INSTALL_WEBSPHERE)" ] ; \
	then \
		$(CMD_ECHO) "Websphere Exists? (OK):     -d $(PATH_INSTALL_WEBSPHERE) # exists" ; \
	else \
		$(CMD_ECHO) "Websphere Exists? (FAIL):   -d $(PATH_INSTALL_WEBSPHERE) # non-existent" ; \
		exit 7 ; \
	fi ;

	@$(call func_command_check,$(JAZZSM_CMD_IMCL))
	@$(CMD_ECHO) "Websphere Upgrade:          #In progress..."
	@$(CMD_SU) - $(JAZZSM_USER) -c "$(JAZZSM_CMD_IMCL) input \
		$(WAS_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
		{ $(CMD_ECHO) "Websphere Upgrade (FAIL):   $(CMD_SU) - $(JAZZSM_USER) -c \"$(JAZZSM_CMD_IMCL) input $(WAS_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	exit 8; }
	@$(CMD_ECHO) "Websphere Upgrade (OK):     $(CMD_SU) - $(JAZZSM_USER) -c \"$(JAZZSM_CMD_IMCL) input $(WAS_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\""
	@$(CMD_ECHO)


################################################################################
# INSTALL JAZZ FOR SERVICE MANAGEMENT
# NOTE:  THIS INCLUDES WEBSPHERE
################################################################################
install_jazzsm:		check_whoami \
					check_commands \
					create_jazzsm_user \
					prepare_jazzsm_install_media \
					create_jazzsm_install_response_file \
					create_root_path
	@$(call func_print_caption,"INSTALLING JAZZ FOR SERVICE MANAGEMENT")

	@if [ -d "$(PATH_INSTALL_WEBSPHERE)" ] ; \
	then \
		$(CMD_ECHO) "WebSphere Exists? (FAIL):-d $(PATH_INSTALL_WEBSPHERE) # already exists" ; \
		exit 4; \
	else \
		$(CMD_ECHO) "WebSphere Exists? (OK):  -d $(PATH_INSTALL_WEBSPHERE) # non-existent" ; \
	fi ;

	@if [ -d "$(PATH_INSTALL_JAZZSM)" ] ; \
	then \
		$(CMD_ECHO) "JazzSM Exists? (FAIL):   -d $(PATH_INSTALL_JAZZSM) # already exists" ; \
		exit 5; \
	else \
		$(CMD_ECHO) "JazzSM Exists? (OK):     -d $(PATH_INSTALL_JAZZSM) # non-existent" ; \
	fi ;

	@$(call func_mkdir,$(JAZZSM_USER),$(JAZZSM_GROUP),755,$(PATH_INSTALL_WEBSPHERE))
	@$(call func_mkdir,$(JAZZSM_USER),$(JAZZSM_GROUP),755,$(PATH_INSTALL_JAZZSM))

	@$(CMD_ECHO) "JazzSM Install:          #In progress... (could take a while, run 'top' to watch)"
	@$(CMD_SU) - $(JAZZSM_USER) -c "$(JAZZSM_USERINSTC) input \
		$(JAZZSM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
		{ $(CMD_ECHO) "JazzSM Install (FAIL):   $(CMD_SU) - $(JAZZSM_USER) -c \"$(JAZZSM_CMD_IMCL) input $(JAZZSM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
		exit 6; }
	@$(CMD_ECHO) "JazzSM Install (OK):     $(CMD_SU) - $(JAZZSM_USER) -c \"$(JAZZSM_USERINSTC) input $(JAZZSM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\""
	@$(CMD_ECHO)

################################################################################
# CONFIGURE ROOT CA
################################################################################
configure_root_ca:	check_whoami \
				check_commands

	@$(call func_print_caption,"CONFIGURING ROOT CA")
	@$(call func_file_must_exist,$(JAZZSM_USER),$(WAS_CMD_WSADMIN))

	-@$(CMD_SU) - $(JAZZSM_USER) -c "$(WAS_CMD_WSADMIN) -lang jython -c \"AdminTask.retrieveSignerFromPort('[-host ldaps -port 636 -certificateAlias envCa -keyStoreName NodeDefaultTrustStore]')\""

################################################################################
# CONFIGURE HEAP SIZE 
################################################################################
configure_heap_size:	check_whoami \
					create_jazzsm_java_heap_file \
						check_commands 	

	@$(call func_print_caption,"CONFIGURING MEMORY HEAP SETTINGS")
	@$(call func_file_must_exist,$(JAZZSM_USER),$(WAS_CMD_WSADMIN))

	@$(CMD_SU) - $(JAZZSM_USER) -c "$(WAS_CMD_WSADMIN) -lang jython -f $(JAZZSM_JAVA_CONFIG_FILE)"
	@$(CMD_ECHO)




################################################################################
# CONFIGURE JAZZSM
################################################################################
configure_jazzsm:	check_whoami \
					check_commands \
					create_jazzsm_user

	@$(call func_print_caption,"CONFIGURING JAZZSM")
	@$(call func_file_must_exist,$(JAZZSM_USER),$(JAZZSM_SOAP_PROPS))
	@$(call func_mv_must_exist,$(JAZZSM_USER),$(JAZZSM_SOAP_PROPS),$(JAZZSM_SOAP_PROPS).$(TIMESTAMP))

	@$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_GREP) -v '^com.ibm.SOAP.securityEnabled=\|^com.ibm.SOAP.loginUserid=\|^com.ibm.SOAP.loginPassword' $(JAZZSM_SOAP_PROPS).$(TIMESTAMP) > $(JAZZSM_SOAP_PROPS)" || { $(CMD_ECHO) \
		"Remove lines (FAIL):     $(CMD_SU) - $(JAZZSM_USER) -c \"$(CMD_GREP) -v '^com.ibm.SOAP.securityEnabled=\|^com.ibm.SOAP.loginUserid=\|^com.ibm.SOAP.loginPassword' $(JAZZSM_SOAP_PROPS).$(TIMESTAMP) > $(JAZZSM_SOAP_PROPS)\"" ; \
		exit 7; }
	@$(CMD_ECHO) "Remove lines (OK):       $(CMD_SU) - $(JAZZSM_USER) -c \"$(CMD_GREP) -v '^com.ibm.SOAP.securityEnabled=\|^com.ibm.SOAP.loginUserid=\|^com.ibm.SOAP.loginPassword' $(JAZZSM_SOAP_PROPS).$(TIMESTAMP) > $(JAZZSM_SOAP_PROPS)\""

	@$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_PRINTF) \"\n$(JAZZSM_SOAP_SECURITY)=$(JAZZSM_SOAP_SECURITY_V)\n$(JAZZSM_SOAP_USERID)=$(JAZZSM_SOAP_USERID_V)\n$(JAZZSM_SOAP_PASSWORD)=$(JAZZSM_SOAP_PASSWORD_V)\n\" >> $(JAZZSM_SOAP_PROPS)" || { $(CMD_ECHO) \
		"Add lines (FAIL):        $(CMD_SU) - $(JAZZSM_USER) -c \"$(CMD_PRINTF) \"\n$(JAZZSM_SOAP_SECURITY)=$(JAZZSM_SOAP_SECURITY_V)\n$(JAZZSM_SOAP_USERID)=$(JAZZSM_SOAP_USERID_V)\n$(JAZZSM_SOAP_PASSWORD)=<password>\n\" >> $(JAZZSM_SOAP_PROPS)\"" ; \
		exit 8; }
	@$(CMD_ECHO) "Add lines (OK):          $(CMD_SU) - $(JAZZSM_USER) -c \"$(CMD_PRINTF) \"\n$(JAZZSM_SOAP_SECURITY)=$(JAZZSM_SOAP_SECURITY_V)\n$(JAZZSM_SOAP_USERID)=$(JAZZSM_SOAP_USERID_V)\n$(JAZZSM_SOAP_PASSWORD)=<password>\n\" >> $(JAZZSM_SOAP_PROPS)\""

	@$(CMD_SU) - $(JAZZSM_USER) -c "$(JAZZSM_CMD_PWDENCODER) $(JAZZSM_SOAP_PROPS) $(JAZZSM_SOAP_PASSWORD)" || { $(CMD_ECHO) \
		"Password Encrypt (FAIL): $(CMD_SU) - $(JAZZSM_USER) -c \"$(JAZZSM_CMD_PWDENCODER) $(JAZZSM_SOAP_PROPS) $(JAZZSM_SOAP_PASSWORD)\"" ; \
		exit 9; }
	@$(CMD_ECHO) "Password Encrypt (OK):   $(CMD_SU) - $(JAZZSM_USER) -c \"$(JAZZSM_CMD_PWDENCODER) $(JAZZSM_SOAP_PROPS) $(JAZZSM_SOAP_PASSWORD)\""
	@$(CMD_ECHO) 

################################################################################
# CONFIGURE TLS VERSION 1.2
################################################################################
configure_TLSv1_2:	check_whoami \
					check_commands \
					create_jazzsm_user

	@$(call func_print_caption,"CONFIGURING TLS VERSION 1.2")
	@$(call func_file_must_exist,$(JAZZSM_USER),$(WAS_CMD_WSADMIN))

	@$(CMD_SU) - $(JAZZSM_USER) -c "$(WAS_CMD_WSADMIN) -lang jython -c \"AdminTask.modifySSLConfig('[-alias NodeDefaultSSLSettings -scopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -keyStoreName NodeDefaultKeyStore -keyStoreScopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -trustStoreName NodeDefaultTrustStore -trustStoreScopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -jsseProvider IBMJSSE2 -sslProtocol $(JAZZSM_SSLCLIENT_PROTO_V) -clientAuthentication false -clientAuthenticationSupported false -securityLevel HIGH -enabledCiphers ]')\"" || { $(CMD_ECHO) \
		"Config TLSv1.2 (FAIL):   $(CMD_SU) - $(JAZZSM_USER) -c \"$(WAS_CMD_WSADMIN) -lang jython -c \"AdminTask.modifySSLConfig('[-alias NodeDefaultSSLSettings -scopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -keyStoreName NodeDefaultKeyStore -keyStoreScopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -trustStoreName NodeDefaultTrustStore -trustStoreScopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -jsseProvider IBMJSSE2 -sslProtocol $(JAZZSM_SSLCLIENT_PROTO_V) -clientAuthentication false -clientAuthenticationSupported false -securityLevel HIGH -enabledCiphers ]')\"\"" ; \
		exit 10; }
	@$(CMD_ECHO) "Config TLSv1.2 (OK):     $(CMD_SU) - $(JAZZSM_USER) -c \"$(WAS_CMD_WSADMIN) -lang jython -c \"AdminTask.modifySSLConfig('[-alias NodeDefaultSSLSettings -scopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -keyStoreName NodeDefaultKeyStore -keyStoreScopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -trustStoreName NodeDefaultTrustStore -trustStoreScopeName (cell):$(WAS_JAZZSM_CELL):(node):$(WAS_JAZZSM_NODE) -jsseProvider IBMJSSE2 -sslProtocol $(JAZZSM_SSLCLIENT_PROTO_V) -clientAuthentication false -clientAuthenticationSupported false -securityLevel HIGH -enabledCiphers ]')\"\""

	@$(call func_file_must_exist,$(JAZZSM_USER),$(JAZZSM_SSLCLIENT_PROPS))
	@$(call func_mv_must_exist,$(JAZZSM_USER),$(JAZZSM_SSLCLIENT_PROPS),$(JAZZSM_SSLCLIENT_PROPS).$(TIMESTAMP))

	@$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_GREP) -v '^$(JAZZSM_SSLCLIENT_PROTO)=' $(JAZZSM_SSLCLIENT_PROPS).$(TIMESTAMP) > $(JAZZSM_SSLCLIENT_PROPS)" || { $(CMD_ECHO) \
		"Remove lines (FAIL):     $(CMD_SU) - $(JAZZSM_USER) -c \"$(CMD_GREP) -v '^$(JAZZSM_SSLCLIENT_PROTO)=' $(JAZZSM_SSLCLIENT_PROPS).$(TIMESTAMP) > $(JAZZSM_SSLCLIENT_PROPS)\"" ; \
		exit 11; }
	@$(CMD_ECHO) "Remove lines (OK):       $(CMD_SU) - $(JAZZSM_USER) -c \"$(CMD_GREP) -v '^$(JAZZSM_SSLCLIENT_PROTO)=' $(JAZZSM_SSLCLIENT_PROPS).$(TIMESTAMP) > $(JAZZSM_SSLCLIENT_PROPS)\""

	@$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_PRINTF) \"\n$(JAZZSM_SSLCLIENT_PROTO)=$(JAZZSM_SSLCLIENT_PROTO_V)\n\" >> $(JAZZSM_SSLCLIENT_PROPS)" || { $(CMD_ECHO) \
		"Add lines (FAIL):        $(CMD_SU) - $(JAZZSM_USER) -c \"$(CMD_PRINTF) \\\"$(JAZZSM_SSLCLIENT_PROTO)=$(JAZZSM_SSLCLIENT_PROTO_V)\\\" >> $(JAZZSM_SSLCLIENT_PROPS)\"" ; \
		exit 12; }
	@$(CMD_ECHO) "Add lines (OK):          $(CMD_SU) - $(JAZZSM_USER) -c \"$(CMD_PRINTF) \\\"$(JAZZSM_SSLCLIENT_PROTO)=$(JAZZSM_SSLCLIENT_PROTO_V)\\\" >> $(JAZZSM_SSLCLIENT_PROPS)\""
	@$(CMD_ECHO)

################################################################################
# NATIVELY STOPPING JAZZSM, SO WE CAN CONFIGURE IT TO AUTOMATICALLY START
################################################################################
# NOTE: Installation Manager starts JazzSM, need to stop it before configuring
#       for systemd
stop_jazzsm_natively:	check_whoami \
						check_commands \
						create_jazzsm_user

	@$(call func_print_caption,"STOPPING JAZZSM NATIVELY")
	@if [ -d "$(PATH_INSTALL_JAZZSM)" ] ; \
	then \
		$(CMD_ECHO) "JazzSM Exists? (OK):     -d $(PATH_INSTALL_JAZZSM) # already exists" ; \
		$(CMD_SU) - $(JAZZSM_USER) -c "$(PATH_INSTALL_JAZZSM_STOP) $(WAS_JAZZSM_SERVERNAME) 1> /dev/null" || { $(CMD_ECHO) \
			"Native stop (FAIL):      $(CMD_SU) - $(JAZZSM_USER) -c \"$(PATH_INSTALL_JAZZSM_STOP) $(WAS_JAZZSM_SERVERNAME) 1> /dev/null\"" ; \
			exit 13; } ; \
		$(CMD_ECHO) "Native stop (OK):        $(CMD_SU) - $(JAZZSM_USER) -c \"$(PATH_INSTALL_JAZZSM_STOP) $(WAS_JAZZSM_SERVERNAME) 1> /dev/null\"" ; \
	else \
		$(CMD_ECHO) "JazzSM Exists? (OK):     -d $(PATH_INSTALL_JAZZSM) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# NATIVELY STARTING JAZZSM, SO WEBSPHERE PROFILES/COMPONENTS CAN BE UNINSTALLED
################################################################################
start_jazzsm_natively:	check_whoami \
						check_commands \
						create_jazzsm_user

	@$(call func_print_caption,"STARTING JAZZSM NATIVELY")
	@if [ -d "$(PATH_INSTALL_JAZZSM)" ] ; \
	then \
		$(CMD_ECHO) "JazzSM Exists? (OK):     -d $(PATH_INSTALL_JAZZSM) # already exists" ; \
		$(CMD_SU) - $(JAZZSM_USER) -c "$(PATH_INSTALL_JAZZSM_START) $(WAS_JAZZSM_SERVERNAME) 1> /dev/null" || { $(CMD_ECHO) \
			"Native start (FAIL):     $(CMD_SU) - $(JAZZSM_USER) -c \"$(PATH_INSTALL_JAZZSM_START) $(WAS_JAZZSM_SERVERNAME) 1> /dev/null\"" ; \
			exit 14; } ; \
		$(CMD_ECHO) "Native start (OK):       $(CMD_SU) - $(JAZZSM_USER) -c \"$(PATH_INSTALL_JAZZSM_START) $(WAS_JAZZSM_SERVERNAME) 1> /dev/null\"" ; \
	else \
		$(CMD_ECHO) "JazzSM Exists? (OK):     -d $(PATH_INSTALL_JAZZSM) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CONFIGURE JAZZSM TO AUTOSTART
################################################################################
autostarton_jazzsm:	check_whoami \
					check_commands

	@$(call func_print_caption,"CONFIGURING JAZZSM TO AUTOMATICALLY START")
	@if [ -d "$(PATH_INSTALL_WEBSPHERE)" ] ; \
	then \
		$(CMD_ECHO) "WebSphere Exists (OK):   -d $(PATH_INSTALL_WEBSPHERE) # exists" ; \
		\
		$(CMD_GREP) " 6" /etc/redhat-release 1> /dev/null; rc=$$? ; \
		if [ $$rc -eq 0 ] ; \
		then \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 6 / Not systemd" ; \
			\
			if [ -f "$(JAZZSM_ETC_INITD_FILE)" ] ; \
			then \
				$(CMD_ECHO) "/etc/init.d Script (OK): -f $(JAZZSM_ETC_INITD_FILE) # exists" ; \
			else \
				$(CMD_ECHO) "/etc/init.d Script (OK): -f $(JAZZSM_ETC_INITD_FILE) # non-existent so creating..." ; \
				$(CMD_ECHO) "$$JAZZSM_ETC_INITD_FILE_CONTENT" > $(JAZZSM_ETC_INITD_FILE) || { $(CMD_ECHO) \
					"Start/Stop Script (FAIL):#$(JAZZSM_ETC_INITD_FILE)" ; \
					exit 15; } ; \
				$(CMD_ECHO) "Start/Stop Script (OK):  #$(JAZZSM_ETC_INITD_FILE)" ; \
				\
				$(call func_chown,$(JAZZSM_ETC_INITD_USER),$(JAZZSM_ETC_INITD_GROUP),$(JAZZSM_ETC_INITD_FILE)) ; \
				$(call func_chmod,755,$(JAZZSM_ETC_INITD_FILE)) ; \
				\
				$(CMD_CHKCONFIG) --add $(JAZZSM_ETC_SERVICE) > /dev/null || { $(CMD_ECHO) \
					"Service chkconfig (FAIL):$(CMD_CHKCONFIG) --add $(JAZZSM_ETC_SERVICE)" ; \
					exit 16; } ; \
				$(CMD_ECHO) "Service chkconfig (OK):  $(CMD_CHKCONFIG) --add $(JAZZSM_ETC_SERVICE)" ; \
				\
				$(CMD_SERVICE) $(JAZZSM_ETC_SERVICE) start || { $(CMD_ECHO) \
					"jazzsm Start (FAIL):     $(CMD_SERVICE) $(JAZZSM_ETC_SERVICE) start" ; \
					exit 17; } ; \
				$(CMD_ECHO) "jazzsm Start (OK):       $(CMD_SERVICE) $(JAZZSM_ETC_SERVICE) start" ; \
			fi ; \
		else \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 7+ / systemd" ; \
			\
			if [ -f "$(JAZZSM_SYSTEMD_SCRIPT)" ] ; \
			then \
				$(CMD_ECHO) "systemd Script (OK):     #$(JAZZSM_SYSTEMD_SCRIPT) exists" ; \
			else \
				$(CMD_ECHO) "systemd Script (OK):     #$(JAZZSM_SYSTEMD_SCRIPT) non-existent so creating..." ; \
				$(CMD_ECHO) "$$JAZZSM_ETC_INITD_FILE_CONTENT" > $(JAZZSM_SYSTEMD_SCRIPT) || { $(CMD_ECHO) ; \
					"Start/Stop Script (FAIL):#$(JAZZSM_ETC_SERVICE) failed to configure" ; \
					exit 18; } ; \
				$(CMD_ECHO) "Start/Stop Script (OK):  #$(JAZZSM_ETC_SERVICE) configured" ; \
				\
				$(call func_chown,$(JAZZSM_USER),$(JAZZSM_GROUP),$(JAZZSM_SYSTEMD_SCRIPT)) ; \
				$(call func_chmod,755,$(JAZZSM_SYSTEMD_SCRIPT)) ; \
			fi ; \
			\
			\
			if [ -f "$(JAZZSM_SYSTEMD_SERVICE)" ] ; \
			then \
				$(CMD_ECHO) "systemd Service (OK):    #$(JAZZSM_SYSTEMD_SERVICE) exists" ; \
			else \
				$(CMD_ECHO) "systemd Service (OK):    #$(JAZZSM_SYSTEMD_SERVICE) non-existent so creating..." ; \
				$(CMD_ECHO) "$$ETC_SYSTEMD_JAZZSM_SERVICE_CONTENT" > $(JAZZSM_SYSTEMD_SERVICE) || { $(CMD_ECHO) ; \
					"jazzsm.service (FAIL):   #$(JAZZSM_SYSTEMD_SERVICE) failed to configure" ; \
					exit 19; } ; \
				$(CMD_ECHO) "jazzsm.service (OK):     #$(JAZZSM_SYSTEMD_SERVICE) configured" ; \
				$(call func_chmod,644,$(JAZZSM_SYSTEMD_SERVICE)) ; \
				\
				$(CMD_SYSTEMCTL) enable $(JAZZSM_ETC_SERVICE) || { $(CMD_ECHO) ; \
					"jazzsm Enable (FAIL):    $(CMD_SYSTEMCTL) enable $(JAZZSM_ETC_SERVICE)" ; \
					exit 20; } ; \
				$(CMD_ECHO) "jazzsm Enable (OK):      $(CMD_SYSTEMCTL) enable $(JAZZSM_ETC_SERVICE)" ; \
				\
				$(CMD_SYSTEMCTL) start $(JAZZSM_ETC_SERVICE) || { $(CMD_ECHO) ; \
					"jazzsm Start (FAIL):     $(CMD_SYSTEMCTL) start $(JAZZSM_ETC_SERVICE)" ; \
					exit 21; } ; \
				$(CMD_ECHO) "jazzsm Start (OK):       $(CMD_SYSTEMCTL) start $(JAZZSM_ETC_SERVICE)" ; \
			fi ; \
		fi ; \
	else \
		$(CMD_ECHO) "WebSphere Exists (OK):   -d $(PATH_INSTALL_WEBSPHERE) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CONFIGURE JAZZSM TO NOT AUTOSTART
################################################################################
autostartoff_jazzsm:	check_whoami \
						check_commands

	@$(call func_print_caption,"CONFIGURING JAZZSM TO NOT AUTOMATICALLY START")
	@if [ -d "$(PATH_INSTALL_WEBSPHERE)" ] ; \
	then \
		$(CMD_ECHO) "WebSphere Exists (OK):   -d $(PATH_INSTALL_WEBSPHERE) # exists" ; \
		\
		$(CMD_GREP) " 6" /etc/redhat-release 1> /dev/null; rc=$$? ; \
		if [ $$rc -eq 0 ] ; \
		then \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 6 / Not systemd" ; \
			\
			$(CMD_SERVICE) $(JAZZSM_ETC_SERVICE) stop || { $(CMD_ECHO) \
				"jazzsm Stop (FAIL):      $(CMD_SERVICE) $(JAZZSM_ETC_SERVICE) stop" ; \
				exit 22; } ; \
			$(CMD_ECHO) "jazzsm Stop (OK):        $(CMD_SERVICE) $(JAZZSM_ETC_SERVICE) stop" ; \
			\
			$(CMD_ECHO) "Service chkconfig:       $(CMD_CHKCONFIG) --del $(JAZZSM_ETC_SERVICE)" ; \
			$(CMD_CHKCONFIG) --del $(JAZZSM_ETC_SERVICE) ; \
			\
			$(CMD_ECHO) "Start/Stop Script:       $(CMD_RM) -f $(JAZZSM_ETC_INITD_FILE)" ; \
			$(CMD_RM) -f $(JAZZSM_ETC_INITD_FILE); \
		else \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 7+ / systemd" ; \
			\
			$(CMD_ECHO) "systemd Reload:          $(CMD_SYSTEMCTL) daemon-reload" ; \
			$(CMD_SYSTEMCTL) daemon-reload ; \
			\
			$(CMD_ECHO) "systemd Stop:            $(CMD_SYSTEMCTL) stop $(JAZZSM_ETC_SERVICE)" ; \
			$(CMD_SYSTEMCTL) stop $(JAZZSM_ETC_SERVICE) ; \
			\
			$(CMD_ECHO) "systemd Disable:         $(CMD_SYSTEMCTL) disable $(JAZZSM_ETC_SERVICE)" ; \
			$(CMD_SYSTEMCTL) disable $(JAZZSM_ETC_SERVICE) ; \
			\
			$(CMD_ECHO) "systemd Service (OK):    $(CMD_RM) -f $(JAZZSM_SYSTEMD_SERVICE)" ; \
			$(CMD_RM) -f $(JAZZSM_SYSTEMD_SERVICE); \
			$(CMD_ECHO) "systemd Script (OK):     $(CMD_RM) -f $(JAZZSM_SYSTEMD_SCRIPT)" ; \
			$(CMD_RM) -f $(JAZZSM_SYSTEMD_SCRIPT); \
		fi ; \
	else \
		$(CMD_ECHO) "WebSphere Exists (OK):   -d $(PATH_INSTALL_WEBSPHERE) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CREATE THE JAZZSM UNINSTALLATION RESPONSE FILE
################################################################################
create_jazzsm_uninstall_response_file:  check_commands \
										create_jazzsm_user \
										prepare_jazzsm_install_media

	@$(call func_print_caption,"CREATING JAZZSM UNINSTALLATION RESPONSE FILE")
	@$(call func_command_check,$(CMD_IBM_IMUTILSC))
	@$(CMD_ECHO) "Encrypt Password:        #$(CMD_IBM_IMUTILSC) encryptString..."
	@$(eval TEMP_WAS_JAZZSM_PASSWD_ENCRYPT=`$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_IBM_IMUTILSC) encryptString $(WAS_JAZZSM_PASSWD) -silent -noSplash"`)
	@$(CMD_ECHO) "Encrypt Password (OK):   #$(TEMP_WAS_JAZZSM_PASSWD_ENCRYPT) for $(WAS_JAZZSM_USER)"

	@$(CMD_ECHO) "$$JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE_CONTENT" | $(CMD_SED) -e "s/<WAS_JAZZSM_PASSWD>/$(TEMP_WAS_JAZZSM_PASSWD_ENCRYPT)/g" > $(JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "Svcs Resp File (FAIL):   #$(JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE)" ; \
		exit 23; }
	@$(CMD_ECHO) "Svcs Resp File (OK):     #$(JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE)"
	@$(call func_chmod,444,$(JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_jazzsm_uninstall_response_file:	check_commands
	@$(call func_print_caption,"REMOVING JAZZSM UNINSTALL RESPONSE FILE")
	@$(CMD_RM) -f $(JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# UNINSTALL JAZZ FOR SERVICE MANAGEMENT
################################################################################
uninstall_jazzsm:	check_whoami \
					check_commands \
					create_jazzsm_uninstall_response_file \
					autostartoff_jazzsm

	@$(call func_print_caption,"UNINSTALLING JAZZ FOR SERVICE MANAGEMENT")
	@if [ -d "$(PATH_INSTALL_WEBSPHERE)" ] ; \
	then \
		$(CMD_ECHO) "WebSphere Exists (OK):   -d $(PATH_INSTALL_WEBSPHERE) # exists" ; \
		\
		$(call func_command_check,$(CMD_IBM_MANAGEPROFILES)) ; \
		$(call func_command_check,$(JAZZSM_CMD_IMCL)) ; \
		\
		if [ `$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_IBM_MANAGEPROFILES) -listProfiles | $(CMD_GREP) [$(WAS_JAZZSM_PROFILE)] | $(CMD_WC) -l"` -gt 0 ] ; \
		then \
			$(CMD_ECHO) "JazzSM Profile Exists?   #$(WAS_JAZZSM_PROFILE) exists" ; \
			$(call func_websphere_profile_stop,$(JAZZSM_USER),$(PATH_INSTALL_WEBSPHERE),$(PATH_INSTALL_JAZZSM)/profile,$(WAS_JAZZSM_USER),$(WAS_JAZZSM_PASSWD),$(WAS_JAZZSM_SERVERNAME)) ; \
			\
			$(CMD_ECHO) "Services Uninstall:      #In progress..." ; \
			$(CMD_SU) - $(JAZZSM_USER) -c "$(JAZZSM_CMD_IMCL) input \
				$(JAZZSM_UNINSTALL_SERVICES_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
				{ $(CMD_ECHO) "Services Uninstall (FL): #Failure" ; \
				exit 24; } ; \
			$(CMD_ECHO) "Service Uninstall (OK):  #Complete" ; \
			$(CMD_ECHO) ; \
			\
			$(call func_websphere_profile_stop,$(JAZZSM_USER),$(PATH_INSTALL_WEBSPHERE),$(PATH_INSTALL_JAZZSM)/profile,$(WAS_JAZZSM_USER),$(WAS_JAZZSM_PASSWD),$(WAS_JAZZSM_SERVERNAME)) ; \
			$(call func_uninstall_im_package,$(JAZZSM_CMD_IMCL),$(JAZZSM_USER),$(PATH_REPOSITORY_JAZZSM_EXT_PACKAGE),JazzSM Extensions) ; \
			\
			$(CMD_RM) -rf $(PATH_INSTALL_JAZZSM) || { $(CMD_ECHO) \
				"rm JazzSM Dir (FAIL):    $(CMD_RM) -rf $(PATH_INSTALL_JAZZSM)" ; \
				exit 25; } ; \
			$(CMD_ECHO) "rm JazzSM Dir (OK):      $(CMD_RM) -rf $(PATH_INSTALL_JAZZSM)" ; \
			$(CMD_ECHO) ; \
			\
			$(call func_uninstall_im_package,$(JAZZSM_CMD_IMCL),$(JAZZSM_USER),$(PATH_REPOSITORY_JAZZSM_JVM_PACKAGE),WebSphere SDK Java) ; \
			$(CMD_ECHO) ; \
			\
			if [ `$(CMD_SU) - $(JAZZSM_USER) -c "$(CMD_IBM_MANAGEPROFILES) -listProfiles | $(CMD_GREP) -v [$(WAS_JAZZSM_PROFILE)] | $(CMD_WC) -l"` -eq 0 ] ; \
			then \
				$(call func_uninstall_im_package,$(JAZZSM_CMD_IMCL),$(JAZZSM_USER),$(PATH_REPOSITORY_JAZZSM_WAS_PACKAGE),WebSphere Application Server) ; \
			else \
				$(CMD_ECHO) "WebSphere Uninst (WARN): WebSphere NOT removed, other profiles exist" ; \
				$(CMD_ECHO) "NOTE:  To view profiles, run:  $(CMD_SU) - $(JAZZSM_USER) -c '$(CMD_IBM_MANAGEPROFILES) -listProfiles'" ; \
			fi ; \
			\
			$(CMD_RM) -rf $(PATH_INSTALL_WEBSPHERE) || { $(CMD_ECHO) \
				"rm WebSphere Dir (FAIL): $(CMD_RM) -rf $(PATH_INSTALL_WEBSPHERE)" ; \
				exit 26; } ; \
			$(CMD_ECHO) "rm WebSphere Dir (OK):   $(CMD_RM) -rf $(PATH_INSTALL_WEBSPHERE)" ; \
		else \
			$(CMD_ECHO) "JazzSM Profile Exists?   #$(WAS_JAZZSM_PROFILE) non-existent" ; \
			exit 27; \
		fi ; \
	else \
		$(CMD_ECHO) "WebSphere Exists (OK):   -d $(PATH_INSTALL_WEBSPHERE) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:	check_commands
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM) -rf /tmp/ciclogs_$(JAZZSM_USER)
#	@$(CMD_RM) -rf /tmp/cicdip_$(JAZZSM_USER) 
#	@$(CMD_RM) -rf /tmp/cicvolcache_$(JAZZSM_USER)
	@$(CMD_RM) -rf /tmp/javasharedresources /tmp/osgi_instance_location
	@$(CMD_ECHO)

