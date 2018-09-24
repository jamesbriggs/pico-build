# Program: pico-build Makefile
# Purpose: all's smallest but featureful three-environment build and deploy system for dev, stage and prod
# Copyright: James Briggs, USA 2018
# Environment: make
# Usage: make [help|check|dev|stage|prod|dist|all]
# License: MIT License
# Notes:
# - dev is your version control HEAD or master branch repo, and stage and prod get file exports. git and svn are supported.
# - in a Makefile, column 1 is for make commands. For bash shell commands, tab over at least once.
# - Multi-line shell commands must have semi-colons and ending backslashes
# - for an advanced Makefile sample, see https://github.com/nanosoft-net/nano-os/blob/master/build/make/generic_makefile

### start of user-defined  configuration settings

# change from all to help if you want to enforce a more deliberate usage than 'deploy all'
.DEFAULT_GOAL:=all

# change to yes or no for debugging display information
DEBUG:=yes

### end of user-defined  configuration settings

DISP=@
ifeq ($(DEBUG), yes)
   DISP=
endif

# these make targets are not actually files:
.PHONY: all check dev dist help prod stage

all: dev stage prod dist
	@echo "notice: convenience make target to run several other targets sequentially"

check:
	@echo "notice: checking your pico-build setup ..."
	cd dev || echo "error: are you running make from the build home directory? if so, have you cloned your repo into dev/ ?"
	git -C dev rev-parse HEAD

help:
	@echo "usage: $(MAKE) [help|check|dev|stage|prod|dist|all]"

dev:
	$(DISP)git -C $@ pull && exit
	$(DISP)git -C $@ rev-parse HEAD > $@/.current_git_hash
	@echo "notice: add your chown and test suite commands here for the dev environment"
	@echo "notice: add your cp, sed, chown and chmod commands here to customize stage and prod environments"
	@echo "notice: reload/restart your dev server(s) here if needed"

stage prod:
	$(DISP)mkdir -p $@
	$(DISP)(cd dev; git archive master | tar -x -C ../$@ && exit)
	$(DISP)cp -p $@/config/$@.conf $@/config.conf && exit
	@echo "notice: add your cp, sed, chown and chmod commands here to customize stage and prod environments"
	@echo "notice: reload/restart your server(s) for the current target action (stage or prod) here if needed"

dist:
	@echo "notice: add your rsync or bittorrent command(s) here for multi-server deployments if needed"


