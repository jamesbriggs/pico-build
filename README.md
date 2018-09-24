# pico-build
pico-build is the world's smallest, featureful three-environment build and deploy system.

It is intended for individuals and small teams who want to test and deploy to three environments, but don't want to spend time setting up Jenkins or building a CI/CD pipeline yet.

pico-build is especially useful for Operations teams who work on master and often don't get around to setting up separate deploy environments for themselves, or who don't want to cut holes in firewalls (or peer across AWS VPC boundaries.)

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
             config/
         stage/
         prod/
```

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

## FAQ

Question: Why is the name pico-build?
Answer: Because nano-build was already taken by the nano-os project.

Question: It's very small, but aren't you cheating by using the make program?
Answer: Yes. Yes I am. Shamelessly.

Question: In fact, pico-build is so small, how can you justify creating a Github project based on a 10-line Makefile?
Answer: Although the Makefile is very short, pico-build delivers on what it promises. A previous version in bash took about a week to design and much more code to get the same result.

## License

MIT License
