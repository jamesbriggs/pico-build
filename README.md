# pico-build
``pico-build`` is the world's smallest, yet featureful, three-environment (dev, stage and prod) build and deploy system.

It is intended for individual programmers and small teams who want to test and deploy to three environments, but don't want to spend time setting up (and patching) Jenkins or building a CI/CD pipeline.

## Concepts

``pico-build`` is a ``Makefile`` of only about 10 lines that:

- is a command-line tool that does input validation on the deploy environment choice
- updates the `dev/` folder using your version control system.
- exports your tested version in `dev/` to `stage/` and `prod/` folders
- can be setup in a minute or two.
- for more information about ``make``, see the [make homepage](https://www.gnu.org/software/make/)

## Typical Deploy Folder Structure for Web Server Projects

```
/var/
     www/ (parent folder)
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
usage: make [help|dev|stage|prod]
```

## Getting Started

1. choose a ``git``, ``cvs`` or ``svn`` repo and configure your environment to do a successful password-less `git pull` (or equivalent command)
2. cd to the directory which is the parent of your `dev/`, `stage/` and `prod/` folders
3. copy the ``Makefile`` to this directory and update it
4. run it for each environment:
```
make dev
# run your tests until they pass ... then ...
make stage
make prod
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
- less is more!

## Operations Teams

``pico-build`` is especially useful for Operations teams who work on master and often don't get around to setting up separate deploy environments for their own team, or who don't want to cut holes in firewalls (or peer across AWS VPC boundaries.)

It can also be used to develop and/or create secure deploy processes.

## FAQ

**Question:** Why is the name ``pico-build``?

**Answer:** Originally I wanted to use nano-build, but [nano-os](https://github.com/nanosoft-net/nano-os) already has a build system.

---

**Question:** It's very small, but aren't you cheating by using the ``make`` program?

**Answer:** Yes. Yes I am. Shamelessly.

---

**Question:** In fact, ``pico-build`` is so small, how can you justify creating a Github project based on a 10-line ``Makefile``?

**Answer:** Although the ``Makefile`` is very short, ``pico-build`` delivers on what it promises. A previous version in ``bash`` took about a week to design and much more code to get the same result.

---

**Question:** Can ``pico-build`` be run by ``cron``?

**Answer:** Yes, but you'll need to do 2 things:
1. ensure ``make`` and ``cron`` can still read your version control credentials and ``PATH`` can find ``make``, ``mkdir``, ``cp``, and ``git``.
2. and quiet or redirect output to a file to reduce the ``cron`` email notifications.

---

**Question:** How does the ``pico-build`` ``Makefile`` work?

**Answer:** ``pico-build`` uses basic ``make`` functionality:
1. ``help``, ``dev``, ``stage`` and ``prod`` are ``make`` targets, or actions. When you say `make dev`, ``dev`` is the target rule and ``$@`` is assigned 'dev'.
2. `DEBUG` toggles `$(DISP)` to @ or blank to control ``make``'s display of command execution.

---

**Question:** I'm new to version control but I want to use ``pico-build``. Which version control program should I use?

**Answer:** You should use whatever version control program your company or friends use. Github uses ``git``. Otherwise, ``svn`` is my favorite and is the easiest to learn because of its clear command structure.

---

**Question:** How can I ask ``pico-build`` to check for changes in `dev/` before doing pointless ``stage`` and ``prod`` deploys?

**Answer:** As with any ``Makefile``, remove ``dev`` from the `.PHONY` list, and add a filename that changes just after the `dev:` target (on the same line.)

---

**Question:** I copypasta'ed your ``Makefile`` and it doesn't seem to work for me. Why?

**Answer:** ``make`` requires tab characters before ``bash`` commands, so check if you accidently converted the tabs to spaces. (``vim`` will helpfully show red lines if you do that.)

---

**Question:** Is there commercial support available for ``pico-build``?

**Answer:** Yes, please contact the author for paid Devops design and/or support via the [blog contact form.](http://www.jebriggs.com/contact.html)

## License

MIT License

