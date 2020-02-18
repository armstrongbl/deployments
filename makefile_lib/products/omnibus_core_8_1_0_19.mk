################################################################################
#                       _
#                      / \   ___ ___ _   _  ___  ___ ___
#                     / _ \ / __/ __| | | |/ _ \/ __/ __|
#                    / ___ \ (_| (__| |_| | (_) \__ \__ \
#                   /_/   \_\___\___|\__,_|\___/|___/___/
# 
#                    Accurate Operational Support Systems
#              (c) 2015-2020 Accuoss, Inc. All rights reserved.
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
# IBM Tivoli Netcool/OMNIbus 8.1.0.19
# Accuoss 
# February 17, 2020
################################################################################
MAKE_FILE	:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
MAKE_DIR	:= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
################################################################################
# MAKE_FILE NAME, MUST BE BEFORE ANY OTHER MAKEFILE INCLUDES
################################################################################

include ${MAKE_DIR}../include/includes

# REDHAT VERSION CHECK MUST BE AFTER INCLUDES FOR CMD_GREP
REDHAT6_CHECK	:=$(shell $(CMD_GREP) -i "release 6" /etc/redhat-release)

################################################################################
# INSTALLATION TUNABLES
################################################################################
MAKE_PRODUCT		= OMNIbus
MAKE_PRODUCT_PREREQS	= NOC
MAKE_FORCE		= FALSE

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL		:= /opt/IBM
PATH_INSTALL_NETCOOL	= $(PATH_INSTALL)/netcool
PATH_INSTALL_OMNIBUS	= $(PATH_INSTALL_NETCOOL)/omnibus

################################################################################
# TEMPORARY MAKE DIRECTORY
################################################################################
PATH_TEMP_BASE		:= $(MAKE_PRODUCT).make
PATH_TEMP_TEMPLATE	:= $(PATH_TMP)/$(PATH_TEMP_BASE).XXXXXXXX
PATH_TEMP_DIR		:= $(shell $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null)

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_INSTALL	:= $(PATH_MAKEFILE_REPOSITORY)/omnibus_core_8_1_0_5_install
PATH_REPOSITORY_UPGRADE	:= $(PATH_MAKEFILE_REPOSITORY)/omnibus_core_8_1_0_7_upgrade

PATH_REPOSITORY_OMNIBUS_PACKAGE=com.ibm.tivoli.omnibus.core_

################################################################################
# INSTALLATION USERS
################################################################################
OMNIBUS_USER		:= netcool
OMNIBUS_PASSWD		:= $(OMNIBUS_USER)
OMNIBUS_GROUP		:= ncoadmin
OMNIBUS_SHELL		:= /bin/bash
OMNIBUS_HOME		:= $(PATH_HOME)/$(OMNIBUS_USER)

OMNIBUS_BASHRC		:= $(OMNIBUS_HOME)/.bashrc
OMNIBUS_BASHPROFILE	:= $(OMNIBUS_HOME)/.bash_profile

OMNIBUS_IMSHARED	= $(OMNIBUS_HOME)/$(PATH_IM_SHARED_PATH)
OMNIBUS_CMD_IMCL	:= $(OMNIBUS_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)

OMNIBUS_LDD_CHECKS	= $(shell $(CMD_LS) $(PATH_INSTALL_OMNIBUS)/platform/linux2x86/bin*/nco* | $(CMD_GREP) -v env$)

ifdef REDHAT6_CHECK
OMNIBUS_PACKAGES	=	$(PACKAGES_COMMON) \
						audit-libs.x86_64 \
						expat.x86_64 \
						fontconfig.x86_64 \
						freetype.x86_64 \
						glibc.x86_64 \
						libICE.x86_64 \
						libSM.x86_64 \
						libgcc.x86_64 \
						libidn.x86_64 \
						libjpeg-turbo.x86_64 \
						libpng.x86_64\
						libstdc++.x86_64 \
						libuuid.x86_64 \
						libxcb.x86_64 \
						nss-softokn-freebl.x86_64 \
						pam.x86_64 \
						pam.i686 \
						zlib.x86_64 \
						libXi.x86_64 \
						libXtst.x86_64 \
						libX11.x86_64 \
						libXau.x86_64 \
						libXext.x86_64 \
						libXft.x86_64 \
						libXmu.x86_64 \
						libXp.x86_64 \
						libXpm.x86_64 \
						libXrender.x86_64 \
						libXt.x86_64 \
						openmotif.x86_64 \
						gtk2.x86_64 \
						compat-libstdc++.i686 \
						glibc.i686 \
						libgcc.i686 \
						libstdc++.i686 \
						libX11.i686
else
OMNIBUS_PACKAGES	=	$(PACKAGES_COMMON) \
						audit-libs.x86_64 \
						expat.x86_64 \
						fontconfig.x86_64 \
						freetype.x86_64 \
						glibc.x86_64 \
						libICE.x86_64 \
						libSM.x86_64 \
						libX11.x86_64 \
						libXau.x86_64 \
						libXext.x86_64 \
						libXft.x86_64 \
						libXmu.x86_64 \
						libXp.x86_64 \
						libXpm.x86_64 \
						libXrender.x86_64 \
						libXt.x86_64 \
						libgcc.x86_64 \
						libidn.x86_64 \
						libjpeg-turbo.x86_64 \
						libpng12.x86_64 \
						libstdc++.x86_64 \
						libuuid.x86_64 \
						libxcb.x86_64 \
						motif.x86_64 \
						nss-softokn-freebl.x86_64 \
						pam.x86_64 \
						pam.i686 \
						zlib.x86_64 \
						libXcursor.x86_64 \
						libXfixes.x86_64 \
						libXi.x86_64 \
						libXtst.x86_64 \
						gtk2.x86_64 \
						compat-libstdc++-33.i686 \
						glibc.i686 \
						libgcc.i686 \
						libstdc++.i686 \
						libX11.i686
endif

################################################################################
# NETCOOL CONFIGURATION
################################################################################
NETCOOL_PA_NAME=NCO_PA

################################################################################
# OMNIBUS CONFIGURATION
################################################################################
NETCOOL_SERVICE=nco

ETC_INITD_NCO=/etc/init.d/$(NETCOOL_SERVICE)
ETC_INITD_NCO_TEMPLATE=$(PATH_INSTALL_OMNIBUS)/install/startup/linux2x86/etc/rc.d/init.d/$(NETCOOL_SERVICE)

ETC_SYSTEMD_NCO_SCRIPT=$(PATH_INSTALL_NETCOOL)/bin/nco_init.sh
ETC_SYSTEMD_NCO_SERVICE=/etc/systemd/system/$(NETCOOL_SERVICE).service

ETC_PAM_USER=root
ETC_PAM_GROUP=root

ETC_PAMD_SYSAUTH=/etc/pam.d/system-auth
ETC_PAMD_NCO_OBJSERV=/etc/pam.d/nco_objserv
ETC_PAMD_NETCOOL=/etc/pam.d/netcool

NETCOOL_PA_NAME=NCO_PA
NETCOOL_PA_SECURE=N

ifneq ("$(wildcard /etc/SuSE-release)","")
	NETCOOL_STARTUP_KEEP=SUSE
	NETCOOL_STARTUP_REMOVE=REDHAT
else
	NETCOOL_STARTUP_KEEP=REDHAT
	NETCOOL_STARTUP_REMOVE=SUSE
endif

NETCOOL_LEGACY_LICENSE_FILE=27000@localhost

NETCOOL_BIN_IGEN=$(PATH_INSTALL_NETCOOL)/bin/nco_igen

NETCOOL_ETC_DEFAULT_OMNIDAT=$(PATH_INSTALL_NETCOOL)/etc/default/omni.dat
NETCOOL_ETC_INTERFACES_LINUX=$(PATH_INSTALL_NETCOOL)/etc/interfaces.linux2x86
NETCOOL_ETC_INTERFACES=$(PATH_INSTALL_NETCOOL)/etc/interfaces
NETCOOL_ETC_OMNIDAT=$(PATH_INSTALL_NETCOOL)/etc/omni.dat

OMNIBUS_OS_SERVER=NCOMS

OMNIBUS_BIN_DBINIT=$(PATH_INSTALL_OMNIBUS)/bin/nco_dbinit
OMNIBUS_BIN_PASTATUS=$(PATH_INSTALL_OMNIBUS)/bin/nco_pa_status

OMNIBUS_ETC_DEFAULT_PACONF=$(PATH_INSTALL_OMNIBUS)/etc/default/nco_pa.conf
OMNIBUS_ETC_PACONF=$(PATH_INSTALL_OMNIBUS)/etc/nco_pa.conf

################################################################################
# COMPUTED BASELINE CHECKSUMS
################################################################################
NETCOOL_ETC_DEFAULT_OMNIDAT_B	:= `$(CMD_SHA512SUM) $(NETCOOL_ETC_DEFAULT_OMNIDAT) | $(CMD_CUT) -d" " -f1`
NETCOOL_ETC_OMNIDAT_B			:= `$(CMD_SHA512SUM) $(NETCOOL_ETC_OMNIDAT) | $(CMD_CUT) -d" " -f1`

OMNIBUS_ETC_DEFAULT_PACONF_B	:= `$(CMD_SHA512SUM) $(OMNIBUS_ETC_DEFAULT_PACONF) | $(CMD_CUT) -d" " -f1`
OMNIBUS_ETC_PACONF_B			:= `$(CMD_SHA512SUM) $(OMNIBUS_ETC_PACONF) | $(CMD_CUT) -d" " -f1`

################################################################################
# ULIMIT FILES / VALUES
################################################################################
OMNIBUS_NOFILE_FILE		:= $(PATH_LIMITS)/91-nofile.conf
OMNIBUS_NOFILE_FILE_CONTENT	:= "\
*          soft    nofile     131073\n\
*          hard    nofile     131073\n"

OMNIBUS_NPROC_FILE		:= $(PATH_LIMITS)/90-nproc.conf
OMNIBUS_NPROC_FILE_CONTENT	:= "\
*          soft    nproc     131073\n\
*          hard    nproc     131073\n\
root       soft    nproc     unlimited\n"

################################################################################
# SERVER INFORMATION
################################################################################
HOST_FQDN	:= $(shell $(CMD_HOSTNAME) -f)
TIMESTAMP	= $(shell $(CMD_DATE) +'%Y%m%d_%H%M%S')

################################################################################
# INSTALLATION MEDIA, DESCRIPTIONS, FILES, AND CHECKSUMS
################################################################################
MEDIA_ALL_DESC	=	\t$(MEDIA_STEP1_D)\n \
					\t$(MEDIA_STEP2_D)\n \
					\t$(MEDIA_STEP3_D)\n

MEDIA_ALL_FILES	=	$(MEDIA_STEP1_F) \
					$(MEDIA_STEP2_F) \
					$(MEDIA_STEP3_F)

MEDIA_STEP1_D	:= IBM Prerequisite Scanner V1.2.0.17, Build 20150827
MEDIA_STEP2_D	:= IBM Tivoli Netcool OMNIbus 8.1.0.5 Core Linux 64bit Multilingual\n\t\t(CN8HFML) 
MEDIA_STEP3_D	:= IBM Tivoli Netcool OMNIbus 8.1.0 Fix Pack 7 Core Linux 64bit\n\t\t Multilingual

MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/precheck_unix_20150827.tar
MEDIA_STEP2_F	:= $(PATH_MAKEFILE_MEDIA)/TVL_NTCL_OMN_V8.1.0.19_CORE_LNX_M.zip
#MEDIA_STEP3_F	:= $(PATH_MAKEFILE_MEDIA)/8.1.0-TIV-OMNIbusCore-linux-x86_64-FP0007.zip

MEDIA_STEP1_B	:= fda01aa083b92fcb6f25a7b71058dc045b293103731ca61fda10c73499f1473ef59608166b236dcf802ddf576e7469af0ec063215326e620092c1aeeb1d19186
MEDIA_STEP2_B	:= 36d779246309bb511489e0bfd90c01f38073a4feb45706e9e5185de1deca5cc33df0b7da35c06a8216f4d13cbf16cfab55fa3b253993fd34357763392b8e8cd2
#MEDIA_STEP3_B	:= 5324ee5f3307ea719fd06642da0f0b2f1383cd96bc9827c52748b25c3e24c38c46da25c1fffcf6d22a9bffb0a6628bbf8daff556a3b5f4300f304ab4eedafcfa

################################################################################
# COMMAND TO BE INSTALLED BEFORE USE
################################################################################
#CMD_IBM_IMUTILSC	:= $(PATH_REPOSITORY_INSTALL)/im.linux.x86_64/tools/imutilsc

################################################################################
# OMNIBUS RESPONSE FILE TEMPLATE (INSTALL)
################################################################################
OMNIBUS_INSTALL_RESPONSE_FILE=$(PATH_TMP)/omnibus_install_response.xml
define OMNIBUS_INSTALL_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(OMNIBUS_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_INSTALL)/OMNIbusRepository'/>
  </server>
  <profile id='IBM Netcool Core Components' installLocation='$(PATH_INSTALL_NETCOOL)'> 
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.migratedata,com.ibm.tivoli.omnibus.core' value='false'/>
  </profile>
  <install>
    <!-- IBM Tivoli Netcool/OMNIbus 8.1.0.5 -->
    <offering profile='IBM Netcool Core Components' id='com.ibm.tivoli.omnibus.core' version='5.50.49.20151123_1445' features='nco_core_feature,nco_admin_gui_feature,nco_admin_tools_feature,nco_tec_migration,nco_operator_gui_feature,nco_objserv_feature,nco_g_objserv_feature,nco_bridgeserv_feature,nco_proxyserv_feature,nco_pa_feature,nco_probes_support_feature,nco_gateways_support_feature,nco_mib_manager_feature,nco_extensions_feature'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
</agent-input>
endef
export OMNIBUS_INSTALL_RESPONSE_FILE_CONTENT

################################################################################
# OMNIBUS RESPONSE FILE TEMPLATE (UPGRADE)
################################################################################
OMNIBUS_UPGRADE_RESPONSE_FILE=$(PATH_TMP)/omnibus_upgrade_response.xml
define OMNIBUS_UPGRADE_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(OMNIBUS_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_UPGRADE)/OMNIbusRepository/composite'/>
  </server>
  <profile id='IBM Netcool Core Components' installLocation='$(PATH_INSTALL_NETCOOL)'>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.migratedata,com.ibm.tivoli.omnibus.core' value='false'/>
  </profile>
  <install>
    <!-- IBM Tivoli Netcool/OMNIbus 8.1.0.7 -->
    <offering profile='IBM Netcool Core Components' id='com.ibm.tivoli.omnibus.core' version='5.50.54.20160311_1427' features='nco_core_feature,nco_admin_gui_feature,nco_admin_tools_feature,nco_bridgeserv_feature,nco_extensions_feature,nco_g_objserv_feature,nco_gateways_support_feature,nco_mib_manager_feature,nco_objserv_feature,nco_operator_gui_feature,nco_pa_feature,nco_probes_support_feature,nco_proxyserv_feature,nco_tec_migration'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
</agent-input>
endef
export OMNIBUS_UPGRADE_RESPONSE_FILE_CONTENT

################################################################################
# OMNIBUS PROCESS AGENT CONFIGURATION FILE
################################################################################
define OMNIBUS_PA_CONF_CONTENT
#
# Process Agent Daemon Configuration File for Standalone Predictive Insights
#

#
# List of processes
#
nco_process 'MasterObjectServer'
{
	Command '$$OMNIHOME/bin/nco_objserv -name $(OMNIBUS_OS_SERVER) -pa $(NETCOOL_PA_NAME)' run as '$(OMNIBUS_USER)'
	Host		=	'$(HOST_FQDN)'
	Managed		=	True
	RestartMsg	=	'$${NAME} running as $${EUID} has been restored on $${HOST}.'
	AlertMsg	=	'$${NAME} running as $${EUID} has died on $${HOST}.'
	RetryCount	=	0
	ProcessType	=	PaPA_AWARE
}

#
# List of Services
#
# NOTE:	To ensure that the service is started automatically, change the
# 	"ServiceStart" attribute to "Auto".
#
nco_service 'Core'
{
	ServiceType	=	Master
	ServiceStart	=	Auto
	process 'MasterObjectServer' NONE
}

#
# This service should be used to store processs that you want to temporarily
# disable. Do not change the ServiceType or ServiceStart settings of this
# process.
#
nco_service 'InactiveProcesses'
{
	ServiceType	=	Non-Master
	ServiceStart	=	Non-Auto
}

#
# ROUTING TABLE
#
# 'user'       -   (optional) only required for secure mode PAD on target host
#                  'user' must be member of UNIX group 'ncoadmin'
# 'password'   -   (optional) only required for secure mode PAD on target host
#                  use nco_pa_crypt to encrypt.
nco_routing
{
	host '$(HOST_FQDN)' '$(NETCOOL_PA_NAME)'
}
endef
export OMNIBUS_PA_CONF_CONTENT

################################################################################
# SYSTEMD SERVICE CONFIGURATION FILE
################################################################################
define ETC_SYSTEMD_NCO_SERVICE_CONTENT
[Unit]
Description=Netcool OMNIbus Services
After=network.target

[Service]
ExecStart=$(ETC_SYSTEMD_NCO_SCRIPT) start
ExecStop=$(ETC_SYSTEMD_NCO_SCRIPT) stop
ExecReload=$(ETC_SYSTEMD_NCO_SCRIPT) reload
Restart=always
Type=forking

[Install]
WantedBy=default.target
endef
export ETC_SYSTEMD_NCO_SERVICE_CONTENT

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
					theuninstall \
					postuninstall

verify:			

preinstallchecks:	check_commands \
					check_media_exists \
					check_media_checksums \
					check_prerequisites

preinstall:			set_limits

theinstall:			install_omnibus \
					confirm_shared_libraries \
					upgrade_omnibus \
					configure_omnibus \
					autostarton_omnibus

postinstall:		clean

preuninstallchecks:	check_commands \
					check_media_exists \
					check_media_checksums

preuninstall:

theuninstall:		autostartoff_omnibus \
					uninstall_omnibus

postuninstall:		remove_netcool_path \
					remove_root_path \
					clean

clean:				remove_temp_dir \
					remove_omnibus_install_response_file \
					remove_omnibus_upgrade_response_file \
					clean_tmp

scrub:				uninstall \
					remove_limits \
					clean

# WARNING scrub_users WILL REMOVE USERS AND HOME DIRECTORIES INCLUDING ALL
# CONTENT AND ANY INSTALL MANAGERS IN SAME.  IF THE SAME USERNAME IS USED
# FOR MORE THAN ONE PRODUCT INSTALL, THEN THIS SHOULD BE DONE WITH EXTREME
# CAUTION
scrub_users:		remove_omnibus_group \
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
	@$(call func_check_file_cksum,$(MEDIA_STEP2_F),$(MEDIA_STEP2_B))
	#@$(call func_check_file_cksum,$(MEDIA_STEP3_F),$(MEDIA_STEP3_B))
	@$(CMD_ECHO)

################################################################################
# INSTALL PREREQUISITE PACKAGES
################################################################################
install_packages:	check_whoami
	@$(call func_print_caption,"INSTALLING PREREQUISITE PACKAGES")
	@$(call func_install_packages,$(OMNIBUS_PACKAGES))
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
	@$(call func_print_caption,"CHECKING PREREQUISITES FOR OMNIBUS")
	@$(call func_tar_xf_to_new_dir,root,root,755,$(MEDIA_STEP1_F),$(PATH_TEMP_DIR)/$(MAKE_PRODUCT))
	@$(CMD_ECHO) "Prereq Check:            $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s"
	@$(CMD_ECHO)
	@$(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s; rc=$$? ; \
	if [ $$rc -ne 0 -a $$rc -ne 3 ] ; \
	then \
		$(CMD_ECHO) "Prereq Check (FAIL):     $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s" ; \
		if [ "$(MAKE_FORCE)" != "TRUE" ] ; \
		then \
			exit 2; \
		else \
			$(CMD_ECHO) "Prereq Check (WARN):      MAKE_FORCE=TRUE # so continuing" ; \
		fi ; \
	else \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "Prereq Check (OK):       $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s" ; \
	fi
	@$(CMD_ECHO)

################################################################################
# SET ULIMITS
################################################################################
set_limits:		check_whoami \
				check_commands
	@$(call func_print_caption,"SETTING LIMITS")
	@$(call func_set_limits,$(OMNIBUS_NPROC_FILE),$(OMNIBUS_NPROC_FILE_CONTENT))
	@$(call func_set_limits,$(OMNIBUS_NOFILE_FILE),$(OMNIBUS_NOFILE_FILE_CONTENT))
	@$(CMD_ECHO)

################################################################################
# REMOVE ULIMITS
################################################################################
remove_limits:		check_whoami \
					check_commands
	@$(call func_print_caption,"REMOVING LIMITS")
	@$(CMD_RM) -f $(OMNIBUS_NPROC_FILE)
	@$(CMD_RM) -f $(OMNIBUS_NOFILE_FILE)
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
# CREATE THE NETCOOL PATH DIRECTORY IF IT DOESN'T EXIST
################################################################################
create_netcool_path:	check_whoami \
						check_commands \
						create_omnibus_user
	@$(call func_print_caption,"CREATING NETCOOL INSTALL DIRECTORY IF NEEDED")
	@$(call func_mkdir,$(OMNIBUS_USER),$(OMNIBUS_GROUP),755,$(PATH_INSTALL_NETCOOL))
	@$(CMD_ECHO)

# if empty remove path, else backup with timestamp to preserve custom artifacts
remove_netcool_path:	check_whoami \
						check_commands
	@$(call func_print_caption,"REMOVING NETCOOL INSTALL DIRECTORY IF EMPTY")
	@$(call func_rmdir_if_empty,$(PATH_INSTALL_NETCOOL))
	@$(call func_mv_if_exists,root,$(PATH_INSTALL_NETCOOL),$(PATH_INSTALL_NETCOOL).$(TIMESTAMP))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE GROUPS
################################################################################
create_omnibus_group:	check_whoami \
						check_commands
	@$(call func_print_caption,"CONFIRMING/CREATING OMNIBUS GROUP")
	@$(call func_create_group,$(OMNIBUS_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# REMOVE GROUPS
################################################################################
remove_omnibus_group:	check_whoami \
						check_commands \
						remove_omnibus_user
	@$(call func_print_caption,"REMOVING OMNIBUS GROUP")
	@$(call func_remove_group,$(OMNIBUS_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE USERS
################################################################################
create_omnibus_user:	check_whoami \
						check_commands \
						create_omnibus_group
	@$(call func_print_caption,"CONFIRMING/CREATING OMNIBUS USER")
	@$(call func_create_user,$(OMNIBUS_USER),$(MAKE_PRODUCT),$(OMNIBUS_GROUP),$(OMNIBUS_HOME),$(OMNIBUS_SHELL),$(OMNIBUS_PASSWD))

	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),PATH,$(PATH_INSTALL_OMNIBUS)/bin)
	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHPROFILE),PATH,$(PATH_INSTALL_OMNIBUS)/bin)

################################################################################
# As instructed by PI Installation Guide, do not set NCHOME if OMNIbus
# and PI are on the same server owned by same user.  "Setting NCHOME may cause
# the probe to point to the wrong location and not run."
################################################################################
#	@$(call func_setenv_set_and_export_in_file,$(OMNIBUS_USER),$(OMNIBUS_BASHRC),NCHOME,$(PATH_INSTALL_NETCOOL),644)
#	@$(call func_setenv_set_and_export_in_file,$(OMNIBUS_USER),$(OMNIBUS_BASHPROFILE),NCHOME,$(PATH_INSTALL_NETCOOL),644)

	@$(call func_setenv_set_and_export_in_file,$(OMNIBUS_USER),$(OMNIBUS_BASHRC),OMNIHOME,$(PATH_INSTALL_OMNIBUS),644)
	@$(call func_setenv_set_and_export_in_file,$(OMNIBUS_USER),$(OMNIBUS_BASHPROFILE),OMNIHOME,$(PATH_INSTALL_OMNIBUS),644)

	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),LD_LIBRARY_PATH,/usr/lib64)
	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),LD_LIBRARY_PATH,/usr/lib)
	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_NETCOOL)/platform/linux2x86/lib)
	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_NETCOOL)/platform/linux2x86/lib64)
	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_OMNIBUS)/platform/linux2x86/lib)
	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_OMNIBUS)/platform/linux2x86/lib64)
	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_NETCOOL)/platform/linux2x86/jre_1.7.0/jre/bin/j9vm)
	@$(call func_setenv_append_and_export_in_file,$(OMNIBUS_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_NETCOOL)/platform/linux2x86/jre64_1.7.0/jre/bin/j9vm)
	@$(CMD_ECHO)

################################################################################
# REMOVE USERS
################################################################################
remove_omnibus_user:	check_whoami \
						check_commands
	@$(call func_print_caption,"REMOVING OMNIBUS USER")
	@$(call func_remove_user,$(OMNIBUS_USER),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# PREPARE NETCOOL/OMNIBUS CORE MEDIA (INSTALLATION)
################################################################################
prepare_omnibus_install_media:	check_whoami \
								check_commands \
								create_omnibus_user

	@$(call func_print_caption,"PREPARING NETCOOL/OMNIBUS CORE MEDIA (INSTALLATION)")
	@$(call func_unzip_to_new_dir,$(OMNIBUS_USER),$(OMNIBUS_GROUP),755,$(MEDIA_STEP2_F),$(PATH_REPOSITORY_INSTALL))
	@$(CMD_ECHO)

################################################################################
# CREATE OMNIBUS RESPONSE FILE (INSTALLATION)
################################################################################
create_omnibus_install_response_file:	check_whoami \
										check_commands

	@$(call func_print_caption,"CREATING OMNIBUS INSTALLATION RESPONSE FILE")
	@$(CMD_ECHO) "$$OMNIBUS_INSTALL_RESPONSE_FILE_CONTENT" > $(OMNIBUS_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "OMNIbus Resp File (FAIL):#$(OMNIBUS_INSTALL_RESPONSE_FILE)" ; \
		exit 3; }
	@$(CMD_ECHO) "OMNIbus Resp File (OK):  #$(OMNIBUS_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(OMNIBUS_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_omnibus_install_response_file:	check_commands
	@$(call func_print_caption,"REMOVING OMNIBUS INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(OMNIBUS_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# INSTALL NETCOOL/OMNIBUS CORE AS $(OMNIBUS_USER)
################################################################################
install_omnibus:		check_whoami \
						check_commands \
						prepare_omnibus_install_media \
						create_omnibus_install_response_file \
						create_omnibus_user \
						create_root_path \
						create_netcool_path

	@$(call func_print_caption,"INSTALLING NETCOOL/OMNIBUS")
	@if [ -d "$(PATH_INSTALL_OMNIBUS)" ] ; \
	then \
		$(CMD_ECHO) "OMNIbus Exists? (WARN):  -d $(PATH_INSTALL_OMNIBUS) # already exists" ; \
	else \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # non-existent" ; \
		$(call func_prepare_installation_manager,$(OMNIBUS_USER),$(OMNIBUS_HOME),$(PATH_REPOSITORY_INSTALL)/im.linux.x86_64) ; \
		$(call func_command_check,$(OMNIBUS_CMD_IMCL)) ; \
		\
		$(CMD_ECHO) "OMNIbus Install:         #In progress..." ; \
		$(CMD_SU) - $(OMNIBUS_USER) -c "$(OMNIBUS_CMD_IMCL) input \
			$(OMNIBUS_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
			{ $(CMD_ECHO) "OMNIbus Install: (FAIL): $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) input $(OMNIBUS_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
			exit 4; } ; \
		$(CMD_ECHO) "OMNIbus Install (OK):    $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) input $(OMNIBUS_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	fi ;

################################################################################
# CONFIRM SHARED LIBRARIES
################################################################################
confirm_shared_libraries:	check_whoami \
							check_commands

	@$(call func_print_caption,"CONFIRMING SHARED LIBRARIES FOR NETCOOL/OMNIBUS")
	@$(foreach itr_x,$(OMNIBUS_LDD_CHECKS),\
		$(CMD_PRINTF) "Shared Lib Check:        $(CMD_SU) - $(OMNIBUS_USER) -c \"$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found\"\n" ; \
		$(CMD_SU) - $(OMNIBUS_USER) -c "$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found"; $(CMD_TEST) $$? -lt 2; \
	)

	@$(foreach itr_x,$(OMNIBUS_LDD_CHECKS),\
		$(CMD_SU) - $(OMNIBUS_USER) -c "$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found 1> /dev/null 2>&1"; $(CMD_TEST) $$? -eq 1 || { \
			$(CMD_ECHO) "Shared Lib Check (FAIL): #Missing shared library dependencies"; \
			exit 5; \
		} ; \
	)

	@$(CMD_ECHO) "Shared Lib Check (OK):   #No missing shared library dependencies"
	@$(CMD_ECHO)

################################################################################
# PREPARE NETCOOL/OMNIBUS CORE MEDIA (UPGRADE)
################################################################################
prepare_omnibus_upgrade_media:	check_whoami \
								check_commands \
								create_omnibus_user

	@$(call func_print_caption,"PREPARING NETCOOL/OMNIBUS CORE MEDIA (UPGRADE)")
	@$(call func_unzip_to_new_dir,$(OMNIBUS_USER),$(OMNIBUS_GROUP),755,$(MEDIA_STEP3_F),$(PATH_REPOSITORY_UPGRADE))
	@$(CMD_ECHO)

################################################################################
# CREATE OMNIBUS RESPONSE FILE (UPGRADE)
################################################################################
create_omnibus_upgrade_response_file:	check_whoami \
										check_commands

	@$(call func_print_caption,"CREATING OMNIBUS UPGRADE RESPONSE FILE")
	@$(CMD_ECHO) "$$OMNIBUS_UPGRADE_RESPONSE_FILE_CONTENT" > $(OMNIBUS_UPGRADE_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "OMNIbus Resp File (FAIL):#$(OMNIBUS_UPGRADE_RESPONSE_FILE)" ; \
		exit 6; }
	@$(CMD_ECHO) "OMNIbus Resp File (OK):  #$(OMNIBUS_UPGRADE_RESPONSE_FILE)"
	@$(call func_chmod,444,$(OMNIBUS_UPGRADE_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_omnibus_upgrade_response_file:   check_commands
	@$(call func_print_caption,"REMOVING OMNIBUS UPGRADE RESPONSE FILE")
	@$(CMD_RM) -f $(OMNIBUS_UPGRADE_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# UPGRADE NETCOOL/OMNIBUS CORE AS $(OMNIBUS_USER)
################################################################################
upgrade_omnibus:		check_whoami \
						check_commands \
						prepare_omnibus_upgrade_media \
						create_omnibus_upgrade_response_file

	@$(call func_print_caption,"UPGRADING OMNIBUS")
	@if [ -d "$(PATH_INSTALL_OMNIBUS)" ] ; \
	then \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # already exists" ; \
	else \
		$(CMD_ECHO) "OMNIbus Exists? (FAIL):  -d $(PATH_INSTALL_OMNIBUS) # non-existent" ; \
		exit 7; \
	fi ;

	@$(call func_command_check,$(OMNIBUS_CMD_IMCL))

	@$(CMD_ECHO) "OMNIbus Upgrade:         #In progress..."
	@$(CMD_SU) - $(OMNIBUS_USER) -c "$(OMNIBUS_CMD_IMCL) input \
		$(OMNIBUS_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
		{ $(CMD_ECHO) "OMNIbus Upgrade (FAIL):  $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) input $(OMNIBUS_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
		exit 8; }
	@$(CMD_ECHO) "OMNIbus Upgrade (OK):    $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) input $(OMNIBUS_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\""
	@$(CMD_ECHO)

################################################################################
# CONFIGURE OMNIBUS
################################################################################
configure_omnibus:	check_whoami \
					check_commands \
					create_omnibus_user

	@$(call func_print_caption,"CONFIGURING OMNIBUS")
	@$(CMD_ECHO) "omni.dat Check:          #In progress..."
	@$(call func_file_must_exist,$(OMNIBUS_USER),$(NETCOOL_ETC_DEFAULT_OMNIDAT))
	@$(call func_file_must_exist,$(OMNIBUS_USER),$(NETCOOL_ETC_OMNIDAT))
	@if [ $(NETCOOL_ETC_OMNIDAT_B) == $(NETCOOL_ETC_DEFAULT_OMNIDAT_B) ] ; \
	then \
		$(CMD_ECHO) "omni.dat Check (OK):     #$(NETCOOL_ETC_OMNIDAT) not yet configured" ; \
		$(call func_mv_must_exist,$(OMNIBUS_USER),$(NETCOOL_ETC_OMNIDAT),$(NETCOOL_ETC_OMNIDAT).$(TIMESTAMP)) ; \
		$(call func_replace_token_in_file,$(OMNIBUS_USER),[[:space:]]omnihost[[:space:]], $(HOST_FQDN) ,$(NETCOOL_ETC_OMNIDAT).$(TIMESTAMP),$(NETCOOL_ETC_OMNIDAT),664) ; \
		\
		$(CMD_SU) - $(OMNIBUS_USER) -c "export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)" || { $(CMD_ECHO) ; \
			 "Netcool igen (FAIL):     $(CMD_SU) - $(OMNIBUS_USER) -c \"export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)\"" ; \
			exit 9; } ; \
		$(CMD_ECHO) "Netcool igen (OK):       $(CMD_SU) - $(OMNIBUS_USER) -c \"export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)\"" ; \
		\
		$(call func_ln_s,$(OMNIBUS_USER),$(NETCOOL_ETC_INTERFACES_LINUX),$(NETCOOL_ETC_INTERFACES)) ; \
		\
		$(CMD_ECHO) "OMNIBUS dbinit:          #In progress..." ; \
		$(CMD_SU) - $(OMNIBUS_USER) -c "export NCHOME=$(PATH_INSTALL_NETCOOL); $(OMNIBUS_BIN_DBINIT) -server $(OMNIBUS_OS_SERVER) 2>/dev/null" || { $(CMD_ECHO) ; \
			 "OMNIbus dbinit (FAIL):   $(CMD_SU) - $(OMNIBUS_USER) -c \"export NCHOME=$(PATH_INSTALL_NETCOOL); $(OMNIBUS_BIN_DBINIT) -server $(OMNIBUS_OS_SERVER) 2>/dev/null\"" ; \
			exit 10; } ; \
		$(CMD_ECHO) "OMNIbus dbinit (OK):     $(CMD_SU) - $(OMNIBUS_USER) -c \"export NCHOME=$(PATH_INSTALL_NETCOOL); $(OMNIBUS_BIN_DBINIT) -server $(OMNIBUS_OS_SERVER) 2>/dev/null\"" ; \
		\
	else \
		if [ `$(CMD_SU) - $(OMNIBUS_USER) -c "$(CMD_GREP) [[:space:]]$(HOST_FQDN)[[:space:]] $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^\# | $(CMD_WC) -l"` -ge 4 ] ; \
		then \
			$(CMD_ECHO) "omni.dat Check (OK):     #$(NETCOOL_ETC_OMNIDAT) has $(HOST_FQDN)" ; \
		else \
			$(CMD_ECHO) "omni.dat Check (FAIL):   #Expected to find $(HOST_FQDN) four or more times in $(NETCOOL_ETC_OMNIDAT)" ; \
			exit 11; \
		fi ; \
		\
	fi ;

	@if [ -f "$(ETC_PAMD_NCO_OBJSERV)" ] ; \
	then \
		$(CMD_ECHO) "nco_objserv PAM (OK):    #$(ETC_PAMD_NCO_OBJSERV) exists" ; \
	else \
		$(CMD_ECHO) "nco_objserv PAM (OK):    #$(ETC_PAMD_NCO_OBJSERV) non-existent so creating..." ; \
		$(call func_ln_s,$(ETC_PAM_USER),$(ETC_PAMD_SYSAUTH),$(ETC_PAMD_NCO_OBJSERV)) ; \
	fi ; \

	@if [ -f "$(ETC_PAMD_NETCOOL)" ] ; \
	then \
		$(CMD_ECHO) "netcool PAM (OK):        #$(ETC_PAMD_NETCOOL) exists" ; \
	else \
		$(CMD_ECHO) "netcool PAM (OK):        #$(ETC_PAMD_NETCOOL) non-existent so creating..." ; \
		$(call func_ln_s,$(ETC_PAM_USER),$(ETC_PAMD_SYSAUTH),$(ETC_PAMD_NETCOOL)) ; \
	fi ; \

	@$(CMD_ECHO) "nco_pa.conf Check:       #In progress..."
	@$(call func_file_must_exist,$(OMNIBUS_USER),$(OMNIBUS_ETC_DEFAULT_PACONF))
	@$(call func_file_must_exist,$(OMNIBUS_USER),$(OMNIBUS_ETC_PACONF))
	@if [ $(OMNIBUS_ETC_PACONF_B) = $(OMNIBUS_ETC_DEFAULT_PACONF_B) ] ; \
	then \
		$(CMD_ECHO) "nco_pa.conf Check (OK):  #$(OMNIBUS_ETC_PACONF) not yet configured" ; \
		$(call func_mv_must_exist,$(OMNIBUS_USER),$(OMNIBUS_ETC_PACONF),$(OMNIBUS_ETC_PACONF).$(TIMESTAMP)) ; \
		\
		$(CMD_ECHO) "$$OMNIBUS_PA_CONF_CONTENT" > $(OMNIBUS_ETC_PACONF) || { $(CMD_ECHO) ; \
			 "nco_pa.conf File (FAIL): #$(OMNIBUS_ETC_PACONF) failed to configure" ; \
			exit 12; } ; \
		$(CMD_ECHO) "nco_pa.conf File (OK):   #$(OMNIBUS_ETC_PACONF) configured" ; \
		$(call func_chmod,644,$(OMNIBUS_ETC_PACONF)) ; \
		$(call func_chown,$(OMNIBUS_USER),$(OMNIBUS_GROUP),$(OMNIBUS_ETC_PACONF)) ; \
	else \
		if [ `$(CMD_SU) - $(OMNIBUS_USER) -c "$(CMD_GREP) '$(HOST_FQDN)' $(OMNIBUS_ETC_PACONF) | $(CMD_GREP) -v ^\# | $(CMD_WC) -l"` -ge 2 ] ; \
		then \
			$(CMD_ECHO) "nco_pa.conf Check (OK):  #$(OMNIBUS_ETC_PACONF) has $(HOST_FQDN)" ; \
		else \
			$(CMD_ECHO) "nco_pa.conf Check (FAIL):#Expected to find $(HOST_FQDN) two or more times in $(OMNIBUS_ETC_PACONF)" ; \
			exit 13; \
		fi ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CONFIGURE OMNIBUS TO AUTOSTART
################################################################################
autostarton_omnibus:	check_whoami \
						check_commands

	@$(call func_print_caption,"CONFIGURING OMNIBUS TO AUTOMATICALLY START")
	@if [ -d "$(PATH_INSTALL_OMNIBUS)" ] ; \
	then \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # exists" ; \
		\
		$(CMD_GREP) " 6" /etc/redhat-release 1> /dev/null; rc=$$? ; \
		if [ $$rc -eq 0 ] ; \
		then \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 6 / Not systemd" ; \
			\
			if [ -f "$(ETC_INITD_NCO)" ] ; \
			then \
				$(CMD_ECHO) "/etc/init.d Script (OK): #$(ETC_INITD_NCO) exists" ; \
			else \
				$(CMD_ECHO) "/etc/init.d Script (OK): #$(ETC_INITD_NCO) non-existent so creating..." ; \
				$(call func_file_must_exist,$(ETC_PAM_USER),$(ETC_INITD_NCO_TEMPLATE)) ; \
				$(CMD_CAT) $(ETC_INITD_NCO_TEMPLATE) | $(CMD_SED) -e "/###[       ]*$(NETCOOL_STARTUP_REMOVE) ONLY/,/###[   ]*END $(NETCOOL_STARTUP_REMOVE) ONLY/d" -e "/###[         ]*$(NETCOOL_STARTUP_KEEP) ONLY/d" -e "/###[       ]*END $(NETCOOL_STARTUP_KEEP) ONLY/d" -e "s#__NCHOME__#$(PATH_INSTALL_NETCOOL)#" -e "s#__OMNIHOME__#$(PATH_INSTALL_OMNIBUS)#" -e "s#__PROCESSAGENT__#$(NETCOOL_PA_NAME)#" -e "s#__SECURE__#$(NETCOOL_PA_SECURE)#" -e "s#__NETCOOL_LICENSE_FILE__#$(NETCOOL_LEGACY_LICENSE_FILE)#" > $(ETC_INITD_NCO) || { $(CMD_ECHO) \
					"Start/Stop Script (FAIL):#$(CMD_CAT) $(ETC_INITD_NCO_TEMPLATE) | $(CMD_SED) -e ..." ; \
					exit 14; } ; \
				$(CMD_ECHO) "Start/Stop Script (OK):  #$(CMD_CAT) $(ETC_INITD_NCO_TEMPLATE) | $(CMD_SED) -e ..." ; \
				\
				$(call func_chown,$(ETC_PAM_USER),$(ETC_PAM_GROUP),$(ETC_INITD_NCO)) ; \
				$(call func_chmod,755,$(ETC_INITD_NCO)) ; \
				\
				$(CMD_CHKCONFIG) --add $(NETCOOL_SERVICE) > /dev/null || { $(CMD_ECHO) \
					"Service chkconfig (FAIL):$(CMD_CHKCONFIG) --add $(NETCOOL_SERVICE)" ; \
					exit 15; } ; \
				$(CMD_ECHO) "Service chkconfig (OK):  $(CMD_CHKCONFIG) --add $(NETCOOL_SERVICE)" ; \
				\
				$(CMD_SERVICE) $(NETCOOL_SERVICE) start || { $(CMD_ECHO) \
					"nco Start (FAIL):        $(CMD_SERVICE) $(NETCOOL_SERVICE) start" ; \
					exit 16; } ; \
				$(CMD_ECHO) "nco Start (OK):          $(CMD_SERVICE) $(NETCOOL_SERVICE) start" ; \
				\
				$(CMD_ECHO) "nco Starting:            $(CMD_SLEEP) 5 # to give time to start..." ; \
				$(CMD_SLEEP) 5 ; \
				$(CMD_ECHO) "nco Start Check:         $(CMD_SLEEP) 5 # to check for pending..." ; \
				$(CMD_SLEEP) 5 ; \
				$(eval TEMP_PA_PENDING_COUNT=`$(OMNIBUS_BIN_PASTATUS) -server $(NETCOOL_PA_NAME) -user $(OMNIBUS_USER) -password $(OMNIBUS_PASSWD) | $(CMD_GREP) PENDING | $(CMD_WC) -l`)  \
				if [ $(TEMP_PA_PENDING_COUNT) -eq 0 ] ; \
				then \
					$(CMD_ECHO) "nco Start (OK):          #No pending detected" ; \
					$(CMD_ECHO) "nco Status:" ; \
					$(OMNIBUS_BIN_PASTATUS) -server $(NETCOOL_PA_NAME) -user $(OMNIBUS_USER) -password $(OMNIBUS_PASSWD) ; \
				else \
					$(CMD_ECHO) "nco Start (PENDING):     #Seems to be pending, possible configuration problem" ; \
					$(CMD_ECHO) "nco Status:" ; \
					$(OMNIBUS_BIN_PASTATUS) -server $(NETCOOL_PA_NAME) -user $(OMNIBUS_USER) -password $(OMNIBUS_PASSWD) ; \
					$(CMD_ECHO) "nco Stopping:            $(CMD_SERVICE) $(NETCOOL_SERVICE) stop" ; \
					$(CMD_SERVICE) $(NETCOOL_SERVICE) stop ; \
					$(CMD_ECHO) ; \
					$(CMD_ECHO) "nco Configuration (FAIL):#Please review Process Agent and OMNIbus logs." ; \
					$(CMD_ECHO) ; \
					exit 17; \
				fi ; \
			fi ; \
		else \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 7+ / systemd" ; \
			\
			if [ -f "$(ETC_SYSTEMD_NCO_SCRIPT)" ] ; \
			then \
				$(CMD_ECHO) "systemd Script (OK):     #$(ETC_SYSTEMD_NCO_SCRIPT) exists" ; \
			else \
				$(CMD_ECHO) "systemd Script (OK):     #$(ETC_SYSTEMD_NCO_SCRIPT) non-existent so creating..." ; \
				$(call func_file_must_exist,$(ETC_PAM_USER),$(ETC_INITD_NCO_TEMPLATE)) ; \
				$(CMD_CAT) $(ETC_INITD_NCO_TEMPLATE) | $(CMD_SED) -e "/###[       ]*$(NETCOOL_STARTUP_REMOVE) ONLY/,/###[   ]*END $(NETCOOL_STARTUP_REMOVE) ONLY/d" -e "/###[         ]*$(NETCOOL_STARTUP_KEEP) ONLY/d" -e "/###[       ]*END $(NETCOOL_STARTUP_KEEP) ONLY/d" -e "s#__NCHOME__#$(PATH_INSTALL_NETCOOL)#" -e "s#__OMNIHOME__#$(PATH_INSTALL_OMNIBUS)#" -e "s#__PROCESSAGENT__#$(NETCOOL_PA_NAME)#" -e "s#__SECURE__#$(NETCOOL_PA_SECURE)#" -e "s#__NETCOOL_LICENSE_FILE__#$(NETCOOL_LEGACY_LICENSE_FILE)#" > $(ETC_SYSTEMD_NCO_SCRIPT) || { $(CMD_ECHO) \
					"Start/Stop Script (FAIL):#$(CMD_CAT) $(ETC_INITD_NCO_TEMPLATE) | $(CMD_SED) -e ..." ; \
					exit 18; } ; \
				$(CMD_ECHO) "Start/Stop Script (OK):  #$(CMD_CAT) $(ETC_INITD_NCO_TEMPLATE) | $(CMD_SED) -e ..." ; \
				\
				$(call func_chown,$(OMNIBUS_USER),$(OMNIBUS_GROUP),$(ETC_SYSTEMD_NCO_SCRIPT)) ; \
				$(call func_chmod,755,$(ETC_SYSTEMD_NCO_SCRIPT)) ; \
			fi ; \
			if [ -f "$(ETC_SYSTEMD_NCO_SERVICE)" ] ; \
			then \
				$(CMD_ECHO) "systemd Service (OK):    #$(ETC_SYSTEMD_NCO_SERVICE) exists" ; \
			else \
				$(CMD_ECHO) "systemd Service (OK):    #$(ETC_SYSTEMD_NCO_SERVICE) non-existent so creating..." ; \
				$(CMD_ECHO) "$$ETC_SYSTEMD_NCO_SERVICE_CONTENT" > $(ETC_SYSTEMD_NCO_SERVICE) || { $(CMD_ECHO) ; \
				 "nco.service File (FAIL): #$(ETC_SYSTEMD_NCO_SERVICE) failed to configure" ; \
					exit 19; } ; \
				$(CMD_ECHO) "nco.service File (OK):   #$(ETC_SYSTEMD_NCO_SERVICE) configured" ; \
				$(call func_chmod,644,$(ETC_SYSTEMD_NCO_SERVICE)) ; \
				\
				$(CMD_SYSTEMCTL) enable $(NETCOOL_SERVICE) || { $(CMD_ECHO) ; \
					"nco Enable (FAIL):       $(CMD_SYSTEMCTL) enable $(NETCOOL_SERVICE)" ; \
					exit 20; } ; \
				$(CMD_ECHO) "nco Enable (OK):         $(CMD_SYSTEMCTL) enable $(NETCOOL_SERVICE)" ; \
				\
				$(CMD_SYSTEMCTL) start $(NETCOOL_SERVICE) || { $(CMD_ECHO) ; \
					"nco Start (FAIL):        $(CMD_SYSTEMCTL) start $(NETCOOL_SERVICE)" ; \
					exit 21; } ; \
				$(CMD_ECHO) "nco Start (OK):          $(CMD_SYSTEMCTL) start $(NETCOOL_SERVICE)" ; \
				\
				$(CMD_ECHO) "nco Starting:            $(CMD_SLEEP) 5 # to give time to start..." ; \
				$(CMD_SLEEP) 5 ; \
				$(CMD_ECHO) "nco Start Check:         $(CMD_SLEEP) 5 # to check for pending..." ; \
				$(CMD_SLEEP) 5 ; \
				$(eval TEMP_PA_PENDING_COUNT=`$(OMNIBUS_BIN_PASTATUS) -server $(NETCOOL_PA_NAME) -user $(OMNIBUS_USER) -password $(OMNIBUS_PASSWD) | $(CMD_GREP) PENDING | $(CMD_WC) -l`)  \
				if [ $(TEMP_PA_PENDING_COUNT) -eq 0 ] ; \
				then \
					$(CMD_ECHO) "nco Start (OK):          #No pending detected" ; \
					$(CMD_ECHO) "nco Status:" ; \
					$(OMNIBUS_BIN_PASTATUS) -server $(NETCOOL_PA_NAME) -user $(OMNIBUS_USER) -password $(OMNIBUS_PASSWD) ; \
				else \
					$(CMD_ECHO) "nco Start (PENDING):     #Seems to be pending, possible configuration problem" ; \
					$(CMD_ECHO) "nco Status:" ; \
					$(OMNIBUS_BIN_PASTATUS) -server $(NETCOOL_PA_NAME) -user $(OMNIBUS_USER) -password $(OMNIBUS_PASSWD) ; \
					$(CMD_ECHO) "nco Stopping:            $(CMD_SYSTEMCTL) stop $(NETCOOL_SERVICE)" ; \
					$(CMD_SYSTEMCTL) stop $(NETCOOL_SERVICE) ; \
					$(CMD_ECHO) ; \
					$(CMD_ECHO) "nco Configuration (FAIL):#Please review Process Agent and OMNIbus logs." ; \
					$(CMD_ECHO) ; \
					exit 22; \
				fi ; \
			fi ; \
		fi ; \
	else \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CONFIGURE OMNIBUS TO NOT AUTOSTART
################################################################################
autostartoff_omnibus:	check_whoami \
						check_commands

	@$(call func_print_caption,"CONFIGURING OMNIBUS TO NOT AUTOMATICALLY START")
	@if [ -d "$(PATH_INSTALL_OMNIBUS)" ] ; \
	then \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # exists" ; \
		\
		$(CMD_GREP) " 6" /etc/redhat-release 1> /dev/null; rc=$$? ; \
		if [ $$rc -eq 0 ] ; \
		then \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 6 / Not systemd" ; \
			\
			$(CMD_ECHO) "OMNIbus Stop:            $(CMD_SERVICE) $(NETCOOL_SERVICE) stop" ; \
			$(CMD_SERVICE) $(NETCOOL_SERVICE) stop ; \
			\
			$(CMD_ECHO) "Service chkconfig:       $(CMD_CHKCONFIG) --del $(NETCOOL_SERVICE)" ; \
			$(CMD_CHKCONFIG) --del $(NETCOOL_SERVICE) ; \
			\
			$(CMD_ECHO) "Start/Stop Script:       $(CMD_RM) -f $(ETC_INITD_NCO)" ; \
			$(CMD_RM) -f $(ETC_INITD_NCO); \
		else \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 7+ / systemd" ; \
			\
			$(CMD_ECHO) "systemd Reload:          $(CMD_SYSTEMCTL) daemon-reload" ; \
			$(CMD_SYSTEMCTL) daemon-reload ; \
			\
			$(CMD_ECHO) "systemd Stop:            $(CMD_SYSTEMCTL) stop $(NETCOOL_SERVICE)" ; \
			$(CMD_SYSTEMCTL) stop $(NETCOOL_SERVICE) ; \
			\
			$(CMD_ECHO) "systemd Disable:         $(CMD_SYSTEMCTL) disable $(NETCOOL_SERVICE)" ; \
			$(CMD_SYSTEMCTL) disable $(NETCOOL_SERVICE) ; \
			\
			$(CMD_ECHO) "systemd Service (OK):    $(CMD_RM) -f $(ETC_SYSTEMD_NCO_SERVICE)" ; \
			$(CMD_RM) -f $(ETC_SYSTEMD_NCO_SERVICE); \
			$(CMD_ECHO) "systemd Script (OK):     $(CMD_RM) -f $(ETC_SYSTEMD_NCO_SCRIPT)" ; \
			$(CMD_RM) -f $(ETC_SYSTEMD_NCO_SCRIPT); \
		fi ; \
	else \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# UNINSTALL NETCOOL/OMNIBUS CORE
################################################################################
uninstall_omnibus:	check_whoami \
					check_commands

	@$(call func_print_caption,"UNINSTALLING NETCOOL/OMNIBUS CORE")
	@if [ -d "$(PATH_INSTALL_OMNIBUS)" ] ; \
	then \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # exists" ; \
		\
		$(CMD_ECHO) "nco_objserv PAM Remove:  $(CMD_RM) -f $(ETC_PAMD_NCO_OBJSERV)" ; \
		$(CMD_RM) -f $(ETC_PAMD_NCO_OBJSERV) ; \
		$(CMD_ECHO) "netcool PAM Remove:      $(CMD_RM) -f $(ETC_PAMD_NETCOOL)" ; \
		$(CMD_RM) -f $(ETC_PAMD_NETCOOL) ; \
		\
		$(call func_uninstall_im_package,$(OMNIBUS_CMD_IMCL),$(OMNIBUS_USER),$(PATH_REPOSITORY_OMNIBUS_PACKAGE),OMNIbus Core) ; \
		\
		$(call func_mv_if_exists,$(OMNIBUS_USER),$(PATH_INSTALL_OMNIBUS),$(PATH_INSTALL_OMNIBUS).$(TIMESTAMP)) ; \
	else \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:	check_commands
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM) -rf /tmp/ciclogs_$(OMNIBUS_USER)
	@$(CMD_ECHO)

