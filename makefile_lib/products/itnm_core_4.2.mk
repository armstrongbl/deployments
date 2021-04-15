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
## (c) 2015-2020 Accuoss, LLC. All rights reserved.                           ##
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
# IBM Tivoli Netcool/ITNM 4.2.0.5 
# Accuoss 
# June 17, 2020
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
MAKE_PRODUCT		= ITNM
MAKE_PRODUCT_PREREQS	= TNM
MAKE_FORCE		= FALSE

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL		:= /opt/IBM
PATH_INSTALL_NETCOOL	= $(PATH_INSTALL)/netcool
PATH_INSTALL_ITNM	= $(PATH_INSTALL_NETCOOL)/itnm

################################################################################
# TEMPORARY MAKE DIRECTORY
################################################################################
PATH_TEMP_BASE		:= $(MAKE_PRODUCT).make
PATH_TEMP_TEMPLATE	:= $(PATH_TMP)/$(PATH_TEMP_BASE).XXXXXXXX
PATH_TEMP_DIR		:= $(shell $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null)

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_INSTALL	:= $(PATH_MAKEFILE_REPOSITORY)/itnm_core_4_2_install

PATH_REPOSITORY_ITNM_PACKAGE=com.ibm.tivoli.itnm.core_

################################################################################
# INSTALLATION USERS
################################################################################
ITNM_USER		:= netcool
ITNM_PASSWD		:= $(ITNM_USER)
ITNM_GROUP		:= ncoadmin
ITNM_SHELL		:= /bin/bash
ITNM_HOME		:= $(PATH_HOME)/$(ITNM_USER)
ITNM_ADMIN_USER		:= itnmadmin
ITNM_ADMIN_PASS		:=$(ITNM_ADMIN_USER)

ITNM_BASHRC		:= $(ITNM_HOME)/.bashrc
ITNM_BASHPROFILE	:= $(ITNM_HOME)/.bash_profile

################################################################################
# ITNM DATABASE CONFIGURATION
################################################################################
DB_HOST   = nmsdb2-01
DB_NAME   = db2inst1
DB_PASSWD = db2inst1
DB_PORT   = 50000
DB_TYPE   = db2
DB_USER   = db2inst1

################################################################################
# OMNIBUS CONFIGURATION
################################################################################
OMNIBUS_OS_HOST		= nmsfms01
OMNIBUS_OS_NAME		= NBN_DIS1
OMNIBUS_OS_PASSWD	= 
OMNIBUS_OS_PORT		= 4100
OMNIBUS_OS_USER		= root

ITNM_DOMAIN		= NBN

################################################################################
# IBMIM CONFIGURATION AND PACKAGE VERIFICATION
################################################################################
ITNM_IMSHARED	:= $(ITNM_HOME)/IBM/IMShared 
ITNM_CMD_IMCL	:= $(ITNM_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)

ITNM_LDD_CHECKS	= $(shell $(CMD_LS) $(PATH_INSTALL_ITNM)/platform/linux2x86/bin*/nco* | $(CMD_GREP) -v env$)

ITNM_PACKAGES	=	$(PACKAGES_COMMON) \
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

################################################################################
# ULIMIT FILES / VALUES
################################################################################
ITNM_NOFILE_FILE		:= $(PATH_LIMITS)/91-nofile.conf
ITNM_NOFILE_FILE_CONTENT	:= "\
*          soft    nofile     131073\n\
*          hard    nofile     131073\n"

ITNM_NPROC_FILE		:= $(PATH_LIMITS)/90-nproc.conf
ITNM_NPROC_FILE_CONTENT	:= "\
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
				\t$(MEDIA_STEP2_D)\n

MEDIA_ALL_FILES	=	$(MEDIA_STEP2_F)

MEDIA_STEP1_D	:=	IBM Prerequisite Scanner V1.2.0.17, Build 20150827
MEDIA_STEP2_D	:=	IBM Tivoli Network Manager V4.2

MEDIA_STEP1_F	:=	$(PATH_MAKEFILE_MEDIA)/1.2.0.18-Tivoli-PRS-Unix-fp0001.tar
MEDIA_STEP2_F	:=	$(PATH_MAKEFILE_MEDIA)/ITNMIPEV4.2.0.7LNXML.zip

MEDIA_STEP1_B	:=	fe17ed5d7ca2d6df7e139e0d7fe5ce1b615a078bc12831556dd24b0b4515690121d317d9c5a13909573a0dec21532c218ac9db21731e93cddb19424e241b09b4
MEDIA_STEP2_B	:=	c09a49b5227344e2521d472827f5af655fcb719d4dbaeebb6581d824a818b1c5e8f71baacc38a6a33ae07e3659ccbcc5d46f02866b86b86386afee17844452e9


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
  <profile id='IBM Netcool Core Components' installLocation='$(PATH_INSTALL_ITNM)'>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.itnm.NetworkManagerDomainName,com.ibm.tivoli.netcool.itnm.core' value='$(ITNM_DOMAIN)'/>
    <data key='user.itnm.StormUserId,com.ibm.tivoli.netcool.itnm.core' value='$(ITNM_USER)'/>
    <data key='user.itnm.StormUserGroup,com.ibm.tivoli.netcool.itnm.core' value='$(ITNM_GROUP)'/>
    <data key='user.itnm.PathToPython,com.ibm.tivoli.netcool.itnm.core' value='/usr/bin/python'/>
    <data key='user.itnm.StormZooKeeperPort,com.ibm.tivoli.netcool.itnm.core' value='2181'/>
    <data key='user.itnm.ObjectServerUsername,com.ibm.tivoli.netcool.itnm.core' value='$(OMNIBUS_OS_USER)'/>
    <data key='user.itnm.ObjectServerPassword,com.ibm.tivoli.netcool.itnm.core' value='$(OMNIBUS_OS_PASSWD)'/>
    <data key='user.itnm.ObjectServer.skip.validation,com.ibm.tivoli.netcool.itnm.core' value='false'/>
    <data key='user.itnm.ObjectServerHostname,com.ibm.tivoli.netcool.itnm.core' value='$(OMNIBUS_OS_HOST)'/>
    <data key='user.itnm.ObjectServerName,com.ibm.tivoli.netcool.itnm.core' value='$(OMNIBUS_OS_NAME)'/>
    <data key='user.itnm.ObjectServer.create.instance,com.ibm.tivoli.netcool.itnm.core' value='false'/>
    <data key='user.itnm.ObjectServerMainPort,com.ibm.tivoli.netcool.itnm.core' value='$(OMNIBUS_OS_PORT)'/>
    <data key='user.itnm.ObjectServerItnmUserPassword.confirm,com.ibm.tivoli.netcool.itnm.core' value='$(ITNM_ADMIN_USER)'/>
    <data key='user.itnm.ObjectServerItnmUserPassword,com.ibm.tivoli.netcool.itnm.core' value='$(ITNM_ADMIN_PASS)'/>
    <data key='user.itnm.database.server.type,com.ibm.tivoli.netcool.itnm.core' value='$(DB_TYPE)'/>
    <data key='user.itnm.database.skip.validation,com.ibm.tivoli.netcool.itnm.core' value='true'/>
    <data key='user.itnm.database.name,com.ibm.tivoli.netcool.itnm.core' value='$(DB_NAME)'/>
    <data key='user.itnm.database.hostname,com.ibm.tivoli.netcool.itnm.core' value='$(DB_HOST)'/>
    <data key='user.itnm.database.username,com.ibm.tivoli.netcool.itnm.core' value='$(DB_USER)'/>
    <data key='user.itnm.database.password,com.ibm.tivoli.netcool.itnm.core' value='$(DB_PASSWD)'/>
    <data key='user.itnm.database.create.tables,com.ibm.tivoli.netcool.itnm.core' value='false'/>
    <data key='user.itnm.database.port,com.ibm.tivoli.netcool.itnm.core' value='$(DB_PORT)'/>
  </profile>
  <install>
    <!-- Network Manager Core Components 4.2.0.7 -->
    <offering profile='IBM Netcool Core Components' id='com.ibm.tivoli.netcool.itnm.core' version='4.2.7.20190531_1310' features='itnm.core,non.fips.compliant'/>
    <!-- Network Manager topology database creation scripts 4.2.0.7 -->
    <offering profile='IBM Netcool Core Components' id='com.ibm.tivoli.netcool.itnm.dbscripts' version='4.2.7.20190531_1310' features='db2.feature,oracle.feature'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
</agent-input>
endef
export ITNM_INSTALL_RESPONSE_FILE_CONTENT

################################################################################
# SYSTEMD SERVICE CONFIGURATION FILE
################################################################################

################################################################################
# MAIN BUILD TARGETS
#					check_prerequisites
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
					check_media_checksums 

preinstall:			set_limits

theinstall:			install_itnm 

postinstall:		clean

preuninstallchecks:	check_commands \
					check_media_exists \
					check_media_checksums

preuninstall:

theuninstall:		autostartoff_itnm \
					uninstall_itnm

postuninstall:		remove_netcool_path \
					remove_root_path \
					clean

clean:				remove_temp_dir \
					remove_itnm_install_response_file \
					remove_itnm_upgrade_response_file \
					clean_tmp

scrub:				uninstall \
					remove_limits \
					clean

# WARNING scrub_users WILL REMOVE USERS AND HOME DIRECTORIES INCLUDING ALL
# CONTENT AND ANY INSTALL MANAGERS IN SAME.  IF THE SAME USERNAME IS USED
# FOR MORE THAN ONE PRODUCT INSTALL, THEN THIS SHOULD BE DONE WITH EXTREME
# CAUTION
scrub_users:		remove_itnm_group \
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
	@$(CMD_ECHO)

################################################################################
# INSTALL PREREQUISITE PACKAGES
################################################################################
install_packages:	check_whoami
	@$(call func_print_caption,"INSTALLING PREREQUISITE PACKAGES")
	@$(call func_install_packages,$(ITNM_PACKAGES))
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
	@$(call func_print_caption,"CHECKING PREREQUISITES FOR ITNM")
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
	@$(call func_set_limits,$(ITNM_NPROC_FILE),$(ITNM_NPROC_FILE_CONTENT))
	@$(call func_set_limits,$(ITNM_NOFILE_FILE),$(ITNM_NOFILE_FILE_CONTENT))
	@$(CMD_ECHO)

################################################################################
# REMOVE ULIMITS
################################################################################
remove_limits:		check_whoami \
					check_commands
	@$(call func_print_caption,"REMOVING LIMITS")
	@$(CMD_RM) -f $(ITNM_NPROC_FILE)
	@$(CMD_RM) -f $(ITNM_NOFILE_FILE)
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
						create_itnm_user
	@$(call func_print_caption,"CREATING NETCOOL INSTALL DIRECTORY IF NEEDED")
	@$(call func_mkdir,$(ITNM_USER),$(ITNM_GROUP),755,$(PATH_INSTALL_NETCOOL))
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

	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),PATH,$(PATH_INSTALL_ITNM)/bin)
	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHPROFILE),PATH,$(PATH_INSTALL_ITNM)/bin)

################################################################################
# As instructed by PI Installation Guide, do not set NCHOME if OMNIbus
# and PI are on the same server owned by same user.  "Setting NCHOME may cause
# the probe to point to the wrong location and not run."
################################################################################
#	@$(call func_setenv_set_and_export_in_file,$(ITNM_USER),$(ITNM_BASHRC),NCHOME,$(PATH_INSTALL_NETCOOL),644)
#	@$(call func_setenv_set_and_export_in_file,$(ITNM_USER),$(ITNM_BASHPROFILE),NCHOME,$(PATH_INSTALL_NETCOOL),644)

	#@$(call func_setenv_set_and_export_in_file,$(ITNM_USER),$(ITNM_BASHRC),OMNIHOME,$(PATH_INSTALL_ITNM),644)
	#@$(call func_setenv_set_and_export_in_file,$(ITNM_USER),$(ITNM_BASHPROFILE),OMNIHOME,$(PATH_INSTALL_ITNM),644)

	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),LD_LIBRARY_PATH,/usr/lib64)
	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),LD_LIBRARY_PATH,/usr/lib)
	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_NETCOOL)/platform/linux2x86/lib)
	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_NETCOOL)/platform/linux2x86/lib64)
	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_ITNM)/platform/linux2x86/lib)
	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_ITNM)/platform/linux2x86/lib64)
	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_NETCOOL)/platform/linux2x86/jre_1.7.0/jre/bin/j9vm)
	#@$(call func_setenv_append_and_export_in_file,$(ITNM_BASHRC),LD_LIBRARY_PATH,$(PATH_INSTALL_NETCOOL)/platform/linux2x86/jre64_1.7.0/jre/bin/j9vm)
	#@$(CMD_ECHO)

################################################################################
# REMOVE USERS
################################################################################
remove_itnm_user:	check_whoami \
						check_commands
	@$(call func_print_caption,"REMOVING ITNM USER")
	@$(call func_remove_user,$(ITNM_USER),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# PREPARE NETCOOL/ITNM CORE MEDIA (INSTALLATION)
################################################################################
prepare_itnm_install_media:	check_whoami \
								check_commands \
								check_media_exists \
								check_media_checksums \
								create_itnm_user

	@$(call func_print_caption,"PREPARING NETCOOL/ITNM CORE MEDIA (INSTALLATION)")
	@$(call func_unzip_to_new_dir,$(ITNM_USER),$(ITNM_GROUP),755,$(MEDIA_STEP2_F),$(PATH_REPOSITORY_INSTALL))
	@$(CMD_ECHO)

################################################################################
# CREATE ITNM RESPONSE FILE (INSTALLATION)
################################################################################
create_response_file:	check_whoami \
										check_commands

	@$(call func_print_caption,"CREATING ITNM INSTALLATION RESPONSE FILE")
	@$(CMD_ECHO) "$$ITNM_INSTALL_RESPONSE_FILE_CONTENT" > $(ITNM_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "ITNM Resp File (FAIL):#$(ITNM_INSTALL_RESPONSE_FILE)" ; \
		exit 3; }
	@$(CMD_ECHO) "ITNM Resp File (OK):  #$(ITNM_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(ITNM_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_response_file:	check_commands
	@$(call func_print_caption,"REMOVING ITNM INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(ITNM_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# INSTALL NETCOOL/ITNM CORE AS $(ITNM_USER)
################################################################################
install_itnm:		check_whoami \
						check_commands \
						prepare_itnm_install_media \
						create_response_file \
						create_itnm_user \
						create_root_path \
						create_netcool_path

	@$(call func_print_caption,"INSTALLING NETCOOL/ITNM")
	@if [ -d "$(PATH_INSTALL_ITNM)" ] ; \
	then \
		$(CMD_ECHO) "ITNM Exists? (WARN):  -d $(PATH_INSTALL_ITNM) # already exists" ; \
	else \
		$(CMD_ECHO) "ITNM Exists? (OK):    -d $(PATH_INSTALL_ITNM) # non-existent" ; \
		$(call func_prepare_installation_manager,$(ITNM_USER),$(ITNM_HOME),$(PATH_REPOSITORY_INSTALL)) ; \
		$(call func_command_check,$(ITNM_CMD_IMCL)) ; \
		\
		$(CMD_ECHO) "ITNM Install:         #In progress..." ; \
		$(CMD_SU) - $(ITNM_USER) -c "$(ITNM_CMD_IMCL) input \
			$(ITNM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
			{ $(CMD_ECHO) "ITNM Install: (FAIL): $(CMD_SU) - $(ITNM_USER) -c \"$(ITNM_CMD_IMCL) input $(ITNM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
			exit 4; } ; \
		$(CMD_ECHO) "ITNM Install (OK):    $(CMD_SU) - $(ITNM_USER) -c \"$(ITNM_CMD_IMCL) input $(ITNM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	fi ;

################################################################################
# CONFIRM SHARED LIBRARIES
################################################################################
confirm_shared_libraries:	check_whoami \
							check_commands

	@$(call func_print_caption,"CONFIRMING SHARED LIBRARIES FOR NETCOOL/ITNM")
	@$(foreach itr_x,$(ITNM_LDD_CHECKS),\
		$(CMD_PRINTF) "Shared Lib Check:        $(CMD_SU) - $(ITNM_USER) -c \"$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found\"\n" ; \
		$(CMD_SU) - $(ITNM_USER) -c "$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found"; $(CMD_TEST) $$? -lt 2; \
	)

	@$(foreach itr_x,$(ITNM_LDD_CHECKS),\
		$(CMD_SU) - $(ITNM_USER) -c "$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found 1> /dev/null 2>&1"; $(CMD_TEST) $$? -eq 1 || { \
			$(CMD_ECHO) "Shared Lib Check (FAIL): #Missing shared library dependencies"; \
			exit 5; \
		} ; \
	)

	@$(CMD_ECHO) "Shared Lib Check (OK):   #No missing shared library dependencies"
	@$(CMD_ECHO)

################################################################################
# PREPARE NETCOOL/ITNM CORE MEDIA (UPGRADE)
################################################################################
prepare_itnm_upgrade_media:	check_whoami \
								check_commands \
								create_itnm_user

	@$(call func_print_caption,"PREPARING NETCOOL/ITNM CORE MEDIA (UPGRADE)")
	@$(call func_unzip_to_new_dir,$(ITNM_USER),$(ITNM_GROUP),755,$(MEDIA_STEP3_F),$(PATH_REPOSITORY_UPGRADE))
	@$(CMD_ECHO)

################################################################################
# CREATE ITNM RESPONSE FILE (UPGRADE)
################################################################################
create_itnm_upgrade_response_file:	check_whoami \
										check_commands

	@$(call func_print_caption,"CREATING ITNM UPGRADE RESPONSE FILE")
	@$(CMD_ECHO) "$$ITNM_UPGRADE_RESPONSE_FILE_CONTENT" > $(ITNM_UPGRADE_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "ITNM Resp File (FAIL):#$(ITNM_UPGRADE_RESPONSE_FILE)" ; \
		exit 6; }
	@$(CMD_ECHO) "ITNM Resp File (OK):  #$(ITNM_UPGRADE_RESPONSE_FILE)"
	@$(call func_chmod,444,$(ITNM_UPGRADE_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_itnm_upgrade_response_file:   check_commands
	@$(call func_print_caption,"REMOVING ITNM UPGRADE RESPONSE FILE")
	@$(CMD_RM) -f $(ITNM_UPGRADE_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# UPGRADE NETCOOL/ITNM CORE AS $(ITNM_USER)
################################################################################
upgrade_itnm:		check_whoami \
						check_commands \
						prepare_itnm_upgrade_media \
						create_itnm_upgrade_response_file

	@$(call func_print_caption,"UPGRADING ITNM")
	@if [ -d "$(PATH_INSTALL_ITNM)" ] ; \
	then \
		$(CMD_ECHO) "ITNM Exists? (OK):    -d $(PATH_INSTALL_ITNM) # already exists" ; \
	else \
		$(CMD_ECHO) "ITNM Exists? (FAIL):  -d $(PATH_INSTALL_ITNM) # non-existent" ; \
		exit 7; \
	fi ;

	@$(call func_command_check,$(ITNM_CMD_IMCL))

	@$(CMD_ECHO) "ITNM Upgrade:         #In progress..."
	@$(CMD_SU) - $(ITNM_USER) -c "$(ITNM_CMD_IMCL) input \
		$(ITNM_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
		{ $(CMD_ECHO) "ITNM Upgrade (FAIL):  $(CMD_SU) - $(ITNM_USER) -c \"$(ITNM_CMD_IMCL) input $(ITNM_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
		exit 8; }
	@$(CMD_ECHO) "ITNM Upgrade (OK):    $(CMD_SU) - $(ITNM_USER) -c \"$(ITNM_CMD_IMCL) input $(ITNM_UPGRADE_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\""
	@$(CMD_ECHO)

################################################################################
# UNINSTALL NETCOOL/ITNM CORE
################################################################################
uninstall_itnm:	check_whoami \
					check_commands

	@$(call func_print_caption,"UNINSTALLING NETCOOL/ITNM CORE")
	@if [ -d "$(PATH_INSTALL_ITNM)" ] ; \
	then \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_ITNM) # exists" ; \
		\
		$(CMD_ECHO) "nco_objserv PAM Remove:  $(CMD_RM) -f $(ETC_PAMD_NCO_OBJSERV)" ; \
		$(CMD_RM) -f $(ETC_PAMD_NCO_OBJSERV) ; \
		$(CMD_ECHO) "netcool PAM Remove:      $(CMD_RM) -f $(ETC_PAMD_NETCOOL)" ; \
		$(CMD_RM) -f $(ETC_PAMD_NETCOOL) ; \
		\
		$(call func_uninstall_im_package,$(ITNM_CMD_IMCL),$(ITNM_USER),$(PATH_REPOSITORY_ITNM_PACKAGE),OMNIbus Core) ; \
		\
		$(call func_mv_if_exists,$(ITNM_USER),$(PATH_INSTALL_ITNM),$(PATH_INSTALL_ITNM).$(TIMESTAMP)) ; \
	else \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_ITNM) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:	check_commands
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM) -rf /tmp/ciclogs_$(ITNM_USER)
	@$(CMD_ECHO)

