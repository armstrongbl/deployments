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
# IBM Tivoli Netcool Configuration Manager
# Viasat NMS
#
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
MAKE_PRODUCT			= NCM

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTAL		:= /opt/IBM
PATH_INSTALL_NCM	= $(PATH_INSTALL)/netcool

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_INSTALL := $(PATH_MAKEFILE_REPOSITORY)/ncm_core_6_4_2_install

################################################################################
# INSTALLATION USERS
################################################################################
NCM_USER		:= icosuser
NCM_GROUP		:= icosgrp
NCM_HOME		:= $(PATH_HOME)/$(NCM_USER)

NCM_IMSHARED	= $(NCM_HOME)/$(PATH_IM_SHARED_PATH)
NCM_CMD_IMCL	:= $(NCM_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)

################################################################################
# INSTALLATION MEDIA, DESCRIPTIONS, FILES, AND CHECKSUMS
################################################################################
MEDIA_ALL_DESC	=	\t$(MEDIA_STEP1_D)\n

MEDIA_ALL_FILES	=	$(MEDIA_STEP1_F)

MEDIA_STEP1_D	:= Netcool Configuration Mangaer 6.4.2  \n\t\t 

MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/ITNCM_Base_Linux.tar

MEDIA_STEP1_B	:= 089e399e2be5f5c0f744e2e9b3722d71ffaac2f059e6440dc146397cc16af256793ca08eeae21392feb7d67d1ea4d44c556ae6f32f3351e4f55c97ad0d2681d4

################################################################################
# RESPONSE FILE TEMPLATE (INSTALL)
################################################################################
NCM_INSTALL_RESPONSE_FILE=$(PATH_TMP)/ncm_install_response.xml
define NCM_INSTALL_RESPONSE_FILE_CONTENT

<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(NCM_IMSHARED)'/>
  </variables>
  <server>
    <repository location='$(MEDIA_STEP1_F)'/>
  </server>
  <profile id='$(GATEWAY_PROFILE_ID)' installLocation='$(PATH_INSTALL_NETCOOL)'>
    <data key='cic.selector.arch' value='x86_64'/>
    <data key='user.migratedata,com.ibm.tivoli.omnibus.core' value='false'/>
  </profile>
  <install>
    <!-- Netcool/OMNIbus Gateway nco-g-jdbc 1.6.0.0 -->
    <offering profile='$(GATEWAY_PROFILE_ID)' id='com.ibm.tivoli.omnibus.integrations.nco-g-jdbc' version='1.6.0.4' features='nco-g-jdbc'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
</agent-input>

endef
export NCM_INSTALL_RESPONSE_FILE_CONTENT


################################################################################
# PREPARE NETCOOL/OMNIBUS CORE MEDIA (INSTALLATION)
################################################################################
prepare_ncm_install_media:  check_whoami \
		check_commands \
		check_media_exists \
		check_media_checksums \
		create_ncm_user

		@$(call func_print_caption,"PREPARING NETCOOL CONFIGURATION MEDIA (INSTALLATION)")
		@$(call func_tar_xf_to_new_dir,$(NCM_USER),$(NCM_GROUP),755,$(MEDIA_STEP1_F),$(PATH_REPOSITORY_INSTALL))
		@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE GROUPS
################################################################################
create_ncm_group:   check_whoami \
		check_commands

		@$(call func_print_caption,"CONFIRMING/CREATING NCM GROUP")
		@$(call func_create_group,$(OMNIBUS_GROUP),$(MAKE_PRODUCT))
		@$(CMD_ECHO)


################################################################################
# CREATE NCM USER
################################################################################
create_ncm_user:    check_whoami \
		check_commands \
		create_ncm_group

		@$(call func_print_caption,"CONFIRMING/CREATING NCM USER")
		@$(call func_create_user,$(NC_USER),$(MAKE_PRODUCT),$(NCM_GROUP),$(NCM_HOME),$(NCM_SHELL),$(NCM_PASSWD))


################################################################################
# MAIN BUILD TARGETS
################################################################################
default:			help

all:				help \
					prerequisites \
					install

prerequisites:		install_packages

install:			preinstallchecks \
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


theinstall:			install_ncm

postinstall:		clean \
					clean_tmp

preuninstallchecks:	check_commands \
					check_media_exists \
					check_media_checksums

preuninstall:

theuninstall:		uninstall_omnibus_g_jdbc

postuninstall:		clean

clean:				remove_ncm_install_response_file

scrub:				uninstall \
					clean

# WARNING scrub_users WILL REMOVE USERS AND HOME DIRECTORIES INCLUDING ALL
# CONTENT AND ANY INSTALL MANAGERS IN SAME.  IF THE SAME USERNAME IS USED
# FOR MORE THAN ONE PRODUCT INSTALL, THEN THIS SHOULD BE DONE WITH EXTREME
# CAUTION
scrub_users:		clean

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
	@$(CMD_ECHO)

################################################################################
# INSTALL PREREQUISITE PACKAGES
################################################################################
install_packages:		check_whoami
	@$(call func_print_caption,"INSTALLING PREREQUISITE PACKAGES")
	@$(call func_install_packages,$(NCM_PACKAGES))
	@$(CMD_ECHO)

################################################################################
# CONFIRM USERS
################################################################################
confirm_omnibus_user:	check_whoami \
						check_commands
	@$(call func_print_caption,"CONFIRMING NETCOOL/NCM USER")
	@$(call func_user_must_exist,$(NCM_USER))
	@$(CMD_ECHO)

################################################################################
# CONFIRM GATEWAY DIRECTORY
################################################################################
confirm_ncm_dir:	check_whoami \
						check_commands \
						confirm_omnibus_user
	@$(call func_print_caption,"CONFIRMING NETCOOL CONFIGURatION DIRECTORY")
	@$(call func_dir_must_exist,$(NCM_USER),$(PATH_INSTALL_NCM))
	@$(CMD_ECHO)

################################################################################
# CREATE NCM RESPONSE FILE (INSTALLATION)
################################################################################
create_ncm_install_response_file:	check_whoami \
					check_commands

	@$(call func_print_caption,"CREATING NCM INSTALLATION RESPONSE FILE")
	@$(CMD_ECHO) "$$NCM_INSTALL_RESPONSE_FILE_CONTENT" > $(NCM_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "NCM Resp File (FAIL):#$(GATEWAY_INSTALL_RESPONSE_FILE)" ; \
		exit 2; }
	@$(CMD_ECHO) "NCM Resp File (OK):  #$(NCM_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(NCM_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_ncm_install_response_file:	check_whoami \
					check_commands
	@$(call func_print_caption,"REMOVING NCM INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(NCM_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# INSTALL NETCOOL/NCM JDBC GATEWAY AS $(NCM_USER)
################################################################################
install_ncm:	check_whoami \
						check_commands \
						confirm_ncm_user \
						confirm_ncm_dir \
						create_ncm_install_response_file

	@$(call func_print_caption,"INSTALLING NETCOOL CONFIGURATION MANAGER")
	@if [ -d "$(PATH_INSTALL_G_JDBC)" ] ; \
	then \
		$(CMD_ECHO) "NCM Exists? (WARN):  -d $(PATH_INSTALL_NCM) # already exists" ; \
	else \
		$(CMD_ECHO) "NCM Exists? (OK):    -d $(PATH_INSTALL_NCM) # non-existent" ; \
		$(call func_command_check,$(NCM_CMD_IMCL)) ; \
		\
		$(CMD_ECHO) "NCM Install:         #In progress..." ; \
		$(CMD_SU) - $(NCM_USER) -c "$(NCM_CMD_IMCL) input \
			$(NCM_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
			{ $(CMD_ECHO) "NCM Install: (FAIL): $(CMD_SU) - $(NCM_USER) -c \"$(NCM_CMD_IMCL) input $(GATEWAY_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
			exit 3; } ; \
		$(CMD_ECHO) "NCM Install (OK):    $(CMD_SU) - $(NCM_USER) -c \"$(NCM_CMD_IMCL) input $(GATEWAY_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# UNINSTALL NCM
################################################################################
uninstall_ncm:	check_whoami \
							check_commands

	@$(call func_print_caption,"UNINSTALLING NETCOOL CONFIGURATION MANAGER")
	@if [ -d "$(PATH_INSTALL_NCM)" ] ; \
	then \
		$(CMD_ECHO) "NCM Exists? (OK):    -d $(PATH_INSTALL_G_JDBC) # exists" ; \
		$(call func_uninstall_im_package,$(NCM_CMD_IMCL),$(NCM_USER),$(PATH_REPOSITORY_GATEWAY_PACKAGE),JDBC Gateway) ; \
	else \
		$(CMD_ECHO) "NCM Exists? (OK):    -d $(PATH_INSTALL_G_JDBC) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:	check_commands
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM) -rf /tmp/ciclogs_$(NCM_USER)
	@$(CMD_ECHO)

