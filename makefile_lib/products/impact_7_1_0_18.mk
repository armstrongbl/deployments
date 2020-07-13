###############################################################################
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
# IBM Tivoli Netcool/Impact 8.1.0.19
# Accuoss 
# February 17, 2020
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
MAKE_PRODUCT		= IMPACT
MAKE_PRODUCT_PREREQS	= NCI
MAKE_FORCE		= FALSE

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL		:= /opt/IBM
PATH_INSTALL_NETCOOL	= $(PATH_INSTALL)/netcool
PATH_INSTALL_IMPACT	= $(PATH_INSTALL_NETCOOL)/impact

################################################################################
# TEMPORARY MAKE DIRECTORY
################################################################################
PATH_TEMP_BASE		:= $(MAKE_PRODUCT).make
PATH_TEMP_TEMPLATE	:= $(PATH_TMP)/$(PATH_TEMP_BASE).XXXXXXXX
PATH_TEMP_DIR		:= $(shell $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null)

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_INSTALL	:= $(PATH_MAKEFILE_REPOSITORY)/impact_7_1_0_18_install


################################################################################
# INSTALLATION TUNEABLES
################################################################################
IMPACT_USER		:= netcool
IMPACT_PASSWD		:= $(IMPACT_USER)
IMPACT_GROUP		:= ncoadmin
IMPACT_SHELL		:= /bin/bash
IMPACT_HOME		:= $(PATH_HOME)/$(IMPACT_USER)
IMPACT_BASHRC		:= $(IMPACT_HOME)/.bashrc
IMPACT_BASHPROFILE	:= $(IMPACT_HOME)/.bash_profile

IMPACT_IMSHARED	= $(IMPACT_HOME)/$(PATH_IM_SHARED_PATH)
IMPACT_CMD_IMCL	:= $(IMPACT_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)

IMPACT_PACKAGES	=	$(PACKAGES_COMMON) \
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

OBJSRV_NAME		:= AGG_V
OBJSRV_HOST		:= nmsfms01
OBJSRV_PORT		:= 4100
OBJSRV_USER		:= root
OBJSRV_PASS		:= $(IMPACT_USER)



################################################################################
# ULIMIT FILES / VALUES
################################################################################
IMPACT_NOFILE_FILE		:= $(PATH_LIMITS)/91-nofile.conf
IMPACT_NOFILE_FILE_CONTENT	:= "\
*          soft    nofile     131073\n\
*          hard    nofile     131073\n"

IMPACT_NPROC_FILE		:= $(PATH_LIMITS)/90-nproc.conf
IMPACT_NPROC_FILE_CONTENT	:= "\
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

MEDIA_ALL_FILES	=	$(MEDIA_STEP1_F) \
					$(MEDIA_STEP2_F) 

MEDIA_STEP1_D	:= IBM Prerequisite Scanner V1.2.0.17, Build 20150827
MEDIA_STEP2_D	:= IBM Tivoli Netcool Impact 8.1.0.19 Core Linux 64bit Multilingual\n\t\t(CN8HFML) 

MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/1.2.0.18-Tivoli-PRS-Unix-fp0001.tar
MEDIA_STEP2_F	:= $(PATH_MAKEFILE_MEDIA)/TNIV7.1.0.18__LNX_EN.zip

MEDIA_STEP1_B	:= fe17ed5d7ca2d6df7e139e0d7fe5ce1b615a078bc12831556dd24b0b4515690121d317d9c5a13909573a0dec21532c218ac9db21731e93cddb19424e241b09b4
MEDIA_STEP2_B	:= 4173d42d653563151b39eb233908f3fc8ba6ea37ef358f0a9ea41e0bfc2bfd06c96b83afad83982650f0f58174ce1d7e12bedfe78450a736c70b6486cb0051ad

################################################################################
# COMMAND TO BE INSTALLED BEFORE USE
################################################################################
#CMD_IBM_IMUTILSC	:= $(PATH_REPOSITORY_INSTALL)/im.linux.x86_64/tools/imutilsc

################################################################################
# IMPACT RESPONSE FILE TEMPLATE (INSTALL)
################################################################################
IMPACT_INSTALL_RESPONSE_FILE=$(PATH_TMP)/impact_install_response.xml
define IMPACT_INSTALL_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(IMPACT_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(PATH_REPOSITORY_INSTALL)/ImpactRepository/disk1'/>
    <repository location='$(PATH_REPOSITORY_INSTALL)/ImpactExtRepository/disk1'/>
  </server>
  <profile id='IBM Tivoli Netcool Impact' installLocation='$(PATH_INSTALL_IMPACT)'>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.userRegistry' value='ObjectServer'/>
    <data key='user.objectServerName' value='$(OBJSRV_NAME)'/>
    <data key='user.objectServerHost' value='$(OBJSRV_HOST)'/>
    <data key='user.objectServerPort' value='$(OBJSRV_PORT)'/>
    <data key='user.objectServerUser' value='$(OBJSRV_USER)'/>
    <data key='user.objectServerPwd' value='$(OBJSRV_PASS)'/>
    <data key='user.objectServerConfirmPassword' value='$(OBJSRV_PASS)'/>
    <data key='user.objectServerPassword' value='$(OBJSRV_PASS)'/>
    <data key='user.libertyUser' value='$(LIB_USER)'/>
    <data key='user.libertyPassword' value='$(LIB_PASS)'/>
    <data key='user.libertyConfirmPassword' value='$(LIB_PASS)'/>
    <data key='user.GUIInstanceName' value='ImpactUI'/>
    <data key='user.liberty.guiHttpPort' value='16310'/>
    <data key='user.liberty.httpPort' value='9080'/>
    <data key='user.liberty.rmiPort' value='30000'/>
    <data key='user.activeMQBrokerPort' value='16399'/>
    <data key='user.nameServerPrimaryPort' value='9080'/>
    <data key='user.nameServerPrimaryHost' value='nmsimpact01'/>
    <data key='user.localHostName' value='nmsimpact01'/>
    <data key='user.nciServerInstanceName,com.ibm.tivoli.impact.server' value='NCI'/>
    <data key='user.nciPortNumber,com.ibm.tivoli.impact.server' value='2000'/>
    <data key='user.nciClusterName,com.ibm.tivoli.impact.server' value='NCICLUSTER'/>
    <data key='user.derbyType,com.ibm.tivoli.impact.server' value='PrimaryStandalone'/>
    <data key='user.derbyPrimaryHost,com.ibm.tivoli.impact.server' value='$(HOST_FQDN)'/>
    <data key='user.derbyReplicationPort,com.ibm.tivoli.impact.server' value='4851'/>
    <data key='user.derbyBackupHost,com.ibm.tivoli.impact.server' value='$(HOST_FQDN)'/>
    <data key='user.derbyBackupPort,com.ibm.tivoli.impact.server' value='1527'/>
    <data key='user.derbyPrimaryPort,com.ibm.tivoli.impact.server' value='1527'/>
    <data key='user.libertyHttpPort' value='9080'/>
    <data key='user.libertyRmiPort' value='30000'/>
    <data key='user.nciServerInstanceName' value='NCI'/>
  </profile>
  <install>
    <!-- IBM Tivoli Netcool/Impact GUI Server 7.1.0.18 -->
    <offering profile='IBM Tivoli Netcool Impact' id='com.ibm.tivoli.impact.gui_server' version='7.1.0.20200311_1939' features='main.gui_feature'/>
    <!-- IBM Tivoli Netcool/Impact Server 7.1.0.18 -->
    <offering profile='IBM Tivoli Netcool Impact' id='com.ibm.tivoli.impact.server' version='7.1.0.20200311_1939' features='main.server_feature'/>
    <!-- IBM Tivoli Netcool/Impact Server Extensions for Netcool Operations Insight 7.1.0.18 -->
    <offering profile='IBM Tivoli Netcool Impact' id='com.ibm.tivoli.impact.server_extensions' version='7.1.0.20200311_1957' features='main.server_extensions_feature'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
</agent-input>
endef
export IMPACT_INSTALL_RESPONSE_FILE_CONTENT

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
					check_media_checksums 

preinstall:			set_limits

theinstall:			install_impact \
					confirm_shared_libraries \
					autostarton_impact

postinstall:		clean

preuninstallchecks:	check_commands \
					check_media_exists \
					check_media_checksums

preuninstall:

theuninstall:		autostartoff_impact \
					uninstall_impact

postuninstall:		remove_netcool_path \
					remove_root_path \
					clean

clean:				remove_temp_dir \
					remove_impact_install_response_file \
					remove_impact_upgrade_response_file \
					clean_tmp

scrub:				uninstall \
					remove_limits \
					clean

# WARNING scrub_users WILL REMOVE USERS AND HOME DIRECTORIES INCLUDING ALL
# CONTENT AND ANY INSTALL MANAGERS IN SAME.  IF THE SAME USERNAME IS USED
# FOR MORE THAN ONE PRODUCT INSTALL, THEN THIS SHOULD BE DONE WITH EXTREME
# CAUTION
scrub_users:		remove_impact_group \
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
	@$(call func_install_packages,$(IMPACT_PACKAGES))
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
	@$(call func_print_caption,"CHECKING PREREQUISITES FOR IMPACT")
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
	@$(call func_set_limits,$(IMPACT_NPROC_FILE),$(IMPACT_NPROC_FILE_CONTENT))
	@$(call func_set_limits,$(IMPACT_NOFILE_FILE),$(IMPACT_NOFILE_FILE_CONTENT))
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
						create_impact_user
	@$(call func_print_caption,"CREATING NETCOOL INSTALL DIRECTORY IF NEEDED")
	@$(call func_mkdir,$(IMPACT_USER),$(IMPACT_GROUP),755,$(PATH_INSTALL_NETCOOL))
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
create_impact_group:	check_whoami \
						check_commands
	@$(call func_print_caption,"CONFIRMING/CREATING IMPACT GROUP")
	@$(call func_create_group,$(IMPACT_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# REMOVE GROUPS
################################################################################
remove_impact_group:	check_whoami \
						check_commands \
						remove_impact_user
	@$(call func_print_caption,"REMOVING IMPACT GROUP")
	@$(call func_remove_group,$(IMPACT_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE USERS
################################################################################
create_impact_user:	check_whoami \
						check_commands \
						create_impact_group
	@$(call func_print_caption,"CONFIRMING/CREATING IMPACT USER")
	@$(call func_create_user,$(IMPACT_USER),$(MAKE_PRODUCT),$(IMPACT_GROUP),$(IMPACT_HOME),$(IMPACT_SHELL),$(IMPACT_PASSWD))

	@$(call func_setenv_append_and_export_in_file,$(IMPACT_BASHRC),PATH,$(PATH_INSTALL_IMPACT)/bin)
	@$(call func_setenv_append_and_export_in_file,$(IMPACT_BASHPROFILE),PATH,$(PATH_INSTALL_IMPACT)/bin)

################################################################################
# PREPARE NETCOOL/IMPACT CORE MEDIA (INSTALLATION)
################################################################################
prepare_impact_install_media:	check_whoami \
								check_commands \
								check_media_exists \
								check_media_checksums \
								create_impact_user

	@$(call func_print_caption,"PREPARING NETCOOL/IMPACT CORE MEDIA (INSTALLATION)")
	@$(call func_unzip_to_new_dir,$(IMPACT_USER),$(IMPACT_GROUP),755,$(MEDIA_STEP2_F),$(PATH_REPOSITORY_INSTALL))
	@$(CMD_ECHO)

################################################################################
# CREATE IMPACT RESPONSE FILE (INSTALLATION)
################################################################################
create_impact_install_response_file:	check_whoami \
										check_commands

	@$(call func_print_caption,"CREATING IMPACT INSTALLATION RESPONSE FILE")
	@$(CMD_ECHO) "$$IMPACT_INSTALL_RESPONSE_FILE_CONTENT" > $(IMPACT_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "Impact Resp File (FAIL):#$(IMPACT_INSTALL_RESPONSE_FILE)" ; \
		exit 3; }
	@$(CMD_ECHO) "Impact Resp File (OK):  #$(IMPACT_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(IMPACT_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_impact_install_response_file:	check_commands
	@$(call func_print_caption,"REMOVING IMPACT INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(IMPACT_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# INSTALL NETCOOL/IMPACT CORE AS $(IMPACT_USER)
################################################################################
install_impact:		check_whoami \
						check_commands \
						prepare_impact_install_media \
						create_impact_install_response_file \
						create_impact_user \
						create_root_path \
						create_netcool_path

	@$(call func_print_caption,"INSTALLING NETCOOL/IMPACT")
	@if [ -d "$(PATH_INSTALL_IMPACT)" ] ; \
	then \
		$(CMD_ECHO) "Impact Exists? (WARN):  -d $(PATH_INSTALL_IMPACT) # already exists" ; \
	else \
		$(CMD_ECHO) "Impact Exists? (OK):    -d $(PATH_INSTALL_IMPACT) # non-existent" ; \
		$(call func_prepare_installation_manager,$(IMPACT_USER),$(IMPACT_HOME),$(PATH_REPOSITORY_INSTALL)/im.linux.x86) ; \
		$(call func_command_check,$(IMPACT_CMD_IMCL)) ; \
		\
		$(CMD_ECHO) "Impact Install:         #In progress..." ; \
		$(CMD_SU) - $(IMPACT_USER) -c "$(IMPACT_CMD_IMCL) input \
			$(IMPACT_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
			{ $(CMD_ECHO) "Impact Install: (FAIL): $(CMD_SU) - $(IMPACT_USER) -c \"$(IMPACT_CMD_IMCL) input $(IMPACT_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
			exit 4; } ; \
		$(CMD_ECHO) "Impact Install (OK):    $(CMD_SU) - $(IMPACT_USER) -c \"$(IMPACT_CMD_IMCL) input $(IMPACT_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	fi ;

################################################################################
# CONFIRM SHARED LIBRARIES
################################################################################
confirm_shared_libraries:	check_whoami \
							check_commands

	@$(call func_print_caption,"CONFIRMING SHARED LIBRARIES FOR NETCOOL/IMPACT")
	@$(foreach itr_x,$(IMPACT_LDD_CHECKS),\
		$(CMD_PRINTF) "Shared Lib Check:        $(CMD_SU) - $(IMPACT_USER) -c \"$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found\"\n" ; \
		$(CMD_SU) - $(IMPACT_USER) -c "$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found"; $(CMD_TEST) $$? -lt 2; \
	)

	@$(foreach itr_x,$(IMPACT_LDD_CHECKS),\
		$(CMD_SU) - $(IMPACT_USER) -c "$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found 1> /dev/null 2>&1"; $(CMD_TEST) $$? -eq 1 || { \
			$(CMD_ECHO) "Shared Lib Check (FAIL): #Missing shared library dependencies"; \
			exit 5; \
		} ; \
	)

	@$(CMD_ECHO) "Shared Lib Check (OK):   #No missing shared library dependencies"
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:	check_commands
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM -rf /tmp/ciclogs_$(IMPACT_USER)
	@$(CMD_ECHO)

