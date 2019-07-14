# ansible-linuxbrew

[![GitHub release](https://img.shields.io/github/release/markosamuli/ansible-linuxbrew.svg)](https://github.com/markosamuli/ansible-linuxbrew/releases)
[![License](https://img.shields.io/github/license/markosamuli/ansible-linuxbrew.svg)](https://github.com/markosamuli/ansible-linuxbrew/blob/master/LICENSE)

| Branch  | Status |
|---------|--------|
| master  | [![Build Status](https://travis-ci.org/markosamuli/ansible-linuxbrew.svg?branch=master)](https://travis-ci.org/markosamuli/ansible-linuxbrew)
| develop | [![Build Status](https://travis-ci.org/markosamuli/ansible-linuxbrew.svg?branch=develop)](https://travis-ci.org/markosamuli/ansible-linuxbrew)

Ansible role to install [Linuxbrew](http://linuxbrew.sh/) on Ubuntu.

## Configuration

By default, the role uses Ansible to clone the Homebrew Git repository and
create all relevant directories.

To use the official [Homebrew installer] script instead, you need to enable this
in the Ansible configuration:

```yaml
linuxbrew_use_installer: true
```

## License

* [BSD License](LICENSE)

## Contributions

The installation is based on the official [Homebrew installer] script.

[Homebrew installer]: https://github.com/Linuxbrew/install

## Author Information

* [@markosamuli](https://github.com/markosamuli)
