# pico-build
pico-build is the world's smallest, featureful three-environment build and deploy system intended for individuals and small teams.

## Concepts

pico-build is a Makefile of only about 10 lines that:

- is a command-line tool that does input validation on the deploy environment choice
- updates the dev/ folder using your version control system
- exports your tested version to stage/ and prod/ folders
- can be setup in a minute or two.

## Typical Deploy Folder Structure

```
dev/
stage/
prod/
```

## Usage

```
usage: make [help|dev|stage|prod]
```
