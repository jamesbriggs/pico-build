# pico-build
pico-build is the world's smallest, featureful three-environment build and deploy system intended for individuals and small teams who want to test and deploy to three environments, but don't want to spend time setting up Jenkins or building a CI/CD pipeline yet.

It is especially useful for Operations teams who work on master and often don't get around to setting up separate environments for themselves.

## Concepts

pico-build is a Makefile of only about 10 lines that:

- is a command-line tool that does input validation on the deploy environment choice
- updates the dev/ folder using your version control system.
- exports your tested version in dev/ to stage/ and prod/ folders
- can be setup in a minute or two.

## Typical Deploy Folder Structure

```
/var/www/
      dev/
      stage/
      prod/
```

## Usage

```
usage: make [help|dev|stage|prod]
```

## Getting Started

1. pick a repo and configure your environment to do git pull or equivalent
2. cd to the directory which is the parent of your dev/, stage/ and prod/ folders
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
- no queuing of your build requests
- can be committed to version control
- secure
- no additional resources required
- can be distributed to end-users
- requires no licensing or support.
- less is more!

## License

MIT License
