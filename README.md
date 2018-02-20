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

- Debian stable (stretch)
- Debian testing (buster)
- Raspbian stable (stretch)
- Ubuntu LTS (xenial)
- Ubuntu latest (artful)
- Alpine 3.7

Note: Taliesin for Ubuntu LTS is not supported, since Ubuntu Xenial doesn't have the libraries required.

# Usage

The make commands are similar for every project.

The commands available are:

```shell
$ make <project>_<target_architecture> # build one package for a spcecific architecture
$ make <project>_build                 # build packages for all supported architectures
$ make build_<target_architecture>     # build all projects for the specified architecture
$ make                                 # build all projects for all supported architectures
```

Examples:

```shell
$ make ulfius_debian_stable # build ulfius package and a bundle containing Ulfius, Orcania and Yder packages for Debian
$ make orcania_build        # build orcania packages for all supported architectures: Debian stable and testing, Ubuntu LTS and latest, amd Alpine 3.7
$ make build_ubuntu_latest  # build the following packages and bundles for Ubuntu Artful: Orcania, Yder, Ulfius, Hoel, Glewlwyd and Taliesin
```
