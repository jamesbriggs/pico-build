#!/usr/bin/make -f
#
# Program: pico-build Makefile
# Purpose: all's smallest but featureful three-environment build and deploy system for dev, stage and prod
# Copyright: James Briggs, USA 2018
# Environment: make
# Usage: make [help|check|dev|stage|prod|dist|all]
# License: MIT License
# Download: wget https://raw.githubusercontent.com/jamesbriggs/pico-build/master/Makefile
# Notes:
# - dev is your version control HEAD or master branch repo, and stage and prod are file exports. git and svn are supported.
# - in a Makefile, column 1 is for make commands. For bash shell commands, tab over at least once.
# - multi-line shell commands must have semi-colons and ending backslashes and $ is $$
# - Each update command in a Makefile rule is executed in a separate shell unless you use GNU make's .ONESHELL
#   feature. See https://www.gnu.org/software/make/manual/html_node/One-Shell.html
# - for an advanced Makefile sample, see https://github.com/nanosoft-net/nano-os/blob/master/build/make/generic_makefile

### start of user-defined configuration settings

# change from 'help' to 'all' (without quotes) if you want `make' by default to do a logical `deploy all' (not recommended)
.DEFAULT_GOAL:=help
.PRECIOUS:=

# change to 'yes' or 'no' (without quotes) for debugging display information
DEBUG:=yes

# change to your version control product name, either 'git' or 'svn' (without quotes)
VC_PRODUCT:=git

### end of user-defined configuration settings

VC_VERSION_FILE=.current_version

ifeq ($(VC_PRODUCT), git)
   VC_LOCAL_VERSION_CMD      = git -C dev rev-parse HEAD
   VC_PULL_CMD               = git -C dev pull
   VC_LOCAL_EXPORT_FILES_CMD = git archive master
else
   VC_LOCAL_VERSION_CMD      = svnversion -n
   VC_PULL_CMD               = svn up
   VC_LOCAL_EXPORT_FILES_CMD = svn export dev
endif

DISP=@
ifeq ($(DEBUG), yes)
   DISP=
endif

# these make targets are not to be considered as filenames:
.PHONY: all check dev dist help prod stage

help: ; @echo "usage: $(MAKE) [help|check|dev|stage|prod|dist|all]"

all: dev stage prod dist
	echo "notice: this make target can run several other targets sequentially. stage and prod are adequate."

check:
	@echo "notice: checking your setup. check is intended to be used right after your initial clone, not per deploy."
	@cd dev || { echo "error: dev/ not found. is this the build home directory? if so, is there an initial repo clone?"; \
		exit 1; }
	@which tar
	@which git
	$(DISP)$(VC_PULL_CMD)
	$(DISP)$(VC_LOCAL_VERSION_CMD) > dev/$(VC_VERSION_FILE)
	cat dev/$(VC_VERSION_FILE)

dev:
	$(DISP)$(VC_PULL_CMD)
	$(DISP)$(VC_LOCAL_VERSION_CMD) > dev/$(VC_VERSION_FILE)
	@echo "notice: add your chown and test suite commands here for the dev environment"
	@echo "notice: add your cp, sed, chown and chmod commands here to customize stage and prod environments"
	@echo "notice: reload/restart your dev server(s) here if needed"

stage prod:
	$(DISP)mkdir -p $@
	$(DISP)cmp -s dev/$(VC_VERSION_FILE) $@/$(VC_VERSION_FILE) && exit 2 # if the versions are the same, then stop
	if [[ "$(VC_PRODUCT)" == "git" ]]; then \
		$(DISP)(cd dev; $(VC_LOCAL_EXPORT_FILES_CMD) | tar -x -C ../$@); \
	else \
		$(DISP)$(VC_LOCAL_EXPORT_FILES_CMD) $@; \
	fi
	$(DISP)cp -p dev/$(VC_VERSION_FILE) $@
	$(DISP)cp -p $@/config/$@.conf $@/config.conf
	@echo "notice: add your cp, sed, chown and chmod commands here to customize stage and prod environments"
	@echo "notice: reload/restart your server(s) for the current target action (stage or prod) here if needed"

dist:
	@echo "notice: add your rsync or bittorrent command(s) here for multi-server deployments if needed"

