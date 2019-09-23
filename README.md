# Huddersfield

Package builder for the following projects:
- Orcania (https://github.com/babelouest/hoel)
- Yder (https://github.com/babelouest/yder)
- Ulfius (https://github.com/babelouest/ulfius)
- Hoel (https://github.com/babelouest/hoel)
- Glewlwyd (https://github.com/babelouest/glewlwyd)
- Taliesin (https://github.com/babelouest/taliesin)
- Hutch (https://github.com/babelouest/hutch)

Use to automatically build .deb and .tar.gz packages of those projects, and bundles for projects with dependencies.

Except for Raspbian packages which are built for `armv6l` processors (Raspberry PI), all the other packages are built for `x86_64` architectures.

Uses Docker and Makefile.

The following architectures are supported:

- Debian oldstable (stretch)
- Debian stable (buster)
- Debian testing (bullseye)
- Raspbian stable (buster)
- Ubuntu LTS (bionic)
- Ubuntu latest (disco)
- Alpine latest
- Fedora latest (available for orcania, yder, ulfius, hoel and glewlwyd)

# Usage

The make commands are similar for every project.

The commands available are:

```shell
$ make <project>-<target_architecture>       # build one package for a spcecific architecture
$ make <project>-build                       # build packages for all supported architectures
$ make <project>-<target_architecture>-test  # build packages and install them in the specified architecture, and run tests (available for orcania, yder, ulfius, hoel and glewlwyd)
$ make <project>-<target_architecture>-smoke # build packages and install them in the specified architecture, and run glewlwyd (available for glewlwyd)
$ make build-<target_architecture>           # build all projects for the specified architecture
$ make                                       # build all projects for all supported architectures
```

Examples:

```shell
$ make ulfius-debian-stable     # build ulfius package and a bundle containing Ulfius, Orcania and Yder packages for Debian
$ make orcania-build            # build orcania packages for all supported architectures: Debian stable and testing, Ubuntu LTS and latest, amd Alpine 3.7
$ make build-ubuntu-latest      # build the following packages and bundles for Ubuntu Artful: Orcania, Yder, Ulfius, Hoel, Glewlwyd and Taliesin
$ make glewlwyd-ubuntu-lts-test # build and run Glewlwyd's tests on an Ubuntu LTS
$ make glewlwyd-alpine-smoke    # build and run Glewlwyd on an Alpine image to make sure the whole build/install process works
```
