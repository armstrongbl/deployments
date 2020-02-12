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
# IBM Tivoli Netcool/OMNIbus 8 Plus JDBC Gateway Configuration (DB2 Audit) 1.0
# Michael T. Brown
# July 17, 2019
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
MAKE_PRODUCT		= OMNIbusJDBCGatewayInAuditMode

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL		:= /opt/IBM
PATH_INSTALL_NETCOOL	= $(PATH_INSTALL)/netcool
PATH_INSTALL_OMNIBUS	= $(PATH_INSTALL_NETCOOL)/omnibus
PATH_INSTALL_GATEWAY	= $(PATH_INSTALL_OMNIBUS)/gates
PATH_INSTALL_G_AUDIT	= $(PATH_INSTALL_GATEWAY)/audit

################################################################################
# REPOSITORY PATHS
################################################################################
PATH_REPOSITORY_SCRIPTS_PACKAGE=com.ibm.tivoli.omnibus.integrations.nco-g-jdbc-audit-scripts_

################################################################################
# INSTALLATION USERS
################################################################################
OMNIBUS_USER		:= netcool
OMNIBUS_GROUP		:= ncoadmin
OMNIBUS_PASSWD		:= $(OMNIBUS_USER)
OMNIBUS_HOME		:= $(PATH_HOME)/$(OMNIBUS_USER)

OMNIBUS_IMSHARED	= $(OMNIBUS_HOME)/$(PATH_IM_SHARED_PATH)
OMNIBUS_CMD_IMCL	:= $(OMNIBUS_HOME)/$(PATH_IM_IMCL_RELATIVE_PATH)

OMNIBUS_PACKAGES	=	$(PACKAGES_COMMON)

DB2_USER			:= db2inst
DB2_PASSWD			:= $(DB2_USER)
DB2_HOME			:= $(PATH_HOME)/$(DB2_USER)
DB2_HOST			= $(HOST_FQDN)
DB2_PORT			:= 50000

################################################################################
# OMNIBUS CONFIGURATION
################################################################################
NETCOOL_SERVICE=nco
NETCOOL_PA_NAME=NCO_PA

OMNIBUS_AUDIT_NAME			:= G_AUDIT
OMNIBUS_AUDIT_HOST			= $(HOST_FQDN)
OMNIBUS_AUDIT_PORT			:= 4500
OMNIBUS_AUDIT_DAYS			:= 365
OMNIBUS_AUDIT_PURGE_HOUR	:= 3
OMNIBUS_AUDIT_PURGE_MINUTE	:= 3

OMNIBUS_AUDIT_PA_PROCESS	:= AuditGateway
OMNIBUS_AUDIT_PA_PROCESS_DEPEND	:= MasterObjectServer

OMNIBUS_OS_PASSWD		:=
OMNIBUS_OS_SERVER		:= NCOMS
OMNIBUS_OS_USER			:= root

NETCOOL_BIN_IGEN		= $(PATH_INSTALL_NETCOOL)/bin/nco_igen
NETCOOL_ETC_OMNIDAT		= $(PATH_INSTALL_NETCOOL)/etc/omni.dat

OMNIBUS_BIN_PASTATUS	= $(PATH_INSTALL_OMNIBUS)/bin/nco_pa_status
OMNIBUS_BIN_PASTOP		= $(PATH_INSTALL_OMNIBUS)/bin/nco_pa_stop

################################################################################
# GATEWAY CONFIGURATION (DEFAULT FILES)
################################################################################
JDBC_GATEWAY_CMD_FILE		= $(PATH_INSTALL_GATEWAY)/jdbc/$(OMNIBUS_AUDIT_NAME).startup.cmd
JDBC_GATEWAY_CMD_TEMPLATE	= $(PATH_INSTALL_GATEWAY)/jdbc/default/jdbc.startup.cmd
JDBC_GATEWAY_CMD_CHECKSUM	= `$(CMD_SHA512SUM) $(JDBC_GATEWAY_CMD_TEMPLATE) | $(CMD_CUT) -d" " -f1`

JDBC_GATEWAY_DEF_FILE		= $(PATH_INSTALL_GATEWAY)/jdbc/$(OMNIBUS_AUDIT_NAME).rdrwtr.tblrep.def
JDBC_GATEWAY_DEF_TEMPLATE	= $(PATH_INSTALL_GATEWAY)/jdbc/default/jdbc.rdrwtr.tblrep.def
JDBC_GATEWAY_DEF_CHECKSUM	= `$(CMD_SHA512SUM) $(JDBC_GATEWAY_DEF_TEMPLATE) | $(CMD_CUT) -d" " -f1`

JDBC_GATEWAY_MAP_FILE		= $(PATH_INSTALL_GATEWAY)/jdbc/$(OMNIBUS_AUDIT_NAME).map
JDBC_GATEWAY_MAP_TEMPLATE	= $(PATH_INSTALL_GATEWAY)/jdbc/default/audit.jdbc.map
JDBC_GATEWAY_MAP_CHECKSUM	= `$(CMD_SHA512SUM) $(JDBC_GATEWAY_MAP_TEMPLATE) | $(CMD_CUT) -d" " -f1`

################################################################################
# SERVER INFORMATION
################################################################################
HOST_FQDN	:= $(shell $(CMD_HOSTNAME) -f)
TIMESTAMP	:= $(shell $(CMD_DATE) +'%Y%m%d_%H%M%S')

################################################################################
# INSTALLATION MEDIA, DESCRIPTIONS, FILES, AND CHECKSUMS
################################################################################
MEDIA_ALL_DESC	=	\t$(MEDIA_STEP1_D)\n

MEDIA_ALL_FILES	=	$(MEDIA_STEP1_F)

MEDIA_STEP1_D	:= Netcool/OMNIbus 8 Plus JDBC Gateway Configuration Scripts (Audit Mode:\n\t\tnco-g-jdbc-audit-scripts 1_0) Multiplatform English (CN1J8EN)

MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/im-nco-g-jdbc-audit-scripts-1_0.zip

MEDIA_STEP1_B	:= 40fc0c04f055829a0c3d86dd0b895cc1e682c4afe1d997f756e258fca3812ccc3fa111be589ed988a68852712064aa42e03541c6a206b60a6f8ef95fc89cfe8c

################################################################################
# DETERMINE THE NETCOOL/OMNIBUS PROFILE ID
################################################################################
GATEWAY_PROFILE_ID	:= $(strip $(shell $(CMD_SU) - $(OMNIBUS_USER) -c "$(OMNIBUS_CMD_IMCL) listInstallationDirectories -long | $(CMD_GREP) ^\"$(PATH_INSTALL_NETCOOL) :\" | $(CMD_CUT) -d: -f2" 2> /dev/null))

################################################################################
# SCRIPTS RESPONSE FILE TEMPLATE (INSTALL)
################################################################################
SCRIPTS_INSTALL_RESPONSE_FILE=$(PATH_TMP)/omnibus_g_jdbc_audit_install_response.xml
define SCRIPTS_INSTALL_RESPONSE_FILE_CONTENT
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
    <!-- Netcool/OMNIbus Gateway nco-g-jdbc-audit-scripts 1.1.0.0 -->
    <offering profile='$(GATEWAY_PROFILE_ID)' id='com.ibm.tivoli.omnibus.integrations.nco-g-jdbc-audit-scripts' version='1.1.0.2' features='nco-g-jdbc-audit-scripts'/>
  </install>
  <preference name='com.ibm.cic.common.core.preferences.eclipseCache' value='$${sharedLocation}'/>
  <preference name='offering.service.repositories.areUsed' value='false'/>
</agent-input>
endef
export SCRIPTS_INSTALL_RESPONSE_FILE_CONTENT

################################################################################
# OMNI.DAT ENTRY TEMPLATE
################################################################################
OMNI_DAT_ENTRY_CONTENT_FIRSTLINE=[$(OMNIBUS_AUDIT_NAME)]
define OMNI_DAT_ENTRY_CONTENT
$(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE)
{
	Primary: $(OMNIBUS_AUDIT_HOST) $(OMNIBUS_AUDIT_PORT)
}

endef
export OMNI_DAT_ENTRY_CONTENT

OMNI_DAT_ENTRY_CONTENT_CHECK=`$(CMD_GREP) -F "$(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE)" $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^\#`
OMNI_DAT_ENTRY_CONTENT_CHECKSUM:=`$(CMD_ECHO) "$$OMNI_DAT_ENTRY_CONTENT" | $(CMD_SHA512SUM)`

################################################################################
# JDBC GATEWAY PROPERTIES FILE TEMPLATE
################################################################################
JDBC_GATEWAY_PROPS_FILE_TEMPLATE=$(PATH_INSTALL_GATEWAY)/jdbc/default/audit.G_JDBC.props
JDBC_GATEWAY_PROPS_FILE=$(PATH_INSTALL_OMNIBUS)/etc/$(OMNIBUS_AUDIT_NAME).props
define JDBC_GATEWAY_PROPS_CONTENT

#
# Generic gateway properties
#
MessageLog: '$$OMNIHOME/log/$(OMNIBUS_AUDIT_NAME).log'
Name: '$(OMNIBUS_AUDIT_NAME)'
PropsFile: '$$OMNIHOME/etc/$(OMNIBUS_AUDIT_NAME).props'

#
# Audit mode properties
#
Gate.Jdbc.Mode: 'AUDIT'

#
# Table properties
#
Gate.Jdbc.StatusTableName: 'status'
Gate.Jdbc.JournalTableName: 'journal'
Gate.Jdbc.DetailsTableName: 'details'
# Uncomment the property below if you have Serial as NOT NULL in the target audit schema
# This will ensure Serial is specified for the delete audit row (it is not by default)
# Gate.Jdbc.SerialField: 'SERIAL' # STRING (Target Serial field for alerts.status)

#
# JDBC Connection properties
#
Gate.Jdbc.Driver: 'com.ibm.db2.jcc.DB2Driver'
Gate.Jdbc.Url: 'jdbc:db2://$(DB2_HOST):$(DB2_PORT)/ALERTS'
Gate.Jdbc.Username: '$(DB2_USER)'
Gate.Jdbc.Password: '$(DB2_PASSWD)'
Gate.Jdbc.ReconnectTimeout: 30
Gate.Jdbc.InitializationString: ''

#
# Gateway framework properties
#
Gate.MapFile: '$$OMNIHOME/gates/jdbc/$(OMNIBUS_AUDIT_NAME).map'
Gate.RdrWtr.TblReplicateDefFile: '$$OMNIHOME/gates/jdbc/$(OMNIBUS_AUDIT_NAME).rdrwtr.tblrep.def'
Gate.StartupCmdFile: '$$OMNIHOME/gates/jdbc/$(OMNIBUS_AUDIT_NAME).startup.cmd'

#
# ObjectServer Connection properties
#
Gate.RdrWtr.Username: '$(OMNIBUS_OS_USER)'
Gate.RdrWtr.Password: '$(OMNIBUS_OS_PASSWD)'
Gate.RdrWtr.Server: '$(OMNIBUS_OS_SERVER)'
endef
export JDBC_GATEWAY_PROPS_CONTENT

################################################################################
# PROCESS AGENT/PROCESS ENTRY TEMPLATE
################################################################################
NCO_PA_CONF_FILE=$(PATH_INSTALL_OMNIBUS)/etc/nco_pa.conf
NCO_PA_CONF_FILE_NEW=$(PATH_INSTALL_OMNIBUS)/etc/nco_pa.conf.$(TIMESTAMP).new
NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE=nco_process '$(OMNIBUS_AUDIT_PA_PROCESS)'
define NCO_PA_CONF_PROCESS_ENTRY_CONTENT
$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE)
{
	Command '$$OMNIHOME/bin/nco_g_jdbc -propsfile $$OMNIHOME/etc/$(OMNIBUS_AUDIT_NAME).props' run as '$(OMNIBUS_USER)'
	Host		=	'$(OMNIBUS_AUDIT_HOST)'
	Managed		=	True
	RestartMsg	=	'$${NAME} running as $${EUID} has been restored on $${HOST}.'
	AlertMsg	=	'$${NAME} running as $${EUID} has died on $${HOST}.'
	RetryCount	=	0
	ProcessType	=	PaNOT_PA_AWARE
}

endef
export NCO_PA_CONF_PROCESS_ENTRY_CONTENT

NCO_PA_CONF_PROCESS_ENTRY_CONTENT_CHECK=`$(CMD_GREP) -F "$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE)" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^\#`
NCO_PA_CONF_PROCESS_ENTRY_CONTENT_CHECKSUM:=`$(CMD_ECHO) "$$NCO_PA_CONF_PROCESS_ENTRY_CONTENT" | $(CMD_SHA512SUM)`

NCO_PA_CONF_PROCESS_ENTRY_INSERT_LINE1=\#
NCO_PA_CONF_PROCESS_ENTRY_INSERT_LINE2=\# List of Services
NCO_PA_CONF_PROCESS_ENTRY_INSERT_CHECK2=`$(CMD_GREP) ^"$(NCO_PA_CONF_PROCESS_ENTRY_INSERT_LINE2)" $(NCO_PA_CONF_FILE)`

NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE=\tprocess '$(OMNIBUS_AUDIT_PA_PROCESS)' '$(OMNIBUS_AUDIT_PA_PROCESS_DEPEND)'
define NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT
$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE)
endef
export NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT

NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_CHECK=`$(CMD_GREP) -P "$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE)" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^\#`
NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_CHECKSUM:=`$(CMD_ECHO) -e "$$NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT" | $(CMD_SHA512SUM)`

NCO_PA_CONF_DEPENDENCY_ENTRY_INSERT_LINE=\tprocess '$(OMNIBUS_AUDIT_PA_PROCESS_DEPEND)' NONE
NCO_PA_CONF_DEPENDENCY_ENTRY_INSERT_CHECK=`$(CMD_GREP) -P ^"$(NCO_PA_CONF_DEPENDENCY_ENTRY_INSERT_LINE)" $(NCO_PA_CONF_FILE)`

################################################################################
# PURGE AUDIT/ALERT DATABASE SCRIPT TEMPLATE
################################################################################
JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT=$(PATH_INSTALL_G_AUDIT)/db2/db2_purge.sql
define JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT_CONTENT
----------------------------------------------------------------------
-- db2_purge.sql

-- This script will purge old rows from the netcool audit database:  
-- STATUS, JOURNAL, and DETAILS tables.

-- To run this script, you must do the following:
--   (1) Put this script in directory of your choice.
--   (2) At the DB2 command window prompt, run this script.
--       EXAMPLE:    db2 -td@ -vf db2_purge.sql
----------------------------------------------------------------------

CONNECT TO ALERTS @

DELETE FROM STATUS WHERE (SERVERNAME, SERVERSERIAL)
  IN (SELECT SERVERNAME, SERVERSERIAL FROM STATUS
    WHERE ACTIONCODE = 'D' AND TRUNC(ACTIONTIME) <= TRUNC(SYSDATE) - $(OMNIBUS_AUDIT_DAYS) DAYS) @

DELETE FROM JOURNAL WHERE (SERVERNAME, SERVERSERIAL)
  NOT IN (SELECT SERVERNAME, SERVERSERIAL FROM STATUS) @

DELETE FROM DETAILS WHERE (SERVERNAME, SERVERSERIAL)
  NOT IN (SELECT SERVERNAME, SERVERSERIAL from STATUS) @

COMMIT WORK @

TERMINATE @
endef
export JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT_CONTENT
JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT_CHECKSUM:=`$(CMD_ECHO) "$$JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT_CONTENT" | $(CMD_SHA512SUM) | $(CMD_CUT) -d" " -f1`

################################################################################
# PURGE AUDIT/ALERT DATABASE CRONTAB TEMPLATE
################################################################################
JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CHECK=`$(CMD_CRONTAB) -u $(DB2_USER) -l 2> $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDERR) | $(CMD_GREP) $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT)`
JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_NOEXIST=`$(CMD_GREP) "no crontab for $(DB2_USER)" $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDERR)`
JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB=$(PATH_INSTALL_G_AUDIT)/db2/db2_purge.crontab
JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT=$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB).stdout
JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDERR=$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB).stderr
define JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CONTENT
$(OMNIBUS_AUDIT_PURGE_MINUTE) $(OMNIBUS_AUDIT_PURGE_HOUR) * * * $(DB2_HOME)/sqllib/bin/db2 -td@ -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) 1> /dev/null
endef
export JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CONTENT
JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CHECKSUM:=`$(CMD_ECHO) "$$JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CONTENT" | $(CMD_SHA512SUM) | $(CMD_CUT) -d" " -f1`

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
					check_crond

preinstall:			check_im_profile_id

theinstall:			install_gateway \
					create_audit_db \
					configure_audit_db_purge \
					configure_omni_dat \
					configure_gateway \
					configure_pa \
					restart_pa

postinstall:		clean

preuninstallchecks:	check_commands

preuninstall:

theuninstall:		stop_gateway \
					deconfigure_pa \
					deconfigure_gateway \
					deconfigure_omni_dat \
					deconfigure_audit_db_purge \
					drop_audit_db \
					uninstall_gateway

postuninstall:		clean

clean:				remove_scripts_install_response_file \
					clean_tmp

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
install_packages:	check_whoami
	@$(call func_print_caption,"INSTALLING PREREQUISITE PACKAGES")
	@$(call func_install_packages,$(OMNIBUS_PACKAGES))
	@$(CMD_ECHO)

################################################################################
# CONFIRM CROND IS RUNNING
################################################################################
check_crond:		check_whoami \
					check_commands
	@$(call func_print_caption,"CONFIRMING CROND SERVICE IS RUNNING FOR DATABASE PURGING")
	@$(CMD_GREP) " 6" /etc/redhat-release 1> /dev/null; rc=$$? ; \
	if [ $$rc -eq 0 ] ; \
	then \
		$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 6 / Not systemd" ; \
		\
		$(CMD_SERVICE) crond status | $(CMD_GREP) -i "run" 1> /dev/null 2>&1 || { \
			$(CMD_ECHO) "crond Running? (FAIL):   $(CMD_SERVICE) crond status | $(CMD_GREP) -i \"run\" # indicated crond is not running" ; \
			exit 1; } ; \
		$(CMD_ECHO) "crond Running? (OK):     $(CMD_SERVICE) crond status | $(CMD_GREP) -i \"run\" # indicates crond is running" ; \
	else \
		$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 7+ / systemd" ; \
		\
		$(CMD_SYSTEMCTL) status crond | $(CMD_GREP) -i "running" 1> /dev/null 2>&1 || { \
			$(CMD_ECHO) "crond Running? (FAIL):   $(CMD_SYSTEMCTL) status crond | $(CMD_GREP) -i \"running\" # indicated crond is not running" ; \
			exit 2; } ; \
		$(CMD_ECHO) "crond Running? (OK):     $(CMD_SYSTEMCTL) status crond | $(CMD_GREP) -i \"running\" # indicates crond is running" ; \
	fi
	@$(CMD_ECHO)

################################################################################
# CONFIRM INSTALLATION MANAGER PROFILE ID CAN BE FOUND
################################################################################
check_im_profile_id:	check_whoami \
						check_commands \
						confirm_omnibus_user
	@$(call func_print_caption,"CHECKING INSTALLATION MEDIA PROFILE ID FOR OMNIBUS CORE CAN BE FOUND")
	@$(call func_command_check,$(OMNIBUS_CMD_IMCL))
	@if [ "$(GATEWAY_PROFILE_ID)" = "" ] ; \
	then \
		$(CMD_ECHO) "Profile Found? (FAIL):   $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) listInstallationDirectories -long | $(CMD_GREP) ^\\\"$(PATH_INSTALL_NETCOOL) :\\\" | $(CMD_CUT) -d: -f2\" # not found" ; \
		exit 3; \
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

confirm_db2_user:	check_whoami \
					check_commands
	@$(call func_print_caption,"CONFIRMING DB2 USER")
	@$(call func_user_must_exist,$(DB2_USER))
	@$(CMD_ECHO)

################################################################################
# CONFIRM GROUPS
################################################################################
confirm_omnibus_group:	check_whoami \
						check_commands
	@$(call func_print_caption,"CONFIRMING NETCOOL/OMNIBUS GROUP")
	@$(call func_group_must_exist,$(OMNIBUS_GROUP))
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
# CREATE NETCOOL/OMNIBUS AUDIT SCRIPTS RESPONSE FILE (INSTALLATION)
################################################################################
create_scripts_install_response_file:	check_whoami \
										check_commands

	@$(call func_print_caption,"CREATING NETCOOL/OMNIBUS AUDIT SCRIPTS INSTALLATION RESPONSE FILE")
	@$(CMD_ECHO) "$$SCRIPTS_INSTALL_RESPONSE_FILE_CONTENT" > $(SCRIPTS_INSTALL_RESPONSE_FILE) || { $(CMD_ECHO) \
		 "Scripts Resp File (FAIL):#$(SCRIPTS_INSTALL_RESPONSE_FILE)" ; \
		exit 4; }
	@$(CMD_ECHO) "Scripts Resp File (OK):  #$(SCRIPTS_INSTALL_RESPONSE_FILE)"
	@$(call func_chmod,444,$(SCRIPTS_INSTALL_RESPONSE_FILE))
	@$(CMD_ECHO)

remove_scripts_install_response_file:	check_commands
	@$(call func_print_caption,"REMOVING NETCOOL/OMNIBUS INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(SCRIPTS_INSTALL_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# INSTALL NETCOOL/OMNIBUS AUDIT SCRIPTS AS $(OMNIBUS_USER)
################################################################################
install_gateway:	check_whoami \
					check_commands \
					confirm_omnibus_user \
					confirm_gateway_dir \
					create_scripts_install_response_file

	@$(call func_print_caption,"INSTALLING NETCOOL/OMNIBUS AUDIT SCRIPTS")
	@if [ -f "(PATH_INSTALL_G_AUDIT)/db2/db2_status.sql" ] ; \
	then \
		$(CMD_ECHO) "Scripts Exists? (WARN):  -f (PATH_INSTALL_G_AUDIT)/db2/db2_status.sql # already exists" ; \
	else \
		$(CMD_ECHO) "Scripts Exists? (OK):    -f (PATH_INSTALL_G_AUDIT)/db2/db2_status.sql # non-existent" ; \
		$(call func_command_check,$(OMNIBUS_CMD_IMCL)) ; \
		\
		$(CMD_ECHO) "Scripts Install:         #In progress..." ; \
		$(CMD_SU) - $(OMNIBUS_USER) -c "$(OMNIBUS_CMD_IMCL) input \
			$(SCRIPTS_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)" || \
			{ $(CMD_ECHO) "Scripts Install: (FAIL): $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) input $(SCRIPTS_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
			exit 5; } ; \
		$(CMD_ECHO) "Scripts Install (OK):    $(CMD_SU) - $(OMNIBUS_USER) -c \"$(OMNIBUS_CMD_IMCL) input $(SCRIPTS_INSTALL_RESPONSE_FILE) $(OPTIONS_MAKEFILE_IM)\"" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# UNINSTALL NETCOOL/OMNIBUS AUDIT SCRIPTS
################################################################################
uninstall_gateway:	check_whoami \
					check_commands \
					confirm_omnibus_user

	@$(call func_print_caption,"UNINSTALLING NETCOOL/OMNIBUS AUDIT SCRIPTS")
	@if [ -d "$(PATH_INSTALL_G_AUDIT)" ] ; \
	then \
		$(CMD_ECHO) "Scripts Exists? (OK):    -d $(PATH_INSTALL_G_AUDIT) # exists" ; \
		$(call func_uninstall_im_package,$(OMNIBUS_CMD_IMCL),$(OMNIBUS_USER),$(PATH_REPOSITORY_SCRIPTS_PACKAGE),Audit Scripts) ; \
	else \
		$(CMD_ECHO) "Scripts Exists? (OK):    -d $(PATH_INSTALL_G_AUDIT) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# CREATE DB2 AUDIT DATABASE
################################################################################
create_audit_db:	check_whoami \
					check_commands \
					confirm_db2_user
	@$(call func_print_caption,"CREATING OMNIBUS HISTORICAL DB2 DATABASE (ALERTS) IN AUDIT MODE")
	@$(CMD_ECHO) "Status Table:            #In progress..."
	@$(CMD_ECHO)
	@$(CMD_SU) - $(DB2_USER) -c "db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_status.sql" || \
		{ $(CMD_ECHO) "Status Table (FAIL):     $(CMD_SU) - $(DB2_USER) -c \"db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_status.sql\"" ; \
		exit 6; }
	@$(CMD_ECHO) "Status Table (OK):       $(CMD_SU) - $(DB2_USER) -c \"db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_status.sql\""
	@$(CMD_ECHO)
	
	@$(CMD_ECHO) "Details Table:           #In progress..."
	@$(CMD_ECHO)
	@$(CMD_SU) - $(DB2_USER) -c "db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_details.sql" || \
		{ $(CMD_ECHO) "Details Table (FAIL):    $(CMD_SU) - $(DB2_USER) -c \"db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_details.sql\"" ; \
		exit 7; }
	@$(CMD_ECHO) "Details Table (OK):      $(CMD_SU) - $(DB2_USER) -c \"db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_details.sql\""
	@$(CMD_ECHO)

	@$(CMD_ECHO) "Journal Table:           #In progress..."
	@$(CMD_ECHO)
	@$(CMD_SU) - $(DB2_USER) -c "db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_journal.sql" || \
		{ $(CMD_ECHO) "Journal Table (FAIL):    $(CMD_SU) - $(DB2_USER) -c \"db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_journal.sql\"" ; \
		exit 8; }
	@$(CMD_ECHO) "Journal Table (OK):      $(CMD_SU) - $(DB2_USER) -c \"db2 -td@ -vf $(PATH_INSTALL_G_AUDIT)/db2/db2_journal.sql\""
	@$(CMD_ECHO)

################################################################################
# DROP DB2 AUDIT DATABASE
################################################################################
drop_audit_db:		check_whoami \
					check_commands \
					confirm_db2_user
	@$(call func_print_caption,"DROPPING OMNIBUS HISTORICAL DB2 DATABASE (ALERTS) IN AUDIT MODE")
	@if [ -d "$(PATH_INSTALL_G_AUDIT)/db2" ] ; \
	then \
		$(CMD_ECHO) "SQL Exists? (OK):        -d $(PATH_INSTALL_G_AUDIT)/db2 # exists" ; \
		\
		$(CMD_ECHO) "Drop Database:           #In progress..." ; \
		$(CMD_ECHO) ; \
		$(CMD_SU) - $(DB2_USER) -c "db2 CONNECT TO ALERTS; db2 DROP TABLE DETAILS; db2 DROP TABLE JOURNAL; db2 DROP TABLE STATUS; db2 DISCONNECT ALERTS; db2 FORCE APPLICATION ALL; sleep 5; db2 DROP DATABASE ALERTS" || \
			{ $(CMD_ECHO) "Drop Database (FAIL):    $(CMD_SU) - $(DB2_USER) -c \"db2 CONNECT TO ALERTS; db2 DROP TABLE DETAILS; db2 DROP TABLE JOURNAL; db2 DROP TABLE STATUS; db2 DISCONNECT ALERTS; db2 FORCE APPLICATION ALL; sleep 5; db2 DROP DATABASE ALERTS\"" ; \
			exit 9; } ; \
		$(CMD_ECHO) "Drop Database (OK):      $(CMD_SU) - $(DB2_USER) -c \"db2 CONNECT TO ALERTS; db2 DROP TABLE DETAILS; db2 DROP TABLE JOURNAL; db2 DROP TABLE STATUS; db2 DISCONNECT ALERTS; db2 FORCE APPLICATION ALL; sleep 5; db2 DROP DATABASE ALERTS\"" ; \
	else \
		$(CMD_ECHO) "SQL Exists? (OK):        -d $(PATH_INSTALL_G_AUDIT)/db2 # non-existent" ; \
	fi
	@$(CMD_ECHO)

################################################################################
# CONFIGURE DB2 AUDIT DATABASE PURGE SCRIPT AND CRON JOB
################################################################################
configure_audit_db_purge:	check_whoami \
							check_commands \
							confirm_omnibus_user \
							confirm_omnibus_group \
							confirm_db2_user \
							check_crond

	@$(call func_print_caption,"CONFIGURING PURGING OF OMNIBUS HISTORICAL DB2 DATABASE (AUDIT MODE)")
	@$(call func_file_must_exist,$(DB2_USER),$(DB2_HOME)/sqllib/bin/db2)
	@if [ -f "$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT)" ] ; \
	then \
		$(CMD_ECHO) "Purge Script? (WARN):    -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) # already exists" ; \
	else \
		$(CMD_ECHO) "Purge Script? (OK):      -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) # non-existent" ; \
		\
		$(CMD_ECHO) "$$JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT_CONTENT" > $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) || { $(CMD_ECHO) ; \
			 "Purge Script (FAIL):     #$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) failed to configure" ; \
			exit 10; } ; \
		$(CMD_ECHO) "Purge Script (OK):       #$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) configured" ; \
		$(call func_chmod,644,$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT)) ; \
		$(call func_chown,$(OMNIBUS_USER),$(OMNIBUS_GROUP),$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT)) ; \
	fi

	@if [ "$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CHECK)" = "" ] ; \
	then \
		$(CMD_ECHO) "Crontab Entry (OK):      $(CMD_CRONTAB) -u $(DB2_USER) -l | $(CMD_GREP) $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) # $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) entry does not exists" ; \
		\
		\
	        if [ -f "$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB)" ] ; \
	        then \
			$(CMD_ECHO) "Crontab File? (WARN):    -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB) # already exists" ; \
		else \
			$(CMD_ECHO) "Crontab File? (OK):      -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB) # non-existent" ; \
			$(CMD_ECHO) "$$JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CONTENT" > $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB) || { $(CMD_ECHO) \
				"Crontab File (FAIL):     #$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB)" ; \
				exit 11; } ; \
			$(CMD_ECHO) "Crontab File (OK):       #$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB)" ; \
			$(call func_chmod,644,$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB)) ; \
			$(call func_chown,$(OMNIBUS_USER),$(OMNIBUS_GROUP),$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB)) ; \
		fi ; \
		\
		\
		if [ "$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_NOEXIST)" = "no crontab for $(DB2_USER)" ] ; \
		then \
			$(CMD_ECHO) "Crontab Exist? (OK):     $(CMD_GREP) \"no crontab for $(DB2_USER)\" $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDERR) # no crontable exists, install table" ; \
			\
			$(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB) || { $(CMD_ECHO) ; \
				"Crontab Install (FAIL):  $(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB)" ; \
				exit 12; } ; \
			$(CMD_ECHO) "Crontab Install (OK):    $(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB)" ; \
			\
		else \
			$(CMD_ECHO) "Crontab Exist? (OK):     $(CMD_GREP) \"no crontab for $(DB2_USER)\" $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDERR) # suggests crontab entries exist, retrieve table and append to it" ; \
			\
			\
			$(CMD_CRONTAB) -u $(DB2_USER) -l > $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT); rc=$$?; \
			$(CMD_TEST) $$rc -ne 0 && { $(CMD_ECHO) \
				"Crontab List (FAIL):     $(CMD_CRONTAB) -u $(DB2_USER) -l > $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ; \
				exit 13; } ; \
			$(CMD_ECHO) "Crontab List (OK):       $(CMD_CRONTAB) -u $(DB2_USER) -l > $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ; \
			\
			\
			$(call func_cat_append,$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB),$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)) ; \
			\
			\
			$(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT) || { $(CMD_ECHO) ; \
				"Crontab Append (FAIL):   $(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ; \
				exit 14; } ; \
			$(CMD_ECHO) "Crontab Append (OK):     $(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ; \
		fi ; \
	else \
		$(CMD_ECHO) "Crontab Entry (WARN):    $(CMD_CRONTAB) -u $(DB2_USER) -l | $(CMD_GREP) $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) # $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) entry already exists" ; \
	fi

################################################################################
# DECONFIGURE DB2 AUDIT DATABASE PURGE SCRIPT AND CRON JOB
################################################################################
deconfigure_audit_db_purge:	check_whoami \
							check_commands \
							confirm_omnibus_user \
							confirm_db2_user
	@$(call func_print_caption,"DECONFIGURING PURGING OF OMNIBUS HISTORICAL DB2 DATABASE (AUDIT MODE)")
	@if [ -f "$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT)" ] ; \
	then \
		$(CMD_ECHO) "Purge Script? (OK):      -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) # exists" ; \
		$(call func_rm_if_sha512sum_match,$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT),$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT_CHECKSUM)) ; \
		$(call func_mv_if_exists,$(OMNIBUS_USER),$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT),$(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT).$(TIMESTAMP)) ; \
	else \
		$(CMD_ECHO) "Purge Script? (OK):      -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) # non-existent" ; \
	fi

	@if [ "$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CHECK)" = "" ] ; \
	then \
		$(CMD_ECHO) "Crontab Entry (OK):      $(CMD_CRONTAB) -u $(DB2_USER) -l | $(CMD_GREP) $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) # $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) entry does not exists" ; \
	else \
		$(CMD_ECHO) "Crontab Entry (OK):      $(CMD_CRONTAB) -u $(DB2_USER) -l | $(CMD_GREP) $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) # $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) entry exists" ; \
		\
		\
		$(CMD_CRONTAB) -u $(DB2_USER) -l | $(CMD_GREP) -v $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) > $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT); rc=$$?; \
		($(CMD_TEST) $$rc -eq 0 -o $(CMD_TEST) $$rc -eq 1) && { $(CMD_ECHO) \
			"Crontab Extract (FAIL):  $(CMD_CRONTAB) -u $(DB2_USER) -l | $(CMD_GREP) -v $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) > $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ; \
			exit 15; } ; \
		$(CMD_ECHO) "Crontab Extract (OK):    $(CMD_CRONTAB) -u $(DB2_USER) -l | $(CMD_GREP) -v $(JAVA_GATEWAY_PURGE_AUDIT_DB_SCRIPT) > $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ; \
		\
		\
		if [ -s "$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ] ; \
		then \
			$(CMD_ECHO) "Crontab Remain? (OK):    -s $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT) # crontab entries remain, restore remaining table" ; \
			\
			$(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT) || { $(CMD_ECHO) ; \
				"Crontab Restore (FAIL):  $(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ; \
				exit 16; } ; \
			$(CMD_ECHO) "Crontab Restore (OK):    $(CMD_CRONTAB) -u $(DB2_USER) $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)" ; \
		else \
			$(CMD_ECHO) "Crontab Remain? (OK):    -s $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT) # no more crontab entries exist, remove table " ; \
			$(CMD_CRONTAB) -u $(DB2_USER) -r || { $(CMD_ECHO) ; \
				"Crontab Remove (FAIL):   $(CMD_CRONTAB) -u $(DB2_USER) -r" ; \
				exit 17; } ; \
			$(CMD_ECHO) "Crontab Remove (OK):     $(CMD_CRONTAB) -u $(DB2_USER) -r" ; \
		fi ; \
	fi

	@if [ -f "$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB)" ] ; \
	then \
		$(CMD_ECHO) "Crontab File? (OK):      -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB) # exists" ; \
		$(call func_rm_if_sha512sum_match,$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB),$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_CHECKSUM)) ; \
		$(call func_mv_if_exists,$(OMNIBUS_USER),$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB),$(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB).$(TIMESTAMP)) ; \
	else \
		$(CMD_ECHO) "Crontab File? (OK):      -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB) # non-existent" ; \
	fi

################################################################################
# CONFIGURE NETCOOL/OMNIBUS OMNI.DAT FILE WITH JDBC GATEWAY FOR DB2 AUDIT MODE
################################################################################
configure_omni_dat:	check_whoami \
					check_commands \
					confirm_omnibus_user
	@$(call func_print_caption,"CONFIGURING NETCOOL/OMNIBUS OMNI.DAT (JDBC GATEWAY FOR DB2 AUDIT MODE)")

	@$(call func_file_must_exist,$(OMNIBUS_USER),$(NETCOOL_ETC_OMNIDAT))
	@$(eval TEMP_OMNI_DAT_PORT=`$(CMD_GREP) " $(OMNIBUS_AUDIT_PORT)$$$$" $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^\#`)

	@if [ "$(OMNI_DAT_ENTRY_CONTENT_CHECK)" = "" ] ; \
	then \
		$(CMD_ECHO) "omni.dat Entry (OK):     $(CMD_GREP) -F \"$(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE)\" $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^# # $(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE) entry does not exists" ; \
		\
		if [ "$(TEMP_OMNI_DAT_PORT)" != "" ] ; \
		then \
			$(CMD_ECHO) "omni.dat Port (FAIL):    $(CMD_GREP) \" $(OMNIBUS_AUDIT_PORT)$$\" $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^# # Port $(OMNIBUS_AUDIT_PORT) already used" ; \
			exit 18; \
		else \
			$(CMD_ECHO) "omni.dat Port (OK):      $(CMD_GREP) \" $(OMNIBUS_AUDIT_PORT)$$\" $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^# # Port $(OMNIBUS_AUDIT_PORT) available" ; \
		fi ; \
		\
		$(call func_port_must_be_available,$(OMNIBUS_AUDIT_PORT)) ; \
		\
		$(call func_cp_must_exist,$(OMNIBUS_USER),$(NETCOOL_ETC_OMNIDAT),$(NETCOOL_ETC_OMNIDAT).$(TIMESTAMP),644) ; \
		$(CMD_ECHO) "$$OMNI_DAT_ENTRY_CONTENT" >> $(NETCOOL_ETC_OMNIDAT) || { $(CMD_ECHO) \
			"omni.dat Add (FAIL):     #$(OMNIBUS_AUDIT_NAME) to $(NETCOOL_ETC_OMNIDAT)" ; \
			exit 19; } ; \
		$(CMD_ECHO) "omni.dat Add (OK):       #$(OMNIBUS_AUDIT_NAME) to $(NETCOOL_ETC_OMNIDAT)" ; \
		\
		$(call func_file_must_exist,$(OMNIBUS_USER),$(NETCOOL_BIN_IGEN)) ; \
		$(CMD_SU) - $(OMNIBUS_USER) -c "export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)" || { $(CMD_ECHO) \
			 "Netcool igen (FAIL):     $(CMD_SU) - $(OMNIBUS_USER) -c \"export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)\"" ; \
			exit 20; } ; \
		$(CMD_ECHO) "Netcool igen (OK):       $(CMD_SU) - $(OMNIBUS_USER) -c \"export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)\"" ; \
		\
	else \
		$(CMD_ECHO) "omni.dat Entry (WARN):   $(CMD_GREP) -F \"$(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE)\" $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^# # $(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE) entry already exists" ; \
	fi
	@$(CMD_ECHO)

################################################################################
# DECONFIGURE NETCOOL/OMNIBUS OMNI.DAT FILE WITH JDBC GATEWAY FOR DB2 AUDIT MODE
################################################################################
deconfigure_omni_dat:	check_whoami \
						check_commands \
						confirm_omnibus_user
	@$(call func_print_caption,"DECONFIGURING NETCOOL/OMNIBUS OMNI.DAT (JDBC GATEWAY FOR DB2 AUDIT MODE)")
	@if [ -f "$(NETCOOL_ETC_OMNIDAT)" ] ; \
	then \
		$(CMD_ECHO) "omni.dat Exists? (OK):   -f $(NETCOOL_ETC_OMNIDAT) # exists" ; \
		\
		if [ "$(OMNI_DAT_ENTRY_CONTENT_CHECK)" != "" ] ; \
		then \
			$(CMD_ECHO) "omni.dat Entry (OK):     $(CMD_GREP) -F \"$(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE)\" $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^# # $(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE) entry exists" ; \
			\
			CONTENT_LINE_START=`$(CMD_GREP) -n -F "$(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE)" $(NETCOOL_ETC_OMNIDAT) | $(CMD_CUT) -d: -f1` ; \
			CONTENT_LINE_COUNT=`$(CMD_ECHO) "$$OMNI_DAT_ENTRY_CONTENT" | $(CMD_WC) -l` ; \
			CONTENT_LINE_END=`$(CMD_ECHO) "$$CONTENT_LINE_START + $$CONTENT_LINE_COUNT - 1" | $(CMD_BC)` ; \
			$(call func_file_content_remove,$(OMNIBUS_USER),$(NETCOOL_ETC_OMNIDAT),$$CONTENT_LINE_START,$$CONTENT_LINE_END,$(OMNI_DAT_ENTRY_CONTENT_CHECKSUM)) ; \
			\
			$(call func_file_must_exist,$(OMNIBUS_USER),$(NETCOOL_BIN_IGEN)) ; \
			$(CMD_SU) - $(OMNIBUS_USER) -c "export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)" || { $(CMD_ECHO) \
				 "Netcool igen (FAIL):     $(CMD_SU) - $(OMNIBUS_USER) -c \"export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)\"" ; \
				exit 21; } ; \
			$(CMD_ECHO) "Netcool igen (OK):       $(CMD_SU) - $(OMNIBUS_USER) -c \"export NCHOME=$(PATH_INSTALL_NETCOOL); $(NETCOOL_BIN_IGEN)\"" ; \
			\
		else \
			$(CMD_ECHO) "omni.dat Entry (WARN):   $(CMD_GREP) -F \"$(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE)\" $(NETCOOL_ETC_OMNIDAT) | $(CMD_GREP) -v ^# # $(OMNI_DAT_ENTRY_CONTENT_FIRSTLINE) entry does not exist" ; \
		fi ; \
	else \
		$(CMD_ECHO) "omni.dat Exists? (OK):   -f $(NETCOOL_ETC_OMNIDAT) # non-existent" ; \
	fi
	@$(CMD_ECHO)

################################################################################
# CONFIGURE GATEWAY FOR DB2 AUDIT MODE
################################################################################
configure_gateway:	check_whoami \
					check_commands \
					confirm_omnibus_user
	@$(call func_print_caption,"CONFIGURING JDBC GATEWAY FOR DB2 AUDIT MODE")
	@if [ -f "$(JDBC_GATEWAY_PROPS_FILE)" ] ; \
	then \
		$(CMD_ECHO) "Props Exists? (WARN):    -f $(JDBC_GATEWAY_PROPS_FILE) # already exists, skipping configuration" ; \
	else \
		$(CMD_ECHO) "Props Exists? (OK):      -f $(JDBC_GATEWAY_PROPS_FILE) # non-existent, configuring" ; \
		\
		$(call func_file_must_exist,$(OMNIBUS_USER),$(JDBC_GATEWAY_PROPS_FILE_TEMPLATE)) ; \
		TEMP_HEAD_END=`$(CMD_GREP) -m 1 -n ^$$ $(JDBC_GATEWAY_PROPS_FILE_TEMPLATE) | $(CMD_CUT) -d: -f1` ; \
		if [ "$$TEMP_HEAD_END" = "" ] ; \
		then \
			$(CMD_ECHO) "Props Template (FAIL):   $(CMD_GREP) -m 1 -n ^$ $(JDBC_GATEWAY_PROPS_FILE_TEMPLATE) | $(CMD_CUT) -d: -f1 # not found" ; \
			exit 22; \
		fi ; \
		\
		$(CMD_SU) - $(OMNIBUS_USER) -c "$(CMD_HEAD) -$$TEMP_HEAD_END $(JDBC_GATEWAY_PROPS_FILE_TEMPLATE) > $(JDBC_GATEWAY_PROPS_FILE)" || { $(CMD_ECHO) \
			"Props Header (FAIL):     $(CMD_SU) - $(OMNIBUS_USER) -c \"$(CMD_HEAD) -$$TEMP_HEAD_END $(JDBC_GATEWAY_PROPS_FILE_TEMPLATE) > $(JDBC_GATEWAY_PROPS_FILE)\"" ; \
			exit 23; } ; \
		$(CMD_ECHO) "Props Header (OK):       $(CMD_SU) - $(OMNIBUS_USER) -c \"$(CMD_HEAD) -$$TEMP_HEAD_END $(JDBC_GATEWAY_PROPS_FILE_TEMPLATE) > $(JDBC_GATEWAY_PROPS_FILE)\"" ; \
		\
		$(CMD_ECHO) "$$JDBC_GATEWAY_PROPS_CONTENT" >> $(JDBC_GATEWAY_PROPS_FILE) || { $(CMD_ECHO) \
			"Props Configure (FAIL):  # Failed to configure $(JDBC_GATEWAY_PROPS_FILE)" ; \
			exit 24; } ; \
		$(CMD_ECHO) "Props Configure (OK):    # Configured $(JDBC_GATEWAY_PROPS_FILE)" ; \
		\
		$(CMD_ECHO) "Command File (PENDING):  # Copying default file..." ; \
		$(call func_cp_must_exist,$(OMNIBUS_USER),$(JDBC_GATEWAY_CMD_TEMPLATE),$(JDBC_GATEWAY_CMD_FILE),644) ; \
		$(CMD_ECHO) "Def File (PENDING):      # Copying default file..." ; \
		$(call func_cp_must_exist,$(OMNIBUS_USER),$(JDBC_GATEWAY_DEF_TEMPLATE),$(JDBC_GATEWAY_DEF_FILE),644) ; \
		$(CMD_ECHO) "Map File (PENDING):      # Copying default file..." ; \
		$(call func_cp_must_exist,$(OMNIBUS_USER),$(JDBC_GATEWAY_MAP_TEMPLATE),$(JDBC_GATEWAY_MAP_FILE),644) ; \
	fi
	@$(CMD_ECHO)

################################################################################
# DECONFIGURE GATEWAY FOR DB2 AUDIT MODE
################################################################################
deconfigure_gateway:	check_whoami \
						check_commands \
						confirm_omnibus_user

	@$(call func_print_caption,"DECONFIGURING JDBC GATEWAY FOR DB2 AUDIT MODE")
	@$(call func_rm_if_sha512sum_match,$(JDBC_GATEWAY_CMD_FILE),$(JDBC_GATEWAY_CMD_CHECKSUM))
	@$(call func_rm_if_sha512sum_match,$(JDBC_GATEWAY_DEF_FILE),$(JDBC_GATEWAY_DEF_CHECKSUM))
	@$(call func_rm_if_sha512sum_match,$(JDBC_GATEWAY_MAP_FILE),$(JDBC_GATEWAY_MAP_CHECKSUM))

	@$(call func_mv_if_exists,$(OMNIBUS_USER),$(JDBC_GATEWAY_CMD_FILE),$(JDBC_GATEWAY_CMD_FILE).$(TIMESTAMP))
	@$(call func_mv_if_exists,$(OMNIBUS_USER),$(JDBC_GATEWAY_DEF_FILE),$(JDBC_GATEWAY_DEF_FILE).$(TIMESTAMP))
	@$(call func_mv_if_exists,$(OMNIBUS_USER),$(JDBC_GATEWAY_MAP_FILE),$(JDBC_GATEWAY_MAP_FILE).$(TIMESTAMP))

	@$(call func_mv_if_exists,$(OMNIBUS_USER),$(JDBC_GATEWAY_PROPS_FILE),$(JDBC_GATEWAY_PROPS_FILE).$(TIMESTAMP))
	@$(CMD_ECHO)

################################################################################
# CONFIGURE PROCESS AGENT WITH JDBC GATEWAY FOR DB2 AUDIT MODE
################################################################################
configure_pa:		check_whoami \
					check_commands \
					confirm_omnibus_user
	@$(call func_print_caption,"CONFIGURING PROCESS AGENT (JDBC GATEWAY FOR DB2 AUDIT MODE)")
	@if [	"$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_CHECK)" = "" -o \
		"$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_CHECK)" = "" ] ; \
	then \
		$(CMD_ECHO) "PA Configured? (OK):     # Process Entry and/or Dependency Entry do not exist for $(OMNIBUS_AUDIT_PA_PROCESS)" ; \
		$(CMD_ECHO) "PA Config Backup (OK):   # Pending..." ; \
		$(call func_cp_must_exist,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE),$(NCO_PA_CONF_FILE).$(TIMESTAMP),644) ; \
		\
		$(call func_file_must_not_exist,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE_NEW)) ; \
		\
		if [ "$(NCO_PA_CONF_PROCESS_ENTRY_INSERT_CHECK2)" != "" ] ; \
		then \
			$(CMD_ECHO) "Insert Point? (OK):      $(CMD_GREP) ^\"$(NCO_PA_CONF_PROCESS_ENTRY_INSERT_LINE2)\" $(NCO_PA_CONF_FILE) # found" ; \
			PROCESS_INSERT_POINT=`$(CMD_GREP) -n ^"$(NCO_PA_CONF_PROCESS_ENTRY_INSERT_LINE2)" $(NCO_PA_CONF_FILE) | $(CMD_CUT) -d: -f1` ; \
			PROCESS_INSERT_POINT=`$(CMD_ECHO) "$$PROCESS_INSERT_POINT - 1" | $(CMD_BC)` ; \
			if [ "`$(CMD_SED) -n -e $$PROCESS_INSERT_POINT\p $(NCO_PA_CONF_FILE)`" = "$(NCO_PA_CONF_PROCESS_ENTRY_INSERT_LINE1)" ] ; \
			then \
				PROCESS_INSERT_POINT=`$(CMD_ECHO) "$$PROCESS_INSERT_POINT - 1" | $(CMD_BC)` ; \
			fi ; \
		else \
			$(CMD_ECHO) "Insert Point? (FAIL):    $(CMD_GREP) ^\"$(NCO_PA_CONF_PROCESS_ENTRY_INSERT_LINE2)\" $(NCO_PA_CONF_FILE) # not found" ; \
			exit 25; \
		fi ; \
		$(call func_file_content_copy,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE),1,$$PROCESS_INSERT_POINT,$(NCO_PA_CONF_FILE_NEW)) ; \
		PROCESS_INSERT_POINT=`$(CMD_ECHO) "$$PROCESS_INSERT_POINT + 1" | $(CMD_BC)` ; \
		\
		if [ "$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_CHECK)" = "" ] ; \
		then \
			$(CMD_ECHO) "Process Entry? (OK):     $(CMD_GREP) -F \"$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE)\" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^# # $(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE) entry does not exist" ; \
			\
			$(CMD_ECHO) "$$NCO_PA_CONF_PROCESS_ENTRY_CONTENT" >> $(NCO_PA_CONF_FILE_NEW) || { $(CMD_ECHO) \
				 "Process Entry (FAIL):    #$(NCO_PA_CONF_FILE_NEW)" ; \
				exit 26; } ; \
			$(CMD_ECHO) "Process Entry (OK):      #$(NCO_PA_CONF_FILE_NEW)" ; \
		else \
			$(CMD_ECHO) "Process Entry? (WARN):   $(CMD_GREP) -F \"$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE)\" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^# # $(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE) entry exists" ; \
		fi ; \
		\
		if [ "$(NCO_PA_CONF_DEPENDENCY_ENTRY_INSERT_CHECK)" != "" ] ; \
		then \
			$(CMD_ECHO) "Insert Point? (OK):      $(CMD_GREP) -P ^\"$(NCO_PA_CONF_DEPENDENCY_ENTRY_INSERT_LINE)\" $(NCO_PA_CONF_FILE) # found" ; \
			DEPENDENCY_INSERT_POINT=`$(CMD_GREP) -n -P ^"$(NCO_PA_CONF_DEPENDENCY_ENTRY_INSERT_LINE)" $(NCO_PA_CONF_FILE) | $(CMD_CUT) -d: -f1` ; \
		else \
			$(CMD_ECHO) "Insert Point? (FAIL):    $(CMD_GREP) -P ^\"$(NCO_PA_CONF_DEPENDENCY_ENTRY_INSERT_LINE)\" $(NCO_PA_CONF_FILE) # not found" ; \
			exit 27; \
		fi ; \
		$(call func_file_content_copy,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE),$$PROCESS_INSERT_POINT,$$DEPENDENCY_INSERT_POINT,$(NCO_PA_CONF_FILE_NEW)) ; \
		DEPENDENCY_INSERT_POINT=`$(CMD_ECHO) "$$DEPENDENCY_INSERT_POINT + 1" | $(CMD_BC)` ; \
		\
		if [ "$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_CHECK)" = "" ] ; \
		then \
			$(CMD_ECHO) "Dependency Entry? (OK):  $(CMD_GREP) -P \"$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE)\" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^# # $(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE) entry does not exist" ; \
			\
			$(CMD_ECHO) -e "$$NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT" >> $(NCO_PA_CONF_FILE_NEW) || { $(CMD_ECHO) \
				 "Dependency Entry (FAIL): #$(NCO_PA_CONF_FILE_NEW)" ; \
				exit 28; } ; \
			$(CMD_ECHO) "Dependency Entry (OK):   #$(NCO_PA_CONF_FILE_NEW)" ; \
			\
		else \
			$(CMD_ECHO) "Dependency Entry? (WARN):$(CMD_GREP) -P \"$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE)\" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^# # $(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE) entry exists" ; \
		fi ; \
		\
		$(call func_file_content_copy,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE),$$DEPENDENCY_INSERT_POINT,$$,$(NCO_PA_CONF_FILE_NEW)) ; \
		\
		$(call func_mv_must_exist,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE_NEW),$(NCO_PA_CONF_FILE)) ; \
		\
	else \
		$(CMD_ECHO) "PA Configured? (WARN):   # Process Entry and Dependency Entry already exists for $(OMNIBUS_AUDIT_PA_PROCESS)" ; \
	fi
	@$(CMD_ECHO)

################################################################################
# DECONFIGURE PROCESS AGENT WITH JDBC GATEWAY FOR DB2 AUDIT MODE
################################################################################
deconfigure_pa:		check_whoami \
					check_commands \
					confirm_omnibus_user
	@$(call func_print_caption,"DECONFIGURING PROCESS AGENT (JDBC GATEWAY FOR DB2 AUDIT MODE)")
	@if [ -f "$(NCO_PA_CONF_FILE)" ] ; \
	then \
		$(CMD_ECHO) "PA Conf Exists? (OK):    -f $(NCO_PA_CONF_FILE) # exists" ; \
		$(CMD_ECHO) "PA Config Backup (OK):   # Pending..." ; \
		$(call func_cp_must_exist,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE),$(NCO_PA_CONF_FILE).$(TIMESTAMP),644) ; \
		\
		if [ "$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_CHECK)" != "" ] ; \
		then \
			$(CMD_ECHO) "Process Entry? (OK):     $(CMD_GREP) -F \"$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE)\" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^# # $(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE) entry exists" ; \
			\
			CONTENT_LINE_START=`$(CMD_GREP) -n -F "$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE)" $(NCO_PA_CONF_FILE) | $(CMD_CUT) -d: -f1` ; \
			CONTENT_LINE_COUNT=`$(CMD_ECHO) "$$NCO_PA_CONF_PROCESS_ENTRY_CONTENT" | $(CMD_WC) -l` ; \
			CONTENT_LINE_END=`$(CMD_ECHO) "$$CONTENT_LINE_START + $$CONTENT_LINE_COUNT - 1" | $(CMD_BC)` ; \
			$(call func_file_content_remove,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE),$$CONTENT_LINE_START,$$CONTENT_LINE_END,$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_CHECKSUM)) ; \
			\
		else \
			$(CMD_ECHO) "Process Entry? (WARN):   $(CMD_GREP) -F \"$(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE)\" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^# # $(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE) entry does not exist" ; \
		fi ; \
		\
		if [ "$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_CHECK)" != "" ] ; \
		then \
			$(CMD_ECHO) "Dependency Entry (OK):   $(CMD_GREP) -P \"$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE)\" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^# # $(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE) entry exists" ; \
			\
			CONTENT_LINE_START=`$(CMD_GREP) -n -P "$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE)" $(NCO_PA_CONF_FILE) | $(CMD_CUT) -d: -f1` ; \
			CONTENT_LINE_COUNT=`$(CMD_ECHO) "$$NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT" | $(CMD_WC) -l` ; \
			CONTENT_LINE_END=`$(CMD_ECHO) "$$CONTENT_LINE_START + $$CONTENT_LINE_COUNT - 1" | $(CMD_BC)` ; \
			$(call func_file_content_remove,$(OMNIBUS_USER),$(NCO_PA_CONF_FILE),$$CONTENT_LINE_START,$$CONTENT_LINE_END,$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_CHECKSUM)) ; \
			\
		else \
			$(CMD_ECHO) "Dependency Entry (WARN): $(CMD_GREP) -P \"$(NCO_PA_CONF_DEPENDENCY_ENTRY_CONTENT_FIRSTLINE)\" $(NCO_PA_CONF_FILE) | $(CMD_GREP) -v ^# # $(NCO_PA_CONF_PROCESS_ENTRY_CONTENT_FIRSTLINE) entry does not exist" ; \
		fi ; \
	else \
		$(CMD_ECHO) "PA Conf Exists? (OK):    -f $(NCO_PA_CONF_FILE) # non-existent" ; \
	fi
	@$(CMD_ECHO)

################################################################################
# START JDBC GATEWAY FOR DB2 AUDIT MODE
################################################################################
restart_pa:		check_whoami \
				check_commands \
				confirm_omnibus_user
	@$(call func_print_caption,"START JDBC GATEWAY FOR DB2 AUDIT MODE")
	@$(CMD_GREP) " 6" /etc/redhat-release 1> /dev/null; rc=$$? ; \
	if [ $$rc -eq 0 ] ; \
	then \
		$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 6 / Not systemd" ; \
		\
		$(CMD_SERVICE) $(NETCOOL_SERVICE) stop || { $(CMD_ECHO) \
			"nco Stop (FAIL):         $(CMD_SERVICE) $(NETCOOL_SERVICE) stop" ; \
			exit 29; } ; \
		$(CMD_ECHO) "nco Stop (OK):           $(CMD_SERVICE) $(NETCOOL_SERVICE) stop" ; \
		\
		$(CMD_SERVICE) $(NETCOOL_SERVICE) start || { $(CMD_ECHO) \
			"nco Start (FAIL):        $(CMD_SERVICE) $(NETCOOL_SERVICE) start" ; \
			exit 30; } ; \
		$(CMD_ECHO) "nco Start (OK):          $(CMD_SERVICE) $(NETCOOL_SERVICE) start" ; \
	else \
		$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 7+ / systemd" ; \
		\
		$(CMD_SYSTEMCTL) restart $(NETCOOL_SERVICE) || { $(CMD_ECHO) ; \
			"nco Restart (FAIL):      $(CMD_SYSTEMCTL) restart $(NETCOOL_SERVICE)" ; \
			exit 31; } ; \
		$(CMD_ECHO) "nco Restart (OK):        $(CMD_SYSTEMCTL) restart $(NETCOOL_SERVICE)" ; \
	fi
	$(CMD_SLEEP) 5
	$(CMD_ECHO) "nco Status (PENDING):    $(OMNIBUS_BIN_PASTATUS) -server $(NETCOOL_PA_NAME) -user $(OMNIBUS_USER) -password <PASSWORD>"
	@$(CMD_ECHO)
	@$(OMNIBUS_BIN_PASTATUS) -server $(NETCOOL_PA_NAME) -user $(OMNIBUS_USER) -password $(OMNIBUS_PASSWD)
	@$(CMD_ECHO)

################################################################################
# STOP JDBC GATEWAY FOR DB2 AUDIT MODE
################################################################################
stop_gateway:	check_whoami \
				check_commands \
				confirm_omnibus_user
	@$(call func_print_caption,"STOP JDBC GATEWAY FOR DB2 AUDIT MODE")
	@if [ -d "$(PATH_INSTALL_OMNIBUS)" ] ; \
	then \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # exists" ; \
		$(CMD_ECHO) "Gateway Stop (PENDING):  $(OMNIBUS_BIN_PASTOP) -server $(NETCOOL_PA_NAME) -process $(OMNIBUS_AUDIT_PA_PROCESS) -user $(OMNIBUS_USER) -password <PASSWORD>" ; \
	$(OMNIBUS_BIN_PASTOP) -server $(NETCOOL_PA_NAME) -process $(OMNIBUS_AUDIT_PA_PROCESS) -user $(OMNIBUS_USER) -password $(OMNIBUS_PASSWD) ; \
	else \
		$(CMD_ECHO) "OMNIbus Exists? (OK):    -d $(PATH_INSTALL_OMNIBUS) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:	check_commands
	@$(call func_print_caption,"REMOVING TEMPORARY CRONTAB PROCESSING FILES")
	@$(CMD_RM) -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDOUT)
	@$(CMD_RM) -f $(JAVA_GATEWAY_PURGE_AUDIT_DB_CRONTAB_STDERR)
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM) -rf /tmp/ciclogs_$(OMNIBUS_USER)
	@$(CMD_ECHO)

