###############################################################################
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
# Brad Armstrong 
# March 1, 2020
#
# DB2 installs as root.
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
MAKE_PRODUCT			= DB2EnterpriseServer
MAKE_PRODUCT_VERSION	= 11.1

################################################################################
# INSTALLATION PATHS
################################################################################
PATH_INSTALL			:= /opt/IBM
PATH_INSTALL_DB2		= $(PATH_INSTALL)/db2
PATH_INSTALL_DB2_VER	        = $(PATH_INSTALL_DB2)/V11.1

FILE_DB2_LICENSE		= db2ese_o.lic
PATH_DB2_LICENSE_DIR	= $(PATH_INSTALL_DB2_VER)/license/warehouse
PATH_DB2_LICENSE_ZIP	= ese_o/warehouse/$(FILE_DB2_LICENSE)

PATH_REPOSITORY_INSTALL := $(PATH_MAKEFILE_REPOSITORY)/db2_server_11_5
PATH_REPOSITORY_INSTALL_SQL := $(PATH_MAKEFILE_REPOSITORY)/db2_itnm_sql

################################################################################
# TEMPORARY MAKE DIRECTORY
################################################################################
PATH_TEMP_BASE			:= $(MAKE_PRODUCT).make
PATH_TEMP_TEMPLATE		:= $(PATH_TMP)/$(PATH_TEMP_BASE).XXXXXXXX
PATH_TEMP_DIR			:= $(shell $(CMD_MKTEMP) -d $(PATH_TEMP_TEMPLATE) 2> /dev/null)

################################################################################
# INSTALLATION USERS
################################################################################
DB2_USER				:= db2inst1
DB2_PASSWD				:= $(DB2_USER)
DB2_GROUP				:= db2iadm1
DB2_SHELL				:= /bin/bash
DB2_PORT				:= 50000
DB2_HOME				:= /db2/$(DB2_USER)
DB2_PROFILE				:= $(DB2_HOME)/sqllib/db2profile

DB2_DAS_USER			:= dasusr1
DB2_DAS_PASSWD			:= $(DB2_DAS_USER)
DB2_DAS_GROUP			:= dasadm
DB2_DAS_SHELL			:= /bin/bash
DB2_DAS_HOME			:= $(PATH_HOME)/$(DB2_DAS_USER)

DB2_FENC_USER			:= db2fenc1
DB2_FENC_PASSWD			:= $(DB2_FENC_USER)
DB2_FENC_GROUP			:= db2fadm1
DB2_FENC_SHELL			:= /bin/bash
DB2_FENC_HOME			:= $(PATH_HOME)/$(DB2_FENC_USER)

DB2_PACKAGES			=	$(PACKAGES_COMMON) \
							libstdc++.x86_64 \
							libstdc++.i686 \
							pam.i686

################################################################################
# INSTALLATION MEDIA, DESCRIPTIONS, FILES, AND CHECKSUMS
################################################################################
MEDIA_ALL_DESC	=	\t$(MEDIA_STEP1_D)\n \
					\t$(MEDIA_STEP2_D)\n

MEDIA_ALL_FILES	=	$(MEDIA_STEP1_F) \
					$(MEDIA_STEP2_F)

MEDIA_STEP1_D	:= IBM DB2 Server V10.5 for Linux on AMD64 and Intel EM64T systems\n\t\t(x64) Multilingual (CIXV0ML)

MEDIA_STEP1_F	:= $(PATH_MAKEFILE_MEDIA)/DB2_AWSE_REST_Svr_11.1_Lnx_86-64.tar.gz
MEDIA_STEP2_F	:= $(PATH_MAKEFILE_MEDIA)/db2_creation_scripts.tar.gz

MEDIA_STEP1_B	:= 4e5a24e73f569cda4e195320a469763764390b96ebaff29fcf8a85a482b38f804e5d4293d3ed5949195500163cca961f6238b7f3beb21ba94f2cba6492869808

################################################################################
# DB2 INSTALLATION RESPONSE FILE TEMPLATE
################################################################################
DB2_RESPONSE_FILE=$(PATH_TEMP_DIR)/db2server.rsp
define DB2_RESPONSE_FILE_CONTENT
*-----------------------------------------------------
* Generated response file used by the DB2 Setup wizard
* generation time: 3/22/21 5:18 PM
*-----------------------------------------------------
*  Product Installation
LIC_AGREEMENT       = ACCEPT
PROD       = DB2_SERVER_EDITION
FILE       = /opt/IBM/db2/V11.1
INSTALL_TYPE       = TYPICAL
*-----------------------------------------------
*  Das properties
*-----------------------------------------------
DAS_CONTACT_LIST       = LOCAL
* ----------------------------------------------
*  Instance properties
* ----------------------------------------------
INSTANCE       = inst1
inst1.TYPE       = ese
*  Instance-owning user
inst1.NAME       = db2inst1
inst1.GROUP_NAME       = db2iadm1
inst1.HOME_DIRECTORY       = /db2/db2inst1
inst1.PASSWORD       = 947158133430482493535347340213354444260815926229646735711384135132319113346723526456370322305053133312848194556215304240356162925986533532484308018521754676050971246153115571961246715061727233135853677532337153954529114441457420523781036012478627389664465573616403403936913402442156925698349719563632403522038332673005336351584745034481430374759546341722693901358436926192343143431917545321732554255209345502145627054340769557632603515228483004452317565508527981043249505034367769552252563246444227946917675986941275204543815073453107522991806203685698542565244582911432154334462402265653276531585742610161902936064771633284433334117352435051563931809516440018027126697865559751752245387334372508948462638622390341309730825410434187791505376201054813632269343646723540
ENCRYPTED       = inst1.PASSWORD
inst1.AUTOSTART       = YES
inst1.SVCENAME       = db2c_db2inst1
inst1.PORT_NUMBER       = 50000
inst1.FCM_PORT_NUMBER       = 60000
inst1.MAX_LOGICAL_NODES       = 6
inst1.CONFIGURE_TEXT_SEARCH       = NO
*  Fenced user
inst1.FENCED_USERNAME       = db2fenc2
inst1.FENCED_GROUP_NAME       = db2fadm1
inst1.FENCED_HOME_DIRECTORY       = /home/db2fenc2
inst1.FENCED_PASSWORD       = 484746172253232313477079343345324024635327406241182605226816292976496335603458253253833344621313644412618263358883663412183583512520854201323477736599423028452562686542243836031657532248873446728575673391524007643724661233372056466012666565225057062543465192930305614433523113857332058848365695329144575227127772746875225400821003315942459478132993118544440642353214871424392639836945982362402240224806325357169334673380023851261414052146277859654898235428123262681484620272272262031325329857953055626455562585089234393243105110139242375757686506377323253430323562745258238447256178276644744593821197756153115229252878345638308444565426362928194303524637892124429964519064069571465196972580077042095327461561800068530111105265309446562565323272341146527517533765389373
ENCRYPTED       = inst1.FENCED_PASSWORD
*-----------------------------------------------
*  Installed Languages
*-----------------------------------------------
LANG       = EN
endef
export DB2_RESPONSE_FILE_CONTENT

################################################################################
# DB2 SYSTEMD STARTUP CONFIGURATION (RED HAT 7+ USES SYSTEMD)
################################################################################
DB2_SYSTEMD_FILE=/etc/systemd/system/db2fmcd.service
define DB2_SYSTEMD_FILE_CONTENT
[Unit]
Description=DB2V105

[Service]
ExecStart=$(PATH_INSTALL_DB2_VER)/bin/db2fmcd
Restart=always
KillMode=process
KillSignal=SIGHUP

[Install]
WantedBy=default.target
endef
export DB2_SYSTEMD_FILE_CONTENT

################################################################################
# MAIN BUILD TARGETS
################################################################################
default:				help

all:					help \
						install


install:				preinstallchecks \
						preinstall \
						theinstall \
						postinstall

uninstall:				preuninstallchecks \
						preuninstall \
						theuninstall \
						postuninstall

verify:					validate_db2

preinstallchecks:		check_commands \
						check_media_exists \
						check_media_checksums 

preinstall:			create_db2_home

theinstall:				install_db2 \
						configure_tcp \
						configure_itnm_db 

postinstall:			clean

preuninstallchecks:		check_commands

preuninstall:			

theuninstall:			autostartoff_db2 \
						uninstall_db2

postuninstall:			remove_root_path \
						clean

clean:					remove_temp_dir \
						remove_db2_install_response_file \
						clean_tmp

scrub:					uninstall \
						scrub_users

# WARNING scrub_users WILL REMOVE USERS AND HOME DIRECTORIES INCLUDING ALL
# CONTENT AND ANY INSTALL MANAGERS IN SAME.  IF THE SAME USERNAME IS USED
# FOR MORE THAN ONE PRODUCT INSTALL, THEN THIS SHOULD BE DONE WITH EXTREME
# CAUTION
scrub_users:			remove_db2_groups \
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
check_commands:						check_whoami
	@$(call func_print_caption,"CHECKING COMMANDS")
	@$(foreach itr_c,$(CMD_ALL),$(call func_command_check,$(itr_c)))
	@$(CMD_ECHO)

################################################################################
# CHECK MEDIA FILES EXIST AND ARE READABLE
################################################################################
check_media_exists:					check_commands
	@$(call func_print_caption,"CHECKING FOR INSTALLATION MEDIA")
	@$(call func_check_media_exists,$(MEDIA_ALL_FILES))
	@$(CMD_ECHO)

################################################################################
# CONFIRM MEDIA INTEGRITY VIA CHECKSUMS
################################################################################
check_media_checksums:				check_commands
	@$(call func_print_caption,"CHECKING INSTALLATION MEDIA CHECKSUMS")
	@$(call func_check_file_cksum,$(MEDIA_STEP1_F),$(MEDIA_STEP1_B))
	@$(CMD_ECHO)

################################################################################
# INSTALL PREREQUISITE PACKAGES
################################################################################
install_packages:					check_whoami
	@$(call func_print_caption,"INSTALLING PREREQUISITE PACKAGES")
	@$(call func_install_packages,$(DB2_PACKAGES))
	@$(CMD_ECHO)

################################################################################
# CREATE TEMPORARY DIRECTORY
################################################################################
create_temp_dir:					check_whoami \
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
remove_temp_dir:					check_whoami \
									check_commands
	@$(call func_print_caption,"REMOVING TEMPORARY DIRECTORIES")
	@$(CMD_RM) -rf $(PATH_TMP)/$(PATH_TEMP_BASE).*
	@$(CMD_ECHO)

################################################################################
# CREATE THE ROOT PATH DIRECTORY IF IT DOESN'T EXIST
################################################################################
create_root_path:					check_whoami \
									check_commands
	@$(call func_print_caption,"CREATING ROOT INSTALL DIRECTORY IF NEEDED")
	@$(call func_mkdir,root,root,755,$(PATH_INSTALL))
	@$(CMD_ECHO)

# only remove root path if empty, do not backup/move as may not be last product
remove_root_path:					check_whoami \
									check_commands
	@$(call func_print_caption,"REMOVING ROOT INSTALL DIRECTORY IF EMPTY")
	@$(call func_rmdir_if_empty,$(PATH_INSTALL))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE GROUPS
################################################################################
create_db2_groups:					check_whoami \
									check_commands
	@$(call func_print_caption,"CONFIRMING/CREATING DB2 GROUPS")
	@$(call func_create_group,$(DB2_GROUP),$(MAKE_PRODUCT))
	@$(call func_create_group,$(DB2_DAS_GROUP),$(MAKE_PRODUCT))
	@$(call func_create_group,$(DB2_FENC_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# REMOVE GROUPS
################################################################################
remove_db2_groups:					check_whoami \
									check_commands \
									remove_db2_users
	@$(call func_print_caption,"REMOVING DB2 GROUP")
	@$(call func_remove_group,$(DB2_GROUP),$(MAKE_PRODUCT))
	@$(call func_remove_group,$(DB2_DAS_GROUP),$(MAKE_PRODUCT))
	@$(call func_remove_group,$(DB2_FENC_GROUP),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# CONFIRM OR CREATE USERS
################################################################################
create_db2_users:					check_whoami \
									check_commands \
									create_db2_groups
	@$(call func_print_caption,"CONFIRMING/CREATING DB2 USERS")
	@$(call func_create_user,$(DB2_USER),$(MAKE_PRODUCT),$(DB2_GROUP),$(DB2_HOME),$(DB2_SHELL),$(DB2_PASSWD))
	@$(call func_create_user,$(DB2_DAS_USER),$(MAKE_PRODUCT),$(DB2_DAS_GROUP),$(DB2_DAS_HOME),$(DB2_DAS_SHELL),$(DB2_DAS_PASSWD))
	@$(call func_create_user,$(DB2_FENC_USER),$(MAKE_PRODUCT),$(DB2_FENC_GROUP),$(DB2_FENC_HOME),$(DB2_FENC_SHELL),$(DB2_FENC_PASSWD))
	@$(CMD_ECHO)

################################################################################
# REMOVE USERS
################################################################################
remove_db2_users:					check_whoami \
									check_commands
	@$(call func_print_caption,"REMOVING DB2 USERS")
	@$(call func_remove_user,$(DB2_USER),$(MAKE_PRODUCT))
	@$(call func_remove_user,$(DB2_DAS_USER),$(MAKE_PRODUCT))
	@$(call func_remove_user,$(DB2_FENC_USER),$(MAKE_PRODUCT))
	@$(CMD_ECHO)

################################################################################
# PREPARE DB2 MEDIA
################################################################################
prepare_db2_media:					check_whoami \
									check_commands \
									create_temp_dir
	@$(call func_print_caption,"PREPARING DB2 MEDIA")
	@$(call func_tar_zxf_to_new_dir,root,root,755,$(MEDIA_STEP1_F),$(PATH_REPOSITORY_INSTALL))
	@$(call func_tar_zxf_to_new_dir,root,root,755,$(MEDIA_STEP2_F),$(PATH_REPOSITORY_INSTALL_SQL))
	@$(CMD_ECHO)

################################################################################
# CREATE THE DB2 INSTALLATION RESPONSE FILE (NOW THAT DB2_USER UID IS AVAILABLE)
################################################################################
create_db2_install_response_file:	check_whoami \
									check_commands \
									create_temp_dir 


	@$(CMD_ECHO) "$$DB2_RESPONSE_FILE_CONTENT" | $(CMD_SED) -e "s/<INST_UID>/$(TEMP_DB2_UID)/g" | $(CMD_SED) -e "s/<DAS_UID>/$(TEMP_DB2_DAS_UID)/g" | $(CMD_SED) -e "s/<FENC_UID>/$(TEMP_DB2_FENC_UID)/g" > $(DB2_RESPONSE_FILE) || { $(CMD_ECHO) ; \
		 "DB2 Response File (FAIL):#$(DB2_RESPONSE_FILE)" ; \
		exit 5; }
	@$(CMD_ECHO) "DB2 Response File (OK):  #$(DB2_RESPONSE_FILE)"
	@$(call func_chmod,644,$(DB2_RESPONSE_FILE))
	@$(CMD_ECHO)

################################################################################
# REMOVE THE DB2 INSTALLATION RESPONSE FILE
################################################################################
remove_db2_install_response_file:	check_commands
	@$(call func_print_caption,"REMOVING DB2 INSTALLATION RESPONSE FILE")
	@$(CMD_RM) -f $(DB2_RESPONSE_FILE)
	@$(CMD_ECHO)

################################################################################
# ENSURE DB2HOME EXISTS 
################################################################################
create_db2_home:
	@$(call func_print_caption,"Creating /db2/db2inst1")
	@if [ -d "$(DB2_HOME)" ] ; \
	then \
		$(CMD_ECHO) "DB2 HOME Exists? (FAIL):      -d $(DB2_HOME) # already exists" ; \
		exit 9; \
	else \
		$(CMD_ECHO) "DB2 HOME Exists? (OK):        -d $(DB2_HOME) # non-existent" ; \
		$(CMD_MKDIR) -p $(DB2_HOME);  \
		$(CMD_ECHO) "CREATING DB2_HOME" ; \
	fi ;
	@$(CMD_ECHO)


################################################################################
# INSTALL DB2 AS root
################################################################################
install_db2:						check_whoami \
									check_commands \
									create_temp_dir \
									prepare_db2_media \
									create_root_path \
									create_db2_install_response_file

	@$(call func_print_caption,"INSTALLING DB2 AS root")
	@if [ -d "$(PATH_INSTALL_DB2_VER)" ] ; \
	then \
		$(CMD_ECHO) "DB2 Exists? (FAIL):      -d $(PATH_INSTALL_DB2_VER) # already exists" ; \
		exit 6; \
	else \
		$(CMD_ECHO) "DB2 Exists? (OK):        -d $(PATH_INSTALL_DB2_VER) # non-existent" ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Setup Installation:" ; \
		$(PATH_REPOSITORY_INSTALL)/server_awse_o/db2setup -r $(DB2_RESPONSE_FILE) ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# VALIDATE DB2
################################################################################
validate_db2:						check_commands
	@$(call func_print_caption,"VALIDATING DB2")
	@$(CMD_ECHO)
	@$(PATH_INSTALL_DB2_VER)/bin/db2val
	@$(CMD_ECHO)

################################################################################
# CONFIGURE TCP Communications 
################################################################################
configure_tcp:

	@$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/bin/db2 update database manager configuration using svcename db2c_db2inst1"
	@$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/adm/db2stop"
	@$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/adm/db2start"


################################################################################
# CONFIGURE ITNM Database 
################################################################################
configure_itnm_db:

	@$(CMD_SU) - $(DB2_USER) -c ". $(DB2_PROFILE)"
	@$(CMD_SU) - $(DB2_USER) -c "$(PATH_REPOSITORY_INSTALL_SQL)/precision/scripts/sql/db2/create_db2_database.sh ITNM db2inst1"

################################################################################
# POPULATE ITNM Database 
################################################################################
populate_itnm_db:

	/usr/bin/cd "$(PATH_REPOSITORY_INSTALL_SQL)/precision/scripts/sql/db2" && $(CMD_SU) - $(DB2_USER) -c "$(PATH_REPOSITORY_INSTALL_SQL)/precision/scripts/sql/db2/populate_db2_database.sh ITNM db2inst1 db2inst1"

################################################################################
# CONFIGURE DB2 TO AUTOSTART
################################################################################
autostarton_db2:					check_whoami \
									check_commands
	@$(call func_print_caption,"CONFIGURING DB2 TO AUTOMATICALLY START")
	@$(CMD_ECHO)
	@$(CMD_ECHO) "Enabling the Fault Monitor Coordinator..."
	@$(PATH_INSTALL_DB2_VER)/bin/db2fmcu -u -p $(PATH_INSTALL_DB2_VER)/bin/db2fmcd
	@$(CMD_ECHO)
	@$(CMD_ECHO) "Starting the Fault Monitor Daemon..."
	@$(PATH_INSTALL_DB2_VER)/bin/db2fm -i $(DB2_USER) -U
	@$(CMD_ECHO)
	@$(CMD_ECHO) "Starting the Fault Monitor Service..."
	-@$(PATH_INSTALL_DB2_VER)/bin/db2fm -i $(DB2_USER) -u
	@$(CMD_ECHO)
	@$(CMD_ECHO) "Turning on the Fault Monitor for $(DB2_USER) Instance..."
	@$(PATH_INSTALL_DB2_VER)/bin/db2fm -i $(DB2_USER) -f on
	@$(CMD_ECHO)
	@$(CMD_ECHO) "DB2 Configuring Auto-Start (ON) and Fault Monitor Facility..."
	@$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/bin/db2iauto -on $(DB2_USER)"
	@$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/adm/db2set DB2AUTOSTART=YES"
	@$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/adm/db2set AUTOSTART=YES"
	@$(CMD_ECHO)
	@$(CMD_GREP) " 6" /etc/redhat-release 1> /dev/null; rc=$$? ; \
	if [ $$rc -eq 0 ] ; \
	then \
		$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 6 / Not systemd" ; \
	else \
		$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 7+ / systemd" ; \
		$(CMD_ECHO) "$$DB2_SYSTEMD_FILE_CONTENT" > $(DB2_SYSTEMD_FILE) || { $(CMD_ECHO) ; \
			"systemd Config (FAIL):   #$(DB2_SYSTEMD_FILE)" ; \
			exit 8; } ; \
		$(CMD_ECHO) "systemd Config (OK):     #$(DB2_SYSTEMD_FILE)" ; \
		\
		$(CMD_SYSTEMCTL) enable db2fmcd || { $(CMD_ECHO) ; \
			"systemd Enable (FAIL):   $(CMD_SYSTEMCTL) enable db2fmcd" ; \
			exit 9; } ; \
		$(CMD_ECHO) "systemd Enable (OK):     $(CMD_SYSTEMCTL) enable db2fmcd" ; \
		\
		$(CMD_SYSTEMCTL) start db2fmcd || { $(CMD_ECHO) ; \
			"systemd Start (FAIL):    $(CMD_SYSTEMCTL) start db2fmcd" ; \
			exit 10; } ; \
		$(CMD_ECHO) "systemd Start (OK):      $(CMD_SYSTEMCTL) start db2fmcd" ; \
	fi
	@$(CMD_ECHO)

################################################################################
# CONFIGURE DB2 TO NOT AUTOSTART
################################################################################
autostartoff_db2:					check_whoami \
									check_commands
	@$(call func_print_caption,"CONFIGURING DB2 TO NOT AUTOMATICALLY START")
	@if [ -d "$(PATH_INSTALL_DB2_VER)" ] ; \
	then \
		$(CMD_ECHO) "DB2 Exists? (OK):        -d $(PATH_INSTALL_DB2_VER) # exists" ; \
		$(CMD_GREP) " 6" /etc/redhat-release 1> /dev/null; rc=$$? ; \
		if [ $$rc -eq 0 ] ; \
		then \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 6 / Not systemd" ; \
		else \
			$(CMD_ECHO) "systemd init Check:      $(CMD_GREP) \" 6\" /etc/redhat-release # Red Hat 7+ / systemd" ; \
			$(CMD_ECHO) "systemd Reload:          $(CMD_SYSTEMCTL) daemon-reload" ; \
			$(CMD_SYSTEMCTL) daemon-reload ; \
			\
			$(CMD_ECHO) "systemd Stop:            $(CMD_SYSTEMCTL) stop db2fmcd" ; \
			$(CMD_SYSTEMCTL) stop db2fmcd ; \
			\
			$(CMD_ECHO) "systemd Disable:         $(CMD_SYSTEMCTL) disable db2fmcd" ; \
			$(CMD_SYSTEMCTL) disable db2fmcd ; \
			\
			$(CMD_RM) -f $(DB2_SYSTEMD_FILE) || { $(CMD_ECHO) ; \
				"systemd Config (FAIL):   $(CMD_RM) -f $(DB2_SYSTEMD_FILE)" ; \
				exit 11; } ; \
			$(CMD_ECHO) "systemd Config (OK):     $(CMD_RM) -f $(DB2_SYSTEMD_FILE)" ; \
		fi ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Configuring Auto-Start (OFF) and Fault Monitor Facility..." ; \
		$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/bin/db2iauto -off $(DB2_USER)" ; \
		$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/adm/db2set DB2AUTOSTART=NO" ; \
		$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/adm/db2set AUTOSTART=NO" ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "Turning off the Fault Monitor for $(DB2_USER) Instance..." ; \
		$(PATH_INSTALL_DB2_VER)/bin/db2fm -i $(DB2_USER) -f off ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "Disabling the Fault Monitor Coordinator..." ; \
		$(PATH_INSTALL_DB2_VER)/bin/db2fmcu -d ; \
	else \
		$(CMD_ECHO) "DB2 Exists? (OK):        -d $(PATH_INSTALL_DB2_VER) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# UNINSTALL DB2
################################################################################
uninstall_db2:						check_whoami \
									check_commands
	@$(call func_print_caption,"UNINSTALLING DB2")
	@if [ -d "$(PATH_INSTALL_DB2_VER)" ] ; \
	then \
		$(CMD_ECHO) "DB2 Exists? (OK):        -d $(PATH_INSTALL_DB2_VER) # exists" ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Terminate:" ; \
		$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/bin/db2 terminate" ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Stop:" ; \
		$(CMD_SU) - $(DB2_USER) -c "$(DB2_HOME)/sqllib/adm/db2stop force" ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Administration Server (DAS) Stop:" ; \
		$(CMD_SU) - $(DB2_USER) -c "$(PATH_INSTALL_DB2_VER)/das/bin/db2admin stop" ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Drop Instance:" ; \
		$(PATH_INSTALL_DB2_VER)/instance/db2idrop $(DB2_USER) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Administration Server (DAS) Removal:" ; \
		$(PATH_INSTALL_DB2_VER)/instance/dasdrop db2admin ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Cleanup Global Registry of Non-Existing Instances & DASes:"  ; \
		$(PATH_INSTALL_DB2_VER)/bin/db2greg -clean ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Deinstallation:" ; \
		$(PATH_INSTALL_DB2_VER)/install/db2_deinstall -F TSAMP -a ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "Killing the Fault Monitor Daemon if necessary..." ; \
		$(CMD_PKILL) -9 db2fmcd ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "DB2 Removing Port from /etc/services..." ; \
		$(call func_remove_line_from_file,root,root,644,"^db2c_$(DB2_USER)	$(DB2_PORT)","/etc/services") ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "Removing DB2 Directory if no Remaining Versions..." ; \
		$(call func_rmdir_if_empty,$(PATH_INSTALL_DB2)) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) ; \
		$(CMD_ECHO) "Removing DB2 IBM Tivoli System Automation for Multiplatforms content..." ; \
		$(CMD_RM) -rf $(PATH_INSTALL)/tsamp ; \
	else \
		$(CMD_ECHO) "DB2 Exists? (OK):        -d $(PATH_INSTALL_DB2_VER) # non-existent" ; \
	fi ;
	@$(CMD_ECHO)

################################################################################
# REMOVING /TMP FILES AND DIRECTORIES CREATED BY VARIOUS MAKE COMMANDS
################################################################################
clean_tmp:							check_commands
	@$(call func_print_caption,"REMOVING /TMP FILES")
	@$(CMD_RM) -f /tmp/dascrt.log.* /tmp/db2chgpath.log.*
	@$(CMD_RM) -f /tmp/db2ckgpfs.log /tmp/db2cktsa.log 
	@$(CMD_RM) -f /tmp/db2cptsa.log.* /tmp/db2dascfg.trc
	@$(CMD_RM) -f /tmp/db2_deinstall.log.* /tmp/db2greg.trc.dump.*
	@$(CMD_RM) -f /tmp/db2ickts.log.*
	@$(CMD_RM) -f /tmp/db2idrop_local.log.* /tmp/db2idrop.log.*
	@$(CMD_RM) -f /tmp/db2prereqcheck.* /tmp/db2setup.log
	@$(CMD_RM) -f /tmp/db2trc.trc.* /tmp/db2val-*.log
	@$(CMD_RM) -f /tmp/installSAM.*.log
	@$(CMD_ECHO)
	@$(call func_print_caption,"REMOVING /TMP DIRECTORIES")
	@$(CMD_RM) -rf /tmp/db2_deinstall_*
	@$(CMD_ECHO)

