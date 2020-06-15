###############################################################################
#                       _
#                      / \   ___ ___ _   _  ___  ___ ___
#                     / _ \ / __/ __| | | |/ _ \/ __/ __|
#                    / ___ \ (_| (__| |_| | (_) \__ \__ \
#                   /_/   \_\___\___|\__,_|\___/|___/___/
# 
#                    Accurate Operational Support Systems
#              (c) 2015-2016 Accuoss, Inc. All rights reserved.
################################################################################
# IBM Tivoli Network Manager 4.2 
# Brad Armstrong 
# Jan 23, 2018 
################################################################################
MAKE_FILE               := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
################################################################################
# MAKE_FILE NAME, MUST BE BEFORE ANY OTHER MAKEFILE INCLUDES
################################################################################

include /opt/accuOSS/makefile_lib/include/includes

################################################################################
# INSTALLATION TUNABLES
################################################################################
MAKE_PRODUCT		= ITNM
MAKE_PRODUCT_PREREQS	= "TNM 04200000"
ITNM_DOMAIN		= ITNM

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL			:= /opt/IBM
PATH_INSTALL_JAZZSM		= $(PATH_INSTALL)/JazzSM
PATH_INSTALL_NETCOOL		= $(PATH_INSTALL)/netcool
PATH_INSTALL_NETCOOL_ITNM	= $(PATH_INSTALL)/netcool_webgui
PATH_INSTALL_OMNIBUS_ITNM	= $(PATH_INSTALL_NETCOOL_ITNM)/omnibus_webgui
PATH_INSTALL_CORE		= $(PATH_INSTALL_NETCOOL)/core
PATH_INSTALL_PRECISION		= $(PATH_INSTALL_CORE)
PATH_INSTALL_WEBSPHERE		= $(PATH_INSTALL)/WebSphere

################################################################################
# TEMPORARY MAKE DIRECTORY
################################################################################
PATH_TEMP_BASE			:= $(MAKE_PRODUCT).make
PATH_TEMP_TEMPLATE		:= $(PATH_TMP)/$(PATH_TEMP_BASE).XXXXXXXX
PATH_TEMP_DIR			:= $(shell $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null)

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_INSTALL	:= $(PATH_MAKEFILE_REPOSITORY)/itnm_4_2

PATH_REPOSITORY_ITNM_PACKAGE=com.ibm.tivoli.netcool.itnm.core
#PATH_REPOSITORY_ITNM_PACKAGE=$(PATH_REPOSITORY_INSTALL)/repositories/disk1/diskTag.inf

################################################################################
# INSTALLATION USERS
################################################################################
ITNM_USER		:= netcool
ITNM_PASSWD		:= $(ITNM_USER)
ITNM_GROUP		:= ncoadmin
ITNM_SHELL		:= /bin/bash
ITNM_HOME		:= $(PATH_HOME)/$(ITNM_USER)

ITNM_IMSHARED		= $(ITNM_HOME)/$(PATH_IM_SHARED_PATH)
ITNM_CMD_IMCL		:= $(ITNM_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)
#ITNM_CMD_IMUTILSC	:= $(ITNM_HOME)/$(PATH_IM_IMUTILSC_RELATIVE_PATH)

################################################################################
#JAZZ FOR SERVICE MANAGEMENT
################################################################################
WAS_JAZZSM_USER=smadmin
WAS_JAZZSM_PASSWD=smadmin
#WAS_JAZZSM_PROFILE=JazzSMProfile
WAS_JAZZSM_CONTEXTROOT=/ibm/console
WAS_JAZZSM_CELL=JazzSMNode01Cell
WAS_JAZZSM_NODE=JazzSMNode01
WAS_JAZZSM_SERVERNAME=server1
WAS_ITNMADMIN_USER=itnmadmin
WAS_ITNMADMIN_PASSWD=$(WAS_ITNMADMIN_USER)

################################################################################
# ITNM DATABASE CONFIGURATION
################################################################################
DB_HOST   = fwaencitnmdb01
DB_NAME   = NCIM
DB_PASSWD = ncim
DB_PORT   = 60000
DB_TYPE   = db2
DB_USER   = ncim

################################################################################
# OMNIBUS CONFIGURATION
################################################################################
#OMNIBUS_OS_HOST		= $(HOST_FQDN)
OMNIBUS_OS_HOST		= fwaencobaggobj03
OMNIBUS_OS_NAME		= APP1_P
OMNIBUS_OS_PASSWD	= object00
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
			\t$(MEDIA_STEP2_D)\n 

MEDIA_ALL_FILES	=	$(MEDIA_STEP1_F) \
			$(MEDIA_STEP2_F) 

MEDIA_STEP1_D	:= IBM Prerequisite Scanner V1.2.0.17, Build 20150827
MEDIA_STEP2_D	:= IBM Tivoli Network Manager V4.2 

#MEDIA_STEP1_F   := $(PATH_MAKEFILE_MEDIA)/GUI_Components/precheck_unix_20150827.tar
MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/1.2.0.18-Tivoli-PRS-Unix-fp0001.tar
MEDIA_STEP2_F	:= $(PATH_MAKEFILE_MEDIA)/ITNP_IP_LIN.zip

#MEDIA_STEP1_B   := fda01aa083b92fcb6f25a7b71058dc045b293103731ca61fda10c73499f1473ef59608166b236dcf802ddf576e7469af0ec063215326e620092c1aeeb1d19186
MEDIA_STEP1_B	:= fe17ed5d7ca2d6df7e139e0d7fe5ce1b615a078bc12831556dd24b0b4515690121d317d9c5a13909573a0dec21532c218ac9db21731e93cddb19424e241b09b4
MEDIA_STEP2_B	:= cff862b16f4e96951d237329f454a6e11e7a256ed0f63556df3ab0c908dec3764b011978763c3d00ba5162540201e4dc7b5cd08229b7f8aac31222ad00c5d969

################################################################################
# ITNM RESPONSE FILE TEMPLATE (INSTALL)
################################################################################
ITNM_INSTALL_RESPONSE_FILE=$(PATH_TMP)/itnm_install_response.xml
define ITNM_INSTALL_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(ITNM_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_INSTALL)/repositories/disk1'/>
  </server>
  <profile id='IBM Netcool GUI Components' installLocation='$(PATH_INSTALL_NETCOOL_ITNM)'>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.DashHomeDir' value='/opt/IBM/JazzSM/ui'/>
    <data key='user.WasHomeDir' value='/opt/IBM/WebSphere/AppServer'/>
    <data key='user.DashHomeUserID' value='$(WAS_JAZZSM_USER)'/>
    <data key='user.DashHomeContextRoot' value='$(WAS_JAZZSM_CONTEXTROOT)'/>
    <data key='user.DashHomeWasCell' value='$(WAS_JAZZSM_CELL)'/>
    <data key='user.DashHomeWasNode' value='$(WAS_JAZZSM_NODE)'/>
    <data key='user.DashHomeWasServerName' value='$(WAS_JAZZSM_SERVERNAME)'/>
    <data key='user.org.apache.ant.classpath' value='/home/netcool/IBM/InstallationManager/eclipse/plugins/org.apache.ant_1.8.3.v201301120609/lib/ant.jar'/>
    <data key='user.org.apache.ant.launcher.classpath' value='/home/netcool/IBM/InstallationManager/eclipse/plugins/org.apache.ant_1.8.3.v201301120609/lib/ant-launcher.jar'/>
    <data key='user.itnm.ObjectServerUsername,com.ibm.tivoli.netcool.itnm.gui' value='$(OMNIBUS_OS_USER)'/>
    <data key='user.itnm.ObjectServerPassword,com.ibm.tivoli.netcool.itnm.gui' value='$(OMNIBUS_OS_PASSWD)'/>
    <data key='user.itnm.ObjectServer.skip.validation,com.ibm.tivoli.netcool.itnm.gui' value='false'/>
    <data key='user.itnm.ObjectServerHostname,com.ibm.tivoli.netcool.itnm.gui' value='$(OMNIBUS_OS_HOST)'/>
    <data key='user.itnm.ObjectServerName,com.ibm.tivoli.netcool.itnm.gui' value='$(OMNIBUS_OS_NAME)'/>
    <data key='user.itnm.ObjectServer.create.instance,com.ibm.tivoli.netcool.itnm.gui' value='false'/>
    <data key='user.itnm.ObjectServerMainPort,com.ibm.tivoli.netcool.itnm.gui' value='$(OMNIBUS_OS_PORT)'/>
    <data key='user.JAZZSM_HOME,com.ibm.tivoli.netcool.itnm.gui' value='/opt/IBM/JazzSM'/>
    <data key='user.WAS_PASSWORD,com.ibm.tivoli.netcool.itnm.gui' value='$(WAS_JAZZSM_PASSWD)'/>
    <data key='user.WAS_SERVER_NAME,com.ibm.tivoli.netcool.itnm.gui' value='$(WAS_JAZZSM_SERVERNAME)'/>
    <data key='user.WAS_PROFILE_PATH,com.ibm.tivoli.netcool.itnm.gui' value='/opt/IBM/JazzSM/profile'/>
    <data key='user.WAS_USER_NAME,com.ibm.tivoli.netcool.itnm.gui' value='$(WAS_JAZZSM_USER)'/>
    <data key='user.itnm.ObjectServerItnmUserPassword.confirm,com.ibm.tivoli.netcool.itnm.gui' value='$(WAS_ITNMADMIN_USER)'/>
    <data key='user.itnm.ObjectServerItnmUserPassword,com.ibm.tivoli.netcool.itnm.gui' value='$(WAS_ITNMADMIN_PASSWD)'/>
    <data key='user.itnm.database.server.type,com.ibm.tivoli.netcool.itnm.gui' value='$(DB_TYPE)'/>
    <data key='user.itnm.database.skip.validation,com.ibm.tivoli.netcool.itnm.gui' value='false'/>
    <data key='user.itnm.database.name,com.ibm.tivoli.netcool.itnm.gui' value='$(DB_NAME)'/>
    <data key='user.itnm.database.hostname,com.ibm.tivoli.netcool.itnm.gui' value='$(DB_HOST)'/>
    <data key='user.itnm.database.username,com.ibm.tivoli.netcool.itnm.gui' value='$(DB_USER)'/>
    <data key='user.itnm.database.password,com.ibm.tivoli.netcool.itnm.gui' value='$(DB_PASSWD)'/>
    <data key='user.itnm.database.create.tables,com.ibm.tivoli.netcool.itnm.gui' value='false'/>
    <data key='user.itnm.database.port,com.ibm.tivoli.netcool.itnm.gui' value='$(DB_PORT)'/>
  </profile>
  <install>
    <!-- Network Manager GUI Components 4.2 -->
    <offering profile='IBM Netcool GUI Components' id='com.ibm.tivoli.netcool.itnm.gui' version='4.2.0.20160131_0807' features='itnm.gui'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
</agent-input>
endef
export ITNM_INSTALL_RESPONSE_FILE_CONTENT

################################################################################
# ITNM RESPONSE FILE TEMPLATE (UNINSTALL)
################################################################################
ITNM_UNINSTALL_RESPONSE_FILE=$(PATH_TMP)/itnm_uninstall_response.xml
define ITNM_UNINSTALL_RESPONSE_FILE_CONTENT

endef


export ITNM_UNINSTALL_RESPONSE_FILE_CONTENT

################################################################################
# MAIN BUILD TARGETS
################################################################################
default:		help

all:			help \
			install

install:		preinstallchecks \
			preinstall \
			theinstall \
			postinstall

uninstall:		preuninstallchecks \
			preuninstall \
			theuninstall \
			postuninstall

verify:			

preinstallchecks:	check_commands \
			check_media_exists \
			check_media_checksums \
			check_prerequisites

preinstall:		

theinstall:		install_itnm \

postinstall:		clean

preuninstallchecks:	check_commands \
			check_media_exists \
			check_media_checksums

preuninstall:

theuninstall:		uninstall_itnm \
			remove_itnm_path
			remove_root_path 

postuninstall:		clean

clean:			remove_temp_dir \
			remove_itnm_install_response_file \
			remove_itnm_uninstall_response_file \
			clean_tmp

scrub:			uninstall \
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
	@$(call func_print_caption,"CHECKING WHOAMI")
	@if [ "$(USER)" = "root" ] ; \
	then \
		$(CMD_ECHO) "Who am I Check (OK):     #$(USER)" ; \
	else \
		$(CMD_ECHO) "Who am I Check (FAIL):   #$(USER)" ; \
		$(CMD_PRINTF) "\n\
Please run this makefile as root for the necessary permissions to install\n\
or uninstall $(MAKE_PRODUCT).\n\n" ; \
		exit 1; \
	fi
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
	@$(foreach itr_m,$(MEDIA_ALL_FILES),\
	$(CMD_TEST) -f $(itr_m) || { $(CMD_ECHO) \
		"Media Check (FAIL):      #$(itr_m) non-existent" ; exit 2; } ; \
	$(CMD_TEST) -r $(itr_m) || { $(CMD_ECHO) \
		"Media Check (FAIL):      #$(itr_m) not readable" ; exit 3; } ; \
	$(CMD_ECHO) "Media Check (OK):        #$(itr_m)" ; \
	)
	@$(CMD_ECHO)

################################################################################
# CONFIRM MEDIA INTEGRITY VIA CHECKSUMS
################################################################################
check_media_checksums:	check_commands
	@$(call func_print_caption,"CHECKING INSTALLATION MEDIA CHECKSUMS")
	@$(call func_check_file_cksum,$(MEDIA_STEP1_F),$(MEDIA_STEP1_B))
	@$(call func_check_file_cksum,$(MEDIA_STEP2_F),$(MEDIA_STEP2_B))
	@$(CMD_ECHO)

################################################################################
# CREATE TEMPORARY DIRECTORY
################################################################################
create_temp_dir:	check_whoami \
			check_commands
	@$(call func_print_caption,"CREATING TEMPORARY DIRECTORY")
	@$(CMD_TEST) -n "$(PATH_TEMP_DIR)" || { $(CMD_ECHO) \
		"Directory mktemp (FAIL): $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null" ; \
		exit 4; }
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
	@$(call func_print_caption,"CHECKING PREREQUISITES FOR ITNM")
	@$(call func_tar_xf_to_new_dir,root,root,755,$(MEDIA_STEP1_F),$(PATH_TEMP_DIR)/$(MAKE_PRODUCT))
	@$(CMD_ECHO) "Prereq Check:            $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s"
	@$(CMD_ECHO)
	@$(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s; rc=$$? ; \
	if [ $$rc -ne 0 -a $$rc -ne 3 ] ; \
	then \
		$(CMD_ECHO) "Prereq Check (FAIL):     $(PATH_TEMP_DIR)/$(MAKE_PRODUCT)/prereq_checker.sh $(MAKE_PRODUCT_PREREQS) outputDir=$(PATH_TEMP_DIR)/$(MAKE_PRODUCT) detail -s" ; \
		exit 5; \
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
# CREATE THE ITNM PATH DIRECTORY IF IT DOESN'T EXIST
################################################################################
create_itnm_path:	check_whoami \
			check_commands \
			create_itnm_user
	@$(call func_print_caption,"CREATING NETWORK MANAGER INSTALL DIRECTORY IF NEEDED")
	@$(call func_mkdir,$(ITNM_USER),$(ITNM_GROUP),755,$(PATH_INSTALL_NETCOOL))
	@$(CMD_ECHO)

# if empty remove path, else backup with timestamp to preserve custom artifacts
remove_itnm_path:	check_whoami \
			check_commands
	@$(call func_print_caption,"REMOVING NETWORK MANAGER INSTALL DIRECTORY IF EMPTY")
	@$(call func_rmdir_if_empty,$(PATH_INSTALL_PRECISION))
	@$(call func_mv_if_exists,root,$(PATH_INSTALL_PRECISION),$(PATH_INSTALL_PRECISION).$(TIMESTAMP))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE GROUPS
################################################################################
create_itnm_group:	check_whoami \
			check_commands
	@$(call func_print_caption,"CONFIRMING/CREATING ITNM GROUP")
	@$(call func_create_group,$(ITNM_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# REMOVE GROUPS
################################################################################
remove_itnm_group:	check_whoami \
			check_commands \
			remove_itnm_user
	@$(call func_print_caption,"REMOVING ITNM GROUP")
	@$(call func_remove_group,$(ITNM_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE USERS
################################################################################
create_itnm_user:	check_whoami \
			check_commands \
			create_itnm_group
	@$(call func_print_caption,"CONFIRMING/CREATING ITNM USER")
	@$(call func_create_user,$(ITNM_USER),$(MAKE_PRODUCT),$(ITNM_GROUP),$(ITNM_HOME),$(ITNM_SHELL),$(ITNM_PASSWD))

################################################################################
# REMOVE USERS
################################################################################
remove_itnm_user:	check_whoami \
			check_commands
	@$(call func_print_caption,"REMOVING ITNM USER")
	@$(call func_remove_user,$(ITNM_USER),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# PREPARE NETCOOL NETWORK MANAGER MEDIA (INSTALLATION)
################################################################################
prepare_itnm_install_media:	check_whoami \
				check_commands \
				create_itnm_user

	@$(call func_print_caption,"PREPARING NETCOOL NETWORK MANAGER INSTALLATION MEDIA")
	@$(call func_unzip_to_new_dir,$(ITNM_USER),$(ITNM_GROUP),755,$(MEDIA_STEP2_F),$(PATH_REPOSITORY_INSTALL))
	@$(CMD_ECHO)

################################################################################
# CREATE ITNM RESPONSE FILE (INSTALLATION)
################################################################################
create_itnm_install_response_file:	check_whoami \
					check_commands
	@$(call func_print_caption,"CREATING NETCOOL NETWORK MANAGER INSTALLATION RESPONSE FILE")
	@$(CMD_ECHO) "$$ITNM_INSTALL_RESPONSE_FILE_CONTENT" > $(ITNM_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "ITNM Resp File (FAIL): #$(ITNM_INSTALL_RESPONSE_FILE)" ; \
		exit 6; }
	@$(CMD_ECHO) "ITNM Resp File (OK):   #$(ITNM_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(ITNM_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_itnm_install_response_file:    check_commands
	@$(call func_print_caption,"REMOVING NETCOOL NETWORK MANAGER INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(ITNM_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# INSTALL NETCOOL NETWORK MANAGER AS $(ITNM_USER)
################################################################################
install_itnm:		check_whoami \
			check_commands \
			prepare_itnm_install_media \
			create_itnm_install_response_file \
			create_itnm_user \
			create_root_path \
			create_itnm_path

	@$(call func_print_caption,"INSTALLING NETCOOL NETWORK MANAGER")
	@if [ -d "$(PATH_INSTALL_PRECISION)" ] ; \
	then \
		$(CMD_ECHO) "ITNM Exists? (WARN):   -d $(PATH_INSTALL_PRECISION) # exists" ; \
	else \
		$(CMD_ECHO) "ITNM Exists? (OK):     -d $(PATH_INSTALL_PRECISION) # non-existent" ; \
		$(call func_prepare_installation_manager,$(ITNM_USER),$(ITNM_HOME),$(PATH_REPOSITORY_INSTALL)) ; \
		$(call func_command_check,$(ITNM_CMD_IMCL)) \
		\
		$(CMD_ECHO) "ITNM Install:          #In progress..." ; \
		$(CMD_SU) - $(ITNM_USER) -c "$(ITNM_CMD_IMCL) input \
			$(ITNM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
			{ $(CMD_ECHO) "ITNM Install (FAIL):   $(CMD_SU) - $(ITNM_USER) -c \"$(ITNM_CMD_IMCL) input $(ITNM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
			exit 7; } ; \
		$(CMD_ECHO) "ITNM Install (OK):     $(CMD_SU) - $(ITNM_USER) -c \"$(ITNM_CMD_IMCL) input $(ITNM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CREATE THE ITNM UNINSTALLATION RESPONSE FILE
################################################################################
create_webgui_uninstall_response_file:	check_commands
	@$(call func_print_caption,"CREATING NETCOOL/ITNM UNINSTALLATION RESPONSE FILE")
	@if [ -d "$(PATH_INSTALL_ITNM)" ] ; \
	then \
		$(CMD_ECHO) "ITNM Exists? (OK):     -d $(PATH_INSTALL_ITNM) # exists" ; \
		$(call func_command_check,$(ITNM_CMD_IMCL)) \
		temp_version=`$(CMD_SU) - $(ITNM_USER) -c "$(ITNM_CMD_IMCL) listInstalledPackages" | $(CMD_GREP) ^$(PATH_REPOSITORY_ITNM_PACKAGE) | $(CMD_CUT) -d_ -f2` ; \
		temp_version_count=`$(CMD_ECHO) $$temp_version | $(CMD_WC) -w` ; \
		if [ $$temp_version_count -eq 1 ] ; \
		then \
			$(CMD_ECHO) "ITNM Version? (OK):    #$$temp_version found" ; \
			$(CMD_ECHO) "$$ITNM_UNINSTALL_RESPONSE_FILE_CONTENT" | $(CMD_SED) -e "s/<PACKAGE_VERSION>/$$temp_version/g" > $(ITNM_UNINSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
				 "Response File (FAIL):    #$(ITNM_UNINSTALL_RESPONSE_FILE) generation failed" ; \
				exit 12; } ; \
			$(CMD_ECHO) "Response File (OK):      #$(ITNM_UNINSTALL_RESPONSE_FILE) generated successfully" ; \
			$(call func_chmod,444,$(ITNM_UNINSTALL_RESPONSE_FILE)) ; \
		else \
			if [ $$temp_version_count -eq 0 ] ; \
			then \
				$(CMD_ECHO) "ITNM Version? (FAIL):  #Package ^$(PATH_REPOSITORY_ITNM_PACKAGE)_* not found" ; \
				exit 13 ; \
			else \
				$(CMD_ECHO) "ITNM Version? (FAIL):  #Too many versions found, expected 1 but found $$temp_version_count ($$temp_version)" ; \
				exit 14 ; \
			fi ; \
		fi ; \
	else \
		$(CMD_ECHO) "ITNM Exists? (OK):     -d $(PATH_INSTALL_ITNM) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

remove_itnm_uninstall_response_file:	check_commands
	@$(call func_print_caption,"REMOVING NETCOOL ITNM UNINSTALL RESPONSE FILE")
	@$(CMD_RM) -f $(ITNM_UNINSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# UNINSTALL ITNM
################################################################################
uninstall_webgui:		check_whoami \
				check_commands \
				create_webgui_uninstall_response_file

	@$(call func_print_caption,"UNINSTALLING ITNM")
	@if [ -d "$(PATH_INSTALL_ITNM)" ] ; \
	then \
		$(CMD_ECHO) "ITNM Exists? (OK):     -d $(PATH_INSTALL_ITNM) # exists" ; \
		$(call func_command_check,$(ITNM_CMD_IMCL)) \
		$(CMD_ECHO) "ITNM Uninstall:        #In progress..." ; \
		$(CMD_SU) - $(ITNM_USER) -c "$(ITNM_CMD_IMCL) input $(ITNM_UNINSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
		{ $(CMD_ECHO) "ITNM Uninstall (FAIL): $(CMD_SU) - $(ITNM_USER) -c \"$(ITNM_CMD_IMCL) input $(ITNM_UNINSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
		exit 15; } ; \
		$(CMD_ECHO) "ITNM Uninstall (OK):   $(CMD_SU) - $(ITNM_USER) -c \"$(ITNM_CMD_IMCL) input $(ITNM_UNINSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	else \
		$(CMD_ECHO) "ITNM Exists? (OK):     -d $(PATH_INSTALL__ITNM) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:	check_commands
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM) -rf /tmp/ciclogs_$(ITNM_USER) /tmp/javasharedresources
	@$(CMD_ECHO)

