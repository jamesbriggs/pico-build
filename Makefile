# #!/usr/bin/make -f
#
# Program: pico-build Makefile
# Purpose: all's smallest but featureful three-environment build and deploy system for dev, stage and prod
# Copyright: James Briggs, USA 2018
# Environment: make
# Usage: make [help|check|dev|stage|prod|dist|all]
# License: MIT License
# Notes:
# - dev is your version control HEAD or master branch repo, and stage and prod get file exports. git and svn are supported.
# - in a Makefile, column 1 is for make commands. For bash shell commands, tab over at least once.
# - Multi-line shell commands must have semi-colons and ending backslashes and $ is $$
# - for an advanced Makefile sample, see https://github.com/nanosoft-net/nano-os/blob/master/build/make/generic_makefile

### start of user-defined  configuration settings

# change from 'help' to 'all' (without quotes) if you want `make' by default to do a logical `deploy all' (not recommended)
.DEFAULT_GOAL:=help

# change to 'yes' or 'no' (without quotes) for debugging display information
DEBUG:=yes

### end of user-defined  configuration settings

DISP=@
ifeq ($(DEBUG), yes)
   DISP=
endif

# these make targets are not actually files:
.PHONY: all check dev dist help prod stage

help:
	@echo "usage: $(MAKE) [help|check|dev|stage|prod|dist|all]"

all: dev stage prod dist
	@echo "notice: this make target can run several other targets sequentially. stage and prod are adequate."

check:
	@echo "notice: checking your setup. check is intended to be used right after your initial clone, not per deploy."
	@cd dev || echo "error: dev/ not found. are we in the build home directory? if so, is there an initial repo clone?" \
		&& exit 1
	@which tar
	@which git
	$(DISP)git -C dev pull && exit 1
	$(DISP)git -C dev rev-parse HEAD > dev/.current_version
	cat dev/.current_version

dev:
	$(DISP)git -C dev pull && exit
	$(DISP)git -C dev rev-parse HEAD > dev/.current_version
	@echo "notice: add your chown and test suite commands here for the dev environment"
	@echo "notice: add your cp, sed, chown and chmod commands here to customize stage and prod environments"
	@echo "notice: reload/restart your dev server(s) here if needed"

stage prod:
	$(DISP)mkdir -p $@
	$(DISP)cmp -s dev/.current_version $@/.current_version || exit 1
	$(DISP)(cd dev; git archive master | tar -x -C ../$@ && exit)
	$(DISP)cp -p dev/.current_version $@
	$(DISP)cp -p $@/config/$@.conf $@/config.conf && exit
	@echo "notice: add your cp, sed, chown and chmod commands here to customize stage and prod environments"
	@echo "notice: reload/restart your server(s) for the current target action (stage or prod) here if needed"

dist:
	@echo "notice: add your rsync or bittorrent command(s) here for multi-server deployments if needed"

