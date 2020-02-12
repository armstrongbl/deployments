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
# IBM Installation Manager Utilities 1.0
# Michael T. Brown
# July 3, 2019
################################################################################
MAKE_FILE	:= $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
MAKE_DIR	:= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
################################################################################
# MAKE_FILE NAME, MUST BE BEFORE ANY OTHER MAKEFILE INCLUDES
################################################################################

include ${MAKE_DIR}../include/includes

################################################################################
# INSTALLATION MANAGER UTILITIES VARIABLES
################################################################################
MAKE_PRODUCT = InstallationManager

PATH_HOME					:= /home
PATH_REPOSITORY_IM_PACKAGE	=  com.ibm.cic.agent_

IM_USER						:= root
IM_USER_HOME				:= $(PATH_HOME)/$(IM_USER)
IM_USER_CMD_IMCL			:= $(IM_USER_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)

################################################################################
# MAIN BUILD TARGETS
################################################################################
default:	help

all:		help \
			version \
			directories \
			packages

################################################################################
# HELP INFORMATION
################################################################################
help:
	@$(CMD_PRINTF) "\n\
This makefile provides targets for inquiring (or uninstalling) a user's IBM\n\
Installation Manager.\n\
\n\
The following targets are available:\n\
\tall          shows IBM Installation Manager version & installed packages\n\
\tversion      shows IBM Installation Manager version\n\
\tdirectories  shows IBM Installation Manager installation directories\n\
\tpackages     shows IBM Installation Manager installed packages\n\
\tuninstall    UNINSTALLS IBM Installation Manager (USE WITH CARE)\n\
\n\
Please run this makefile as root and specify the user's Installation\n\
Manager to inquire or uninstall via IM_USER (i.e. these utilities access\n\
IBM Installation Manager under the user's home directory).  For example:\n\
\n\
\tsudo make -f $(MAKE_FILE) IM_USER=netcool all\n\
\n"


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
# INSTALLATION MANAGER UTILITY TARGETS
################################################################################
version:			check_whoami \
					check_commands

	@$(call func_print_caption,"SHOW INSTALLATION MANAGER VERSION (INSTALLED)")
	@$(call func_command_check,$(IM_USER_CMD_IMCL))
	@$(CMD_SU) - $(IM_USER) -c "$(IM_USER_CMD_IMCL) version"
	@$(CMD_ECHO)

directories:		check_whoami \
					check_commands

	@$(call func_print_caption,"SHOW INSTALLATION MANAGER DIRECTORIES (INSTALLED)")
	@$(call func_command_check,$(IM_USER_CMD_IMCL))
	@$(CMD_SU) - $(IM_USER) -c "$(IM_USER_CMD_IMCL) listInstallationDirectories -verbose"
	@$(CMD_ECHO)

packages:			check_whoami \
					check_commands

	@$(call func_print_caption,"SHOW INSTALLATION MANAGER PACKAGES (INSTALLED)")
	@$(call func_command_check,$(IM_USER_CMD_IMCL))
	@$(CMD_SU) - $(IM_USER) -c "$(IM_USER_CMD_IMCL) listInstalledPackages"
	@$(CMD_ECHO)

################################################################################
# UNINSTALL INSTALLATION MANAGER
################################################################################
uninstall:			check_whoami \
					check_commands

	@$(call func_print_caption,"UNINSTALL INSTALLATION MANAGER")
	@$(call func_uninstall_im_package,$(IM_USER_CMD_IMCL),$(IM_USER),$(PATH_REPOSITORY_IM_PACKAGE),Installation Manager)
	@$(CMD_ECHO)
