# Program: pico-build Makefile
# Purpose: world's smallest but featureful three-environment build and deploy system for dev, stage and prod
# Copyright: James Briggs, USA 2018
# Environment: make
# Usage: make [help|dev|stage|prod]
# License: MIT License
# Notes:
# - dev is your version control HEAD or master branch repo, and stage and prod are exported copies. git and svn are supported.
# - in a Makefile, column 1 is for make commands. For bash shell commands, tab over at least once.
# - Multi-line shell commands must have semi-colons and ending backslashes
# - for an advanced Makefile sample, see https://github.com/nanosoft-net/nano-os/blob/master/build/make/generic_makefile

# these make targets are not files:
.PHONY: help dev stage prod dist

DEBUG:=yes

DISP=@
ifeq ($(DEBUG), yes)
   DISP=
endif

help:
	@echo "usage: $(MAKE) [help|dev|stage|prod|dist]"

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
