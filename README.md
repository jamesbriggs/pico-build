# pico-build
pico-build is the world's smallest, featureful three-environment build and deploy system.

It is intended for individual programmers and small teams who want to test and deploy to three environments, but don't want to spend time setting up Jenkins or building a CI/CD pipeline yet.

## Concepts

pico-build is a Makefile of only about 10 lines that:

- is a command-line tool that does input validation on the deploy environment choice
- updates the `dev/` folder using your version control system.
- exports your tested version in `dev/` to `stage/` and `prod/` folders
- can be setup in a minute or two.

## Typical Deploy Folder Structure for Web Server Projects

```
/var/
     www/
         dev/
             html/
             cgi-bin/
             config/
         stage/
             html/
             cgi-bin/
         prod/
             html/
             cgi-bin/
```

By running pico-build using sudo or root, pico-build can be used to secure your web server file ownership and permissions.

## Usage

```
usage: make [help|dev|stage|prod]
```

## Getting Started

1. choose a git, cvs or svn repo and configure your environment to do a successful password-less `git pull` (or equivalent command)
2. cd to the directory which is the parent of your `dev/`, `stage/` and `prod/` folders
3. copy the Makefile to this directory and update it
4. run it for each environment:
```
make dev
make stage
make prod
```

## Advantages

pico-build has several advantages:

- easiest way to get started learning about three-environment builds
- no waiting on a central build queue
- can be committed to version control
- secure
- no additional computer resources required
- can be distributed to end-users
- requires no licensing or support
- less is more!

## Operations Teams

pico-build is especially useful for Operations teams who work on master and often don't get around to setting up separate deploy environments for their own team, or who don't want to cut holes in firewalls (or peer across AWS VPC boundaries.)

It can also be used to develop and/or create secure deploy processes.

## FAQ

Question: Why is the name pico-build?

Answer: Originally I wanted to use nano-build, but [nano-os](https://github.com/nanosoft-net/nano-os) already has a build system.


Question: It's very small, but aren't you cheating by using the make program?

Answer: Yes. Yes I am. Shamelessly.


Question: In fact, pico-build is so small, how can you justify creating a Github project based on a 10-line Makefile?

Answer: Although the Makefile is very short, pico-build delivers on what it promises. A previous version in bash took about a week to design and much more code to get the same result.


Question: Can pico-build be run by cron?

Answer: Yes, but you'll need to do things: ensure make can still read your version control credentials, and quiet or redirect output to a file to reduce the cron email notifications.


Question: How does the Makefile work?

Answer: help, dev, stage and work are targets, or actions. When you say `make dev`, dev is the target rule and $@ is assigned 'dev'. DEBUG toggles $(DISP) to @ or blank to control make's display of command execution.


Question: How can I ask pico-build to check for changes in dev/ before doing pointless stage and prod deploys?

Answer: As with any Makefile, remove dev from the .PHONY list, and add a filename that changes just after dev: (on the same line.)


Question: I copypasta'ed your Makefile and now it doesn't work. Why?

Answer: make requires tab characters before bash commands, so check if you accidently converted those to spaces. (vim will helpfully show red lines if you do that.)

## License

MIT License

