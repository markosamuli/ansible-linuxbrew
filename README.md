# ansible-linuxbrew

[![Ansible Quality Score](https://img.shields.io/ansible/quality/42044.svg)](https://galaxy.ansible.com/markosamuli/linuxbrew)
[![Ansible Role](https://img.shields.io/ansible/role/42044.svg)](https://galaxy.ansible.com/markosamuli/linuxbrew)
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

## Role Variables

Set `linuxbrew_init_shell` to `false` if you're for example managing your shell
rc files using your own .dotfiles repository.

```yaml
# Configure shell rc files
linuxbrew_init_shell: true
```

## Coding style

Install pre-commit hooks and validate coding style:

```bash
make lint
```

## Run tests

Run tests in Ubuntu and Debian using Docker:

```bash
make test
```

## License

* [BSD License](LICENSE)

## Contributions

The installation is based on the official [Homebrew installer] script.

[Homebrew installer]: https://github.com/Linuxbrew/install

## Author Information

* [@markosamuli](https://github.com/markosamuli)
