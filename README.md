# pico-build
``pico-build`` is the world's smallest, yet featureful, three-environment (dev, stage and prod) build and deploy system.

It is intended for individual programmers and small teams who want to test and deploy to three environments, but don't want to spend time setting up (and patching) Jenkins or building a CI/CD pipeline.

## Concepts

``pico-build`` is a ``Makefile`` of only about 10 executable lines that:

- is a command-line tool that does input validation on the deploy environment choice
- updates the `dev/` folder using your version control system
- exports your tested version in `dev/` to `stage/` and `prod/` folders
- has a dist target for multi-server deploys using rsync or bittorrent
- can be setup in a minute or two.
- for more information about ``make``, see the [make homepage](https://www.gnu.org/software/make/)

## Advanced Concepts

Normally, most ``make`` dependencies are file timestamps. However, the ``pico-build`` ``Makefile`` does not use timestamps,
only phony targets and the repo version. Thus ``make`` is used like a Lisp or Prolog rules engine. The bash ``exit`` command is used to stop early, kind of like tail recursion optimization.

``pico-build`` is a locally-centric build system, but that's often not a limitation since it can fetch from remote version control systems, and deploy to remote clusters as needed.

## Typical Deploy Folder Structure for Web Server Projects

```
/var/
     www/ (build home)
         dev/
             html/
             cgi-bin/
             config/ (configs start here and are copied to stage/ and prod/ during deploys)
         stage/
             html/
             cgi-bin/
         prod/
             html/
             cgi-bin/
```

By running ``pico-build`` using ``sudo`` or ``root``, ``pico-build`` can be used to secure your web server file ownership and permissions.

## Usage

```
usage: make [help|check|dev|stage|prod|dist|all]
```

## Getting Started

1. choose your ``git`` or ``svn`` repo and configure your login environment to do a successful password-less `git pull` (or equivalent command) from the terminal
2. add .current_version to your .gitignore file and commit .gitignore
3. ``cd`` to your build home directory which is the parent of your `dev/`, `stage/` and `prod/` folders and do an initial `git clone` to the ``dev`` folder
4. ``cp`` the ``pico-build`` ``Makefile`` to the home directory and configure as needed. Change the permissions on ``Makefile``so that unauthorized users cannot modify it, usually with `chown root:root Makefile; chmod 644 Makefile`
5. do `make check` to do an initial test of your configuration
6. run ``make`` for each environment:
```
make dev
# run your tests until they pass ... then ...
make stage
make prod
# for multi-server deployments, you can use rsync or bittorrent ...
make dist
```

After you have tested the above, you can optionally run all deploy steps sequentially with this command (not recommended unless you have great tests):
```
make all
```

## Advantages

``pico-build`` has several advantages over Jenkins:

- the easiest way to get started learning about three-environment builds
- no waiting for your deploy job in a central build queue
- can itself be committed to version control
- secure
- no additional RAM or disk space required
- can be distributed widely to clusters or end-users
- requires no licensing or support (if you do need commercial support, see the FAQ below)
- portable - runs on all commonly-used operating systems
- many release engineers and QA staff are already familiar with ``make``
- less is more!

## Operations Teams

``pico-build`` is especially useful for Operations teams who work on ``master`` or ``HEAD`` branches and often don't get around to setting up deploy environments for their own team, or who don't want to cut holes in firewalls (or peer across AWS VPC boundaries.)

It can also be used to develop and/or create secure deploy processes.

## Supported Environments

``pico-build`` will work on any operating system that supports ``make``. It has been tested on CentOS/Redhat and Mac OS X which both use ``GNU make``. It will probably work on Windows under Cygwin or [Microsoft Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

To install ``make`` on CentOS or Redhat, type ``sudo yum install make``.

## FAQ

**Question:** Why is the name ``pico-build``?

**Answer:** Originally I wanted to use nano-build, but [nano-os](https://github.com/nanosoft-net/nano-os) already has a build system.

---

**Question:** It's very small, but aren't you cheating by using the ``make`` program?

**Answer:** Yes. Yes I am. Shamelessly.

---

**Question:** In fact, ``pico-build`` is so small, how can you justify creating a Github project based on a 10-line ``Makefile``?

**Answer:** Although the ``Makefile`` is very short, ``pico-build`` delivers on what it promises. A previous version in ``bash`` took about a week to design and test, and required much more code to get the same result.

---

**Question:** Can ``cron`` run ``pico-build``?

**Answer:** Yes, but you'll need to do this:
1. ensure ``make`` and ``cron`` can still read your version control credentials and the path setting, like``PATH=/bin:/usr/bin``, and can find ``make``, ``git`` and ``tar``.
2. quiet or redirect output to a file to reduce the ``cron`` email notifications
3. either set the cwd or do `make -f /path/to/the/pico-build/Makefile action`.

---

**Question:** How does the ``pico-build`` ``Makefile`` work?

**Answer:** ``pico-build`` uses basic ``make`` functionality:
1. ``help``, ``check``, ``dev``, ``stage``, ``prod``, ``dist`` and ``all`` are ``make`` targets, or actions. When you say `make dev`, ``dev`` is the target rule and ``$@`` is assigned 'dev'.
2. `DEBUG` toggles `$(DISP)` to @ or blank to control ``make``'s display of command execution.
3. You can do ``make -n``, which is the dry-run mode, to see what commands that ``make`` would execute.

---

**Question:** I'm new to version control but I want to use ``pico-build``. Which version control program should I use?

**Answer:** You should use whatever version control program that your company or friends use. Github uses ``git``. Otherwise, ``svn`` is my favorite and is the easiest to learn because of its clear command structure.

---

**Question:** Does ``pico-build`` check for changes in `dev/` before doing pointless ``stage`` and ``prod`` deploys?

**Answer:** Yes, this is handled by comparing the content of dev/.current_version against the same filename in stage/ or prod/.

---

**Question:** I copypasta'ed your ``Makefile`` and it doesn't seem to work for me. Why?

**Answer:** ``make`` requires tab characters before ``bash`` commands, so check if you accidently converted the tabs to spaces. (``vim`` will helpfully show red lines if you do that.) Otherwise run with make -n for a dry run.

---

**Question:** Is there commercial support available for ``pico-build``?

**Answer:** Yes, please contact the author for paid Devops design and/or support via the [blog contact form.](http://www.jebriggs.com/contact.html)

## Copyright

Copyright James Briggs, USA 2018

## License

MIT License

