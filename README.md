# pico-build
pico-build is the world's smallest, featureful three-environment build and deploy system intended for individuals and small teams. It is especially useful for Operations teams who work on master.

## Concepts

pico-build is a Makefile of only about 10 lines that:

- is a command-line tool that does input validation on the deploy environment choice
- updates the dev/ folder using your version control system.
- exports your tested version in dev/ to stage/ and prod/ folders
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

## Getting Started

1. pick a repo and configure your environment to do git pull or equivalent
2. cd to the directory which is the parent of your dev/, stage/ and prod/ folders
3. copy the Makefile to this directory and update it
```
make dev
make stage
make prod
```

## License

MIT License
