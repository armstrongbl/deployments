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
# IBM Tivoli Netcool/OMNIbus WebGUI 8.1.0.5
# Michael T. Brown
# July 10, 2019
################################################################################
MAKE_FILE	:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
MAKE_DIR	:= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
################################################################################
# MAKE_FILE NAME, MUST BE BEFORE ANY OTHER MAKEFILE INCLUDES
################################################################################

include ${MAKE_DIR}../include/includes

################################################################################
# INSTALLATION TUNABLES
################################################################################
MAKE_PRODUCT			= WebGUI
MAKE_PRODUCT_PREREQS	= NOW

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL				:= /opt/IBM
PATH_INSTALL_JAZZSM			= $(PATH_INSTALL)/JazzSM
PATH_INSTALL_NETCOOL		= $(PATH_INSTALL)/netcool
PATH_INSTALL_NETCOOL_WEBGUI	= $(PATH_INSTALL_NETCOOL)_webgui
PATH_INSTALL_OMNIBUS_WEBGUI	= $(PATH_INSTALL_NETCOOL_WEBGUI)/omnibus_webgui
PATH_INSTALL_WEBSPHERE		= $(PATH_INSTALL)/WebSphere

################################################################################
# TEMPORARY MAKE DIRECTORY
################################################################################
PATH_TEMP_BASE		:= $(MAKE_PRODUCT).make
PATH_TEMP_TEMPLATE	:= $(PATH_TMP)/$(PATH_TEMP_BASE).XXXXXXXX
PATH_TEMP_DIR		:= $(shell $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null)

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_INSTALL	:= $(PATH_MAKEFILE_REPOSITORY)/webgui_8_1_0_4_install
PATH_REPOSITORY_UPGRADE	:= $(PATH_MAKEFILE_REPOSITORY)/webgui_8_1_0_5_upgrade

PATH_REPOSITORY_WEBGUI_PACKAGE=com.ibm.tivoli.netcool.omnibus.webgui

################################################################################
# INSTALLATION USERS
################################################################################
WEBGUI_USER		:= netcool
WEBGUI_PASSWD	:= $(WEBGUI_USER)
WEBGUI_GROUP	:= ncoadmin
WEBGUI_SHELL	:= /bin/bash
WEBGUI_HOME		:= $(PATH_HOME)/$(WEBGUI_USER)

WEBGUI_IMSHARED	= $(WEBGUI_HOME)/$(PATH_IM_SHARED_PATH)
WEBGUI_CMD_IMCL	:= $(WEBGUI_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)
#WEBGUI_CMD_IMUTILSC	:= $(WEBGUI_HOME)/$(PATH_IM_IMUTILSC_RELATIVE_PATH)

WEBGUI_PACKAGES	=	$(PACKAGES_COMMON)

################################################################################
#JAZZ FOR SERVICE MANAGEMENT
################################################################################
WAS_JAZZSM_USER=smadmin
WAS_JAZZSM_PASSWD=netcool
#WAS_JAZZSM_PROFILE=JazzSMProfile
WAS_JAZZSM_CONTEXTROOT=/ibm/console
WAS_JAZZSM_CELL=JazzSMNode01Cell
WAS_JAZZSM_NODE=JazzSMNode01
WAS_JAZZSM_SERVERNAME=server1
#WAS_JAZZSM_WEBGUI_USER_ID=ncoadmin

################################################################################
# OMNIBUS CONFIGURATION
################################################################################
OMNIBUS_OS_HOST		= $(HOST_FQDN)
OMNIBUS_OS_PASSWD	=
OMNIBUS_OS_PORT		= 4100
OMNIBUS_OS_USER		= root

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
MEDIA_STEP2_D	:= IBM Tivoli Netcool OMNIbus 8.1.0.4 WebGUI & Extensions for NOI Linux\n\t\t64bit English (CN8IKEN)
MEDIA_STEP3_D	:= IBM Tivoli Netcool/OMNIbus_GUI 8.1.0 Fix Pack 5

MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/precheck_unix_20150827.tar
MEDIA_STEP2_F	:= $(PATH_MAKEFILE_MEDIA)/OMNIbus-v8.1.0.4-WebGUI.Linux64.zip
MEDIA_STEP3_F	:= $(PATH_MAKEFILE_MEDIA)/OMNIbus-v8.1.0-WebGUI-FP5-IM-linux64-UpdatePack.zip

MEDIA_STEP1_B	:= fda01aa083b92fcb6f25a7b71058dc045b293103731ca61fda10c73499f1473ef59608166b236dcf802ddf576e7469af0ec063215326e620092c1aeeb1d19186
MEDIA_STEP2_B	:= 76251dae44c3c309cb6c2071e87edca6ee20f0684d46c235d46a97c67a030ac27ec31eeff41d2db6eb60584d214ca640284ae13d2ad8b9c38f4c987ae957789c
MEDIA_STEP3_B	:= 4b5ae27c1c35cfb9ce0d794f471cb18799ecaa5866a60819d43045e9253cd22b1a256be2c085c0a0d0a8c29c850cd2cc601a9602d101289f604d39a24a7f9230

################################################################################
# WEBGUI RESPONSE FILE TEMPLATE (INSTALL)
################################################################################
WEBGUI_INSTALL_RESPONSE_FILE=$(PATH_TMP)/webgui_install_response.xml
define WEBGUI_INSTALL_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(WEBGUI_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_INSTALL)/OMNIbusWebGUIRepository'/>
  </server>
  <profile id='IBM Netcool GUI Components' installLocation='$(PATH_INSTALL_NETCOOL_WEBGUI)'>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.DashHomeDir' value='$(PATH_INSTALL_JAZZSM)/ui'/>
    <data key='user.WasHomeDir' value='$(PATH_INSTALL_WEBSPHERE)/AppServer'/>
    <data key='user.DashHomeUserID' value='$(WAS_JAZZSM_USER)'/>
    <data key='user.DashHomeContextRoot' value='$(WAS_JAZZSM_CONTEXTROOT)'/>
    <data key='user.DashHomeWasCell' value='$(WAS_JAZZSM_CELL)'/>
    <data key='user.DashHomeWasNode' value='$(WAS_JAZZSM_NODE)'/>
    <data key='user.DashHomeWasServerName' value='$(WAS_JAZZSM_SERVERNAME)'/>
    <data key='user.DashHomePwd' value='$(WAS_JAZZSM_PASSWD)'/>
  </profile>
  <install>
    <!-- IBM Tivoli Netcool/OMNIbus Web GUI 8.1.0.4 -->
    <offering profile='IBM Netcool GUI Components' id='$(PATH_REPOSITORY_WEBGUI_PACKAGE)' version='8.1.4.201512041013' features='VMM.feature,WebGUI.feature'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
</agent-input>
endef
export WEBGUI_INSTALL_RESPONSE_FILE_CONTENT

################################################################################
# WEBGUI RESPONSE FILE TEMPLATE (UPGRADE)
################################################################################
WEBGUI_UPGRADE_RESPONSE_FILE=$(PATH_TMP)/webgui_upgrade_response.xml
define WEBGUI_UPGRADE_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(WEBGUI_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_UPGRADE)/OMNIbusWebGUIRepository/composite'/>
  </server>
  <profile id='IBM Netcool GUI Components' installLocation='$(PATH_INSTALL_NETCOOL_WEBGUI)'>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.DashHomeDir' value='$(PATH_INSTALL_JAZZSM)/ui'/>
    <data key='user.WasHomeDir' value='$(PATH_INSTALL_WEBSPHERE)/AppServer'/>
    <data key='user.DashHomeUserID' value='$(WAS_JAZZSM_USER)'/>
    <data key='user.DashHomeContextRoot' value='$(WAS_JAZZSM_CONTEXTROOT)'/>
    <data key='user.DashHomeWasCell' value='$(WAS_JAZZSM_CELL)'/>
    <data key='user.DashHomeWasNode' value='$(WAS_JAZZSM_NODE)'/>
    <data key='user.DashHomeWasServerName' value='$(WAS_JAZZSM_SERVERNAME)'/>
    <data key='user.DashHomePwd' value='$(WAS_JAZZSM_PASSWD)'/>
  </profile>
  <install>
    <!-- IBM Tivoli Netcool/OMNIbus Web GUI 8.1.0.5 -->
    <offering profile='IBM Netcool GUI Components' id='$(PATH_REPOSITORY_WEBGUI_PACKAGE)' version='8.1.5.201603182149' features='VMM.feature,WebGUI.feature'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
</agent-input>
endef
export WEBGUI_UPGRADE_RESPONSE_FILE_CONTENT

################################################################################
# WEBGUI CONFIGURATION TEMPLATE (OMNIbusWebGUI.properties)
################################################################################
WEBGUI_CONFIGURATION_FILE=$(PATH_INSTALL_OMNIBUS_WEBGUI)/bin/OMNIbusWebGUI.properties
define WEBGUI_CONFIGURATION_FILE_CONTENT
WASUserID=$(WAS_JAZZSM_USER)
WASPassword=$(WAS_JAZZSM_PASSWD)
CONFIGURATION_TOKEN_OBJECTSERVER_OSRESYNC=false
CONFIGURATION_TOKEN_CONTEXT_ROOT=$(WAS_JAZZSM_CONTEXTROOT)
CONFIGURATION_TOKEN_OBJECTSERVER_PRIMARY_NAME=OMNIBUS
CONFIGURATION_TOKEN_OBJECTSERVER_USER=$(OMNIBUS_OS_USER)
CONFIGURATION_TOKEN_OBJECTSERVER_PASSWORD=$(OMNIBUS_OS_PASSWD)
CONFIGURATION_TOKEN_OBJECTSERVER_PRIMARY_HOST=$(OMNIBUS_OS_HOST)
CONFIGURATION_TOKEN_OBJECTSERVER_PRIMARY_PORT=$(OMNIBUS_OS_PORT)
OBJECTSERVER_ENABLE_SECONDARY_SERVER=false
CONFIGURATION_TOKEN_OBJECTSERVER_FAILOVER=
CONFIGURATION_TOKEN_OBJECTSERVER_SECONDARY_HOST=localhost
CONFIGURATION_TOKEN_OBJECTSERVER_SECONDARY_PORT=4200
CONFIGURATION_TOKEN_OBJECTSERVER_SSL=false
OBJECTSERVER_PASSWORD_FIPS=false
USER_REGISTRY_OBJECTSERVER_SELECTED=true
DEFAULT_USER_REGISTRY_SELECTION=OBJECT_SERVER
CONFIGURATION_TOKEN_REPO_FOR_DEFAULT_USERSANDGROUPS=netcoolObjectServerRepository
CREATE_DEFAULT_USERSANDGROUPS=true
OMNIBUS_WEBGUI_HOME=$(PATH_INSTALL_OMNIBUS_WEBGUI)
DASH_HOME=$(PATH_INSTALL_JAZZSM)/ui
endef
export WEBGUI_CONFIGURATION_FILE_CONTENT

################################################################################
# WEBGUI RESPONSE FILE TEMPLATE (UNINSTALL)
################################################################################
WEBGUI_UNINSTALL_RESPONSE_FILE=$(PATH_TMP)/webgui_uninstall_response.xml
define WEBGUI_UNINSTALL_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(WEBGUI_IMSHARED)'/>
  </variables>
  <profile id='IBM Netcool GUI Components' installLocation='$(PATH_INSTALL_NETCOOL_WEBGUI)'>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.DashHomeDir' value='$(PATH_INSTALL_JAZZSM)/ui'/>
    <data key='user.WasHomeDir' value='$(PATH_INSTALL_WEBSPHERE)/AppServer'/>
    <data key='user.DashHomeUserID' value='$(WAS_JAZZSM_USER)'/>
    <data key='user.DashHomeContextRoot' value='$(WAS_JAZZSM_CONTEXTROOT)'/>
    <data key='user.DashHomeWasCell' value='$(WAS_JAZZSM_CELL)'/>
    <data key='user.DashHomeWasNode' value='$(WAS_JAZZSM_NODE)'/>
    <data key='user.DashHomeWasServerName' value='$(WAS_JAZZSM_SERVERNAME)'/>
    <data key='user.DashHomePwd' value='$(WAS_JAZZSM_PASSWD)'/>
  </profile>
  <uninstall>
    <offering profile='IBM Netcool GUI Components' id='$(PATH_REPOSITORY_WEBGUI_PACKAGE)' version='<PACKAGE_VERSION>'/>
  </uninstall>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
</agent-input>
endef
export WEBGUI_UNINSTALL_RESPONSE_FILE_CONTENT

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

preinstall:		

theinstall:			install_webgui \
					upgrade_webgui \
					configure_webgui

postinstall:		clean

preuninstallchecks:	check_commands \
					check_media_exists \
					check_media_checksums

preuninstall:

theuninstall:		uninstall_webgui

postuninstall:		remove_webgui_path \
					remove_root_path \
					clean

clean:				remove_temp_dir \
					remove_webgui_install_response_file \
					remove_webgui_upgrade_response_file \
					remove_webgui_uninstall_response_file \
					clean_tmp

scrub:				uninstall \
					clean

# WARNING scrub_users WILL REMOVE USERS AND HOME DIRECTORIES INCLUDING ALL
# CONTENT AND ANY INSTALL MANAGERS IN SAME.  IF THE SAME USERNAME IS USED
# FOR MORE THAN ONE PRODUCT INSTALL, THEN THIS SHOULD BE DONE WITH EXTREME
# CAUTION
scrub_users:		remove_webgui_group \
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
	@$(call func_check_file_cksum,$(MEDIA_STEP3_F),$(MEDIA_STEP3_B))
	@$(CMD_ECHO)

################################################################################
# INSTALL PREREQUISITE PACKAGES
################################################################################
install_packages:	check_whoami
	@$(call func_print_caption,"INSTALLING PREREQUISITE PACKAGES")
	@$(call func_install_packages,$(WEBGUI_PACKAGES))
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
	@$(call func_print_caption,"CHECKING PREREQUISITES FOR WEBGUI")
	@$(call func_tar_xf_to_new_dir,root,root,755,$(MEDIA_STEP1_F),$(PATH_TEMP_DIR)/$(MAKE_PRODUCT))
	@$(CMD_ECHO) "Prereq Check:            $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s"
	@$(CMD_ECHO)
	@$(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s; rc=$$? ; \
	if [ $$rc -ne 0 -a $$rc -ne 3 ] ; \
	then \
		$(CMD_ECHO) "Prereq Check (FAIL):     $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s" ; \
		exit 2; \
	fi
	@$(CMD_ECHO) "Prereq Check (OK):       $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s"
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
# CREATE THE WEBGUI PATH DIRECTORY IF IT DOESN'T EXIST
################################################################################
create_webgui_path:	check_whoami \
					check_commands \
					create_webgui_user
	@$(call func_print_caption,"CREATING WEBGUI INSTALL DIRECTORY IF NEEDED")
	@$(call func_mkdir,$(WEBGUI_USER),$(WEBGUI_GROUP),755,$(PATH_INSTALL_NETCOOL_WEBGUI))
	@$(CMD_ECHO)

# if empty remove path, else backup with timestamp to preserve custom artifacts
remove_webgui_path:	check_whoami \
					check_commands
	@$(call func_print_caption,"REMOVING WEBGUI INSTALL DIRECTORY IF EMPTY")
	@$(call func_rmdir_if_empty,$(PATH_INSTALL_NETCOOL_WEBGUI))
	@$(call func_mv_if_exists,root,$(PATH_INSTALL_NETCOOL_WEBGUI),$(PATH_INSTALL_NETCOOL_WEBGUI).$(TIMESTAMP))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE GROUPS
################################################################################
create_webgui_group:	check_whoami \
						check_commands
	@$(call func_print_caption,"CONFIRMING/CREATING WEBGUI GROUP")
	@$(call func_create_group,$(WEBGUI_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# REMOVE GROUPS
################################################################################
remove_webgui_group:	check_whoami \
						check_commands \
						remove_webgui_user
	@$(call func_print_caption,"REMOVING WEBGUI GROUP")
	@$(call func_remove_group,$(WEBGUI_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE USERS
################################################################################
create_webgui_user:	check_whoami \
					check_commands \
					create_webgui_group
	@$(call func_print_caption,"CONFIRMING/CREATING WEBGUI USER")
	@$(call func_create_user,$(WEBGUI_USER),$(MAKE_PRODUCT),$(WEBGUI_GROUP),$(WEBGUI_HOME),$(WEBGUI_SHELL),$(WEBGUI_PASSWD))

################################################################################
# REMOVE USERS
################################################################################
remove_webgui_user:	check_whoami \
					check_commands
	@$(call func_print_caption,"REMOVING WEBGUI USER")
	@$(call func_remove_user,$(WEBGUI_USER),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# PREPARE NETCOOL/OMNIBUS WEBGUI MEDIA (INSTALLATION)
################################################################################
prepare_webgui_install_media:	check_whoami \
								check_commands \
								create_webgui_user

	@$(call func_print_caption,"PREPARING NETCOOL/OMNIBUS WEBGUI INSTALLATION MEDIA")
	@$(call func_unzip_to_new_dir,$(WEBGUI_USER),$(WEBGUI_GROUP),755,$(MEDIA_STEP2_F),$(PATH_REPOSITORY_INSTALL))
	@$(CMD_ECHO)

################################################################################
# CREATE WEBGUI RESPONSE FILE (INSTALLATION)
################################################################################
create_webgui_install_response_file:	check_whoami \
										check_commands
	@$(call func_print_caption,"CREATING NETCOOL/WEBGUI INSTALLATION RESPONSE FILE")
	@$(CMD_ECHO) "$$WEBGUI_INSTALL_RESPONSE_FILE_CONTENT" > $(WEBGUI_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "WebGUI Resp File (FAIL): #$(WEBGUI_INSTALL_RESPONSE_FILE)" ; \
		exit 3; }
	@$(CMD_ECHO) "WebGUI Resp File (OK):   #$(WEBGUI_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(WEBGUI_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_webgui_install_response_file:    check_commands
	@$(call func_print_caption,"REMOVING NETCOOL/WEBGUI INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(WEBGUI_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# INSTALL NETCOOL/OMNIBUS WEBGUI AS $(WEBGUI_USER)
################################################################################
install_webgui:		check_whoami \
					check_commands \
					prepare_webgui_install_media \
					create_webgui_install_response_file \
					create_webgui_user \
					create_root_path \
					create_webgui_path

	@$(call func_print_caption,"INSTALLING NETCOOL/WEBGUI")
	@if [ -d "$(PATH_INSTALL_OMNIBUS_WEBGUI)" ] ; \
	then \
		$(CMD_ECHO) "WebGUI Exists? (WARN):   -d $(PATH_INSTALL_OMNIBUS_WEBGUI) # exists" ; \
	else \
		$(CMD_ECHO) "WebGUI Exists? (OK):     -d $(PATH_INSTALL_OMNIBUS_WEBGUI) # non-existent" ; \
		$(call func_prepare_installation_manager,$(WEBGUI_USER),$(WEBGUI_HOME),$(PATH_REPOSITORY_INSTALL)/im.linux.x86_64) ; \
		$(call func_command_check,$(WEBGUI_CMD_IMCL)) ; \
		\
		$(CMD_ECHO) "WebGUI Install:          #In progress..." ; \
		$(CMD_SU) - $(WEBGUI_USER) -c "$(WEBGUI_CMD_IMCL) input \
			$(WEBGUI_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
			{ $(CMD_ECHO) "WebGUI Install (FAIL):   $(CMD_SU) - $(WEBGUI_USER) -c \"$(WEBGUI_CMD_IMCL) input $(WEBGUI_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
			exit 4; } ; \
		$(CMD_ECHO) "WebGUI Install (OK):     $(CMD_SU) - $(WEBGUI_USER) -c \"$(WEBGUI_CMD_IMCL) input $(WEBGUI_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CONFIGURE WEBGUI
################################################################################
configure_webgui:	check_whoami \
					check_commands

	@$(call func_print_caption,"CONFIGURING WEBGUI")
	@$(call func_mv_if_exists,$(WEBGUI_USER),$(WEBGUI_CONFIGURATION_FILE),$(WEBGUI_CONFIGURATION_FILE).$(TIMESTAMP))
	@$(CMD_ECHO) "$$WEBGUI_CONFIGURATION_FILE_CONTENT" > $(WEBGUI_CONFIGURATION_FILE) || { $(CMD_ECHO) ; \
		"WebGUI Config File (FL): #$(WEBGUI_CONFIGURATION_FILE) generation failed" ; \
		exit 5; }
	@$(CMD_ECHO) "WebGUI Config File (OK): #$(WEBGUI_CONFIGURATION_FILE) generated successfully"
	@$(call func_chmod,755,$(WEBGUI_CONFIGURATION_FILE))
	@$(call func_chown,$(WEBGUI_USER),$(WEBGUI_GROUP),$(WEBGUI_CONFIGURATION_FILE))
	@$(CMD_ECHO) "WebGUI Configuration:    #In progress..."
	@$(CMD_ECHO) "WebGUI Configuration:    $(CMD_SU) - $(WEBGUI_USER) -c \"cd $(PATH_INSTALL_OMNIBUS_WEBGUI)/bin; $(PATH_INSTALL_JAZZSM)/profile/bin/ws_ant.sh configureOS\""
	@$(CMD_ECHO)
	@$(CMD_SU) - $(WEBGUI_USER) -c "cd $(PATH_INSTALL_OMNIBUS_WEBGUI)/bin; $(PATH_INSTALL_JAZZSM)/profile/bin/ws_ant.sh configureOS"
	@$(CMD_ECHO)
	@$(CMD_ECHO) "WebGUI Config (OK):      $(CMD_SU) - $(WEBGUI_USER) -c \"cd $(PATH_INSTALL_OMNIBUS_WEBGUI)/bin; $(PATH_INSTALL_JAZZSM)/profile/bin/ws_ant.sh configureOS\""
	@$(CMD_ECHO)

################################################################################
# PREPARE NETCOOL/OMNIBUS WEBGUI MEDIA (UPGRADE)
################################################################################
prepare_webgui_upgrade_media:	check_whoami \
								check_commands \
								create_webgui_user

	@$(call func_print_caption,"PREPARING NETCOOL/OMNIBUS WEBGUI UPGRADE MEDIA")
	@$(call func_unzip_to_new_dir,$(WEBGUI_USER),$(WEBGUI_GROUP),755,$(MEDIA_STEP3_F),$(PATH_REPOSITORY_UPGRADE))
	@$(CMD_ECHO)

################################################################################
# CREATE WEBGUI RESPONSE FILE (UPGRADE)
################################################################################
create_webgui_upgrade_response_file:	check_whoami \
										check_commands

	@$(call func_print_caption,"CREATING NETCOOL/WEBGUI UPGRADE RESPONSE FILE")
	@$(CMD_ECHO) "$$WEBGUI_UPGRADE_RESPONSE_FILE_CONTENT" > $(WEBGUI_UPGRADE_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "WebGUI Resp File (FAIL): $(WEBGUI_UPGRADE_RESPONSE_FILE)" ; \
		exit 6; }
	@$(CMD_ECHO) "WebGUI Resp File (OK):   $(WEBGUI_UPGRADE_RESPONSE_FILE)"
	@$(call func_chmod,444,$(WEBGUI_UPGRADE_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_webgui_upgrade_response_file:	check_commands
	@$(call func_print_caption,"REMOVING NETCOOL/WEBGUI UPGRADE RESPONSE FILE")
	@$(CMD_RM) -f $(WEBGUI_UPGRADE_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# UPGRADE NETCOOL/OMNIBUS WEBGUI
################################################################################
upgrade_webgui:	check_whoami \
				check_commands \
				prepare_webgui_upgrade_media \
				create_webgui_upgrade_response_file

	@$(call func_print_caption,"UPGRADING WEBGUI")
	@if [ -d "$(PATH_INSTALL_OMNIBUS_WEBGUI)" ] ; \
	then \
		$(CMD_ECHO) "WebGUI Exists? (OK):     -d $(PATH_INSTALL_OMNIBUS_WEBGUI) # exists" ; \
	else \
		$(CMD_ECHO) "WebGUI Exists? (FAIL):   -d $(PATH_INSTALL_OMNIBUS_WEBGUI) # non-existent" ; \
		exit 7 ; \
	fi ;

	@$(call func_command_check,$(WEBGUI_CMD_IMCL))
	@$(CMD_ECHO) "WebGUI Upgrade:          #In progress..."
	@$(CMD_SU) - $(WEBGUI_USER) -c "$(WEBGUI_CMD_IMCL) input \
		$(WEBGUI_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
		{ $(CMD_ECHO) "WebGUI Upgrade (FAIL):   $(CMD_SU) - $(WEBGUI_USER) -c \"$(WEBGUI_CMD_IMCL) input $(WEBGUI_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
		exit 8; }
	@$(CMD_ECHO) "WebGUI Upgrade (OK):     $(CMD_SU) - $(WEBGUI_USER) -c \"$(WEBGUI_CMD_IMCL) input $(WEBGUI_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\""
	@$(CMD_ECHO)

################################################################################
# CREATE THE WEBGUI UNINSTALLATION RESPONSE FILE
################################################################################
create_webgui_uninstall_response_file:	check_commands
	@$(call func_print_caption,"CREATING NETCOOL/WEBGUI UNINSTALLATION RESPONSE FILE")
	@if [ -d "$(PATH_INSTALL_OMNIBUS_WEBGUI)" ] ; \
	then \
		$(CMD_ECHO) "WebGUI Exists? (OK):     -d $(PATH_INSTALL_OMNIBUS_WEBGUI) # exists" ; \
		$(call func_command_check,$(WEBGUI_CMD_IMCL)) ; \
		temp_version=`$(CMD_SU) - $(WEBGUI_USER) -c "$(WEBGUI_CMD_IMCL) listInstalledPackages" | $(CMD_GREP) ^$(PATH_REPOSITORY_WEBGUI_PACKAGE) | $(CMD_CUT) -d_ -f2` ; \
		temp_version_count=`$(CMD_ECHO) $$temp_version | $(CMD_WC) -w` ; \
		if [ $$temp_version_count -eq 1 ] ; \
		then \
			$(CMD_ECHO) "WebGUI Version? (OK):    #$$temp_version found" ; \
			$(CMD_ECHO) "$$WEBGUI_UNINSTALL_RESPONSE_FILE_CONTENT" | $(CMD_SED) -e "s/<PACKAGE_VERSION>/$$temp_version/g" > $(WEBGUI_UNINSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
				 "Response File (FAIL):    #$(WEBGUI_UNINSTALL_RESPONSE_FILE) generation failed" ; \
				exit 9; } ; \
			$(CMD_ECHO) "Response File (OK):      #$(WEBGUI_UNINSTALL_RESPONSE_FILE) generated successfully" ; \
			$(call func_chmod,444,$(WEBGUI_UNINSTALL_RESPONSE_FILE)) ; \
		else \
			if [ $$temp_version_count -eq 0 ] ; \
			then \
				$(CMD_ECHO) "WebGUI Version? (FAIL):  #Package ^$(PATH_REPOSITORY_WEBGUI_PACKAGE)_* not found" ; \
				exit 10 ; \
			else \
				$(CMD_ECHO) "WebGUI Version? (FAIL):  #Too many versions found, expected 1 but found $$temp_version_count ($$temp_version)" ; \
				exit 11 ; \
			fi ; \
		fi ; \
	else \
		$(CMD_ECHO) "WebGUI Exists? (OK):     -d $(PATH_INSTALL_OMNIBUS_WEBGUI) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

remove_webgui_uninstall_response_file:	check_commands
	@$(call func_print_caption,"REMOVING NETCOOL/WEBGUI UNINSTALL RESPONSE FILE")
	@$(CMD_RM) -f $(WEBGUI_UNINSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# UNINSTALL NETCOOL/OMNIBUS WEBGUI
################################################################################
uninstall_webgui:	check_whoami \
					check_commands \
					create_webgui_uninstall_response_file

	@$(call func_print_caption,"UNINSTALLING NETCOOL/OMNIBUS WEBGUI")
	@if [ -d "$(PATH_INSTALL_OMNIBUS_WEBGUI)" ] ; \
	then \
		$(CMD_ECHO) "WebGUI Exists? (OK):     -d $(PATH_INSTALL_OMNIBUS_WEBGUI) # exists" ; \
		$(call func_command_check,$(WEBGUI_CMD_IMCL)) ; \
		$(CMD_ECHO) "WebGUI Uninstall:        #In progress..." ; \
		$(CMD_SU) - $(WEBGUI_USER) -c "$(WEBGUI_CMD_IMCL) input $(WEBGUI_UNINSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
		{ $(CMD_ECHO) "WebGUI Uninstall (FAIL): $(CMD_SU) - $(WEBGUI_USER) -c \"$(WEBGUI_CMD_IMCL) input $(WEBGUI_UNINSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
		exit 12; } ; \
		$(CMD_ECHO) "WebGUI Uninstall (OK):   $(CMD_SU) - $(WEBGUI_USER) -c \"$(WEBGUI_CMD_IMCL) input $(WEBGUI_UNINSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	else \
		$(CMD_ECHO) "WebGUI Exists? (OK):     -d $(PATH_INSTALL_OMNIBUS_WEBGUI) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:	check_commands
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM) -rf /tmp/ciclogs_$(WEBGUI_USER) /tmp/javasharedresources
	@$(CMD_ECHO)

