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
# IBM Tivoli Netcool/OMNIbus 8 Plus Gateway for JDBC (nco-g-jdbc 6_0)
# Michael T. Brown
# July 16, 2019
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
MAKE_PRODUCT			= OMNIbusJDBCGateway

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL			:= /opt/IBM
PATH_INSTALL_NETCOOL	= $(PATH_INSTALL)/netcool
PATH_INSTALL_OMNIBUS	= $(PATH_INSTALL_NETCOOL)/omnibus
PATH_INSTALL_GATEWAY	= $(PATH_INSTALL_OMNIBUS)/gates
PATH_INSTALL_G_JDBC		= $(PATH_INSTALL_GATEWAY)/jdbc

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_GATEWAY_PACKAGE=com.ibm.tivoli.omnibus.integrations.nco-g-jdbc_

################################################################################
# INSTALLATION USERS
################################################################################
OMNIBUS_USER		:= netcool
OMNIBUS_HOME		:= $(PATH_HOME)/$(OMNIBUS_USER)

OMNIBUS_IMSHARED	= $(OMNIBUS_HOME)/$(PATH_IM_SHARED_PATH)
OMNIBUS_CMD_IMCL	:= $(OMNIBUS_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)

OMNIBUS_LDD_CHECKS	:= $(PATH_INSTALL_OMNIBUS)/platform/linux2x86/bin64/nco_g_jdbc

OMNIBUS_PACKAGES	=	$(PACKAGES_COMMON)

################################################################################
# INSTALLATION MEDIA, DESCRIPTIONS, FILES, AND CHECKSUMS
################################################################################
MEDIA_ALL_DESC	=	\t$(MEDIA_STEP1_D)\n

MEDIA_ALL_FILES	=	$(MEDIA_STEP1_F)

MEDIA_STEP1_D	:= Netcool/OMNIbus 8 Plus Gateway for JDBC (nco-g-jdbc 6_0)\n\t\t Multi-Platform English (CN4FUEN)

MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/NCOMNI_GTW_JDBC.zip

MEDIA_STEP1_B	:= 9cbe8c59978d3f7900749f5363cddd37aaf36fbec6943ca6db034bf895e111560aa7ec92efa6c9571f5dc7554258e3225a17f9012861fa67d41b3e3629bf32b1

################################################################################
# DETERMINE THE NETCOOL/OMNIBUS PROFILE ID
################################################################################
GATEWAY_PROFILE_ID	:= $(strip $(shell $(CMD_SU) - $(OMNIBUS_USER) -c "$(OMNIBUS_CMD_IMCL) listInstallationDirectories -long | $(CMD_GREP) ^\"$(PATH_INSTALL_NETCOOL) :\" | $(CMD_CUT) -d: -f2" 2> /dev/null))

################################################################################
# GATEWAY RESPONSE FILE TEMPLATE (INSTALL)
################################################################################
GATEWAY_INSTALL_RESPONSE_FILE=$(PATH_TMP)/omnibus_g_jdbc_install_response.xml
define GATEWAY_INSTALL_RESPONSE_FILE_CONTENT
<?xml version='1.0' encoding='UTF-8'?>
<agent-input>
  <variables>
    <variable name='sharedLocation' value='$(OMNIBUS_IMSHARED)'/>
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
export GATEWAY_INSTALL_RESPONSE_FILE_CONTENT

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

preinstall:			check_im_profile_id

theinstall:			install_omnibus_g_jdbc \
					confirm_shared_libraries

postinstall:		clean \
					clean_tmp

preuninstallchecks:	check_commands \
					check_media_exists \
					check_media_checksums

preuninstall:

theuninstall:		uninstall_omnibus_g_jdbc

postuninstall:		clean

clean:				remove_gateway_install_response_file

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
	@$(call func_install_packages,$(OMNIBUS_PACKAGES))
	@$(CMD_ECHO)

################################################################################
# CONFIRM INSTALLATION MANAGER PROFILE ID CAN BE FOUND
################################################################################
check_im_profile_id:	check_whoami \
						check_commands
	@$(call func_print_caption,"CHECKING INSTALLATION MEDIA PROFILE ID FOR OMNIBUS CORE CAN BE FOUND")
	@$(call func_command_check,$(OMNIBUS_CMD_IMCL))
	@if [ "$(GATEWAY_PROFILE_ID)" = "" ] ; \
        then \
		$(CMD_ECHO) "Profile Found? (FAIL):   $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) listInstallationDirectories -long | $(CMD_GREP) ^\\\"$(PATH_INSTALL_NETCOOL) :\\\" | $(CMD_CUT) -d: -f2\" # not found" ; \
		exit 1; \
	else \
		$(CMD_ECHO) "Profile Found? (OK):     $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) listInstallationDirectories -long | $(CMD_GREP) ^\\\"$(PATH_INSTALL_NETCOOL) :\\\" | $(CMD_CUT) -d: -f2\" # found" ; \
	fi
	@$(CMD_ECHO) "Profile Found (OK):      #$(GATEWAY_PROFILE_ID)"

################################################################################
# CONFIRM USERS
################################################################################
confirm_omnibus_user:	check_whoami \
						check_commands
	@$(call func_print_caption,"CONFIRMING NETCOOL/OMNIBUS USER")
	@$(call func_user_must_exist,$(OMNIBUS_USER))
	@$(CMD_ECHO)

################################################################################
# CONFIRM GATEWAY DIRECTORY
################################################################################
confirm_gateway_dir:	check_whoami \
						check_commands \
						confirm_omnibus_user
	@$(call func_print_caption,"CONFIRMING NETCOOL/OMNIBUS GATEWAY DIRECTORY")
	@$(call func_dir_must_exist,$(OMNIBUS_USER),$(PATH_INSTALL_GATEWAY))
	@$(CMD_ECHO)

################################################################################
# CREATE NETCOOL/OMNIBUS GATEWAY RESPONSE FILE (INSTALLATION)
################################################################################
create_gateway_install_response_file:	check_whoami \
										check_commands

	@$(call func_print_caption,"CREATING NETCOOL/OMNIBUS GATEWAY INSTALLATION RESPONSE FILE")
	@$(CMD_ECHO) "$$GATEWAY_INSTALL_RESPONSE_FILE_CONTENT" > $(GATEWAY_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "Gateway Resp File (FAIL):#$(GATEWAY_INSTALL_RESPONSE_FILE)" ; \
		exit 2; }
	@$(CMD_ECHO) "Gateway Resp File (OK):  #$(GATEWAY_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(GATEWAY_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_gateway_install_response_file:	check_whoami \
										check_commands
	@$(call func_print_caption,"REMOVING NETCOOL/OMNIBUS GATEWAY INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(GATEWAY_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# INSTALL NETCOOL/OMNIBUS JDBC GATEWAY AS $(OMNIBUS_USER)
################################################################################
install_omnibus_g_jdbc:	check_whoami \
						check_commands \
						confirm_omnibus_user \
						confirm_gateway_dir \
						create_gateway_install_response_file

	@$(call func_print_caption,"INSTALLING NETCOOL/OMNIBUS JDBC GATEWAY")
	@if [ -d "$(PATH_INSTALL_G_JDBC)" ] ; \
	then \
		$(CMD_ECHO) "Gateway Exists? (WARN):  -d $(PATH_INSTALL_G_JDBC) # already exists" ; \
	else \
		$(CMD_ECHO) "Gateway Exists? (OK):    -d $(PATH_INSTALL_G_JDBC) # non-existent" ; \
		$(call func_command_check,$(OMNIBUS_CMD_IMCL)) ; \
		\
		$(CMD_ECHO) "Gateway Install:         #In progress..." ; \
		$(CMD_SU) - $(OMNIBUS_USER) -c "$(OMNIBUS_CMD_IMCL) input \
			$(GATEWAY_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
			{ $(CMD_ECHO) "Gateway Install: (FAIL): $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) input $(GATEWAY_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
			exit 3; } ; \
		$(CMD_ECHO) "Gateway Install (OK):    $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) input $(GATEWAY_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CONFIRM SHARED LIBRARIES
################################################################################
confirm_shared_libraries:	check_whoami \
							check_commands

	@$(call func_print_caption,"CONFIRMING SHARED LIBRARIES FOR NETCOOL/OMNIBUS JDBC GATEWAY")
	@$(foreach itr_x,$(OMNIBUS_LDD_CHECKS),\
		$(CMD_PRINTF) "Shared Lib Check:        $(CMD_SU) - $(OMNIBUS_USER) -c \"$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found\"\n" ; \
		$(CMD_SU) - $(OMNIBUS_USER) -c "$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found"; $(CMD_TEST) $$? -lt 2; \
	)

	@$(foreach itr_x,$(OMNIBUS_LDD_CHECKS),\
		$(CMD_SU) - $(OMNIBUS_USER) -c "$(CMD_LDD) $(itr_x) | $(CMD_GREP) not[[:space:]]found 1> /dev/null 2>&1"; $(CMD_TEST) $$? -eq 1 || { \
			$(CMD_ECHO) "Shared Lib Check (FAIL): #Missing shared library dependencies"; \
			exit 4; \
		} ; \
	)

	@$(CMD_ECHO) "Shared Lib Check (OK):   #No missing shared library dependencies"
	@$(CMD_ECHO)

################################################################################
# UNINSTALL NETCOOL/OMNIBUS JDBC GATEWAY
################################################################################
uninstall_omnibus_g_jdbc:	check_whoami \
							check_commands

	@$(call func_print_caption,"UNINSTALLING NETCOOL/OMNIBUS JDBC GATEWAY")
	@if [ -d "$(PATH_INSTALL_G_JDBC)" ] ; \
	then \
		$(CMD_ECHO) "Gateway Exists? (OK):    -d $(PATH_INSTALL_G_JDBC) # exists" ; \
		$(call func_uninstall_im_package,$(OMNIBUS_CMD_IMCL),$(OMNIBUS_USER),$(PATH_REPOSITORY_GATEWAY_PACKAGE),JDBC Gateway) ; \
	else \
		$(CMD_ECHO) "Gateway Exists? (OK):    -d $(PATH_INSTALL_G_JDBC) # non-existent" ; \
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

