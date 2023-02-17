# ansible-linuxbrew

[![Ansible Quality Score](https://img.shields.io/ansible/quality/42044.svg)](https://galaxy.ansible.com/markosamuli/linuxbrew)
[![Ansible Role](https://img.shields.io/ansible/role/42044.svg)](https://galaxy.ansible.com/markosamuli/linuxbrew)
[![GitHub release](https://img.shields.io/github/release/markosamuli/ansible-linuxbrew.svg)](https://github.com/markosamuli/ansible-linuxbrew/releases)
[![License](https://img.shields.io/github/license/markosamuli/ansible-linuxbrew.svg)](https://github.com/markosamuli/ansible-linuxbrew/blob/master/LICENSE)

Ansible role to install [Linuxbrew](http://linuxbrew.sh/) on Ubuntu.

I'm not actively using or maintaining this role. The role used Travis CI for
testing and publishing the releases, but since June 15th, 2021, the building
on [travis-ci.org](https://www.travis-ci.org/) is ceased and I have stopped
using Travis CI on my OSS projects.

## Configuration

By default, the role uses Ansible to clone the Homebrew Git repository and
create all relevant directories.

To use the official [Homebrew installer][homebrew-installer] script instead,
you need to enable this in the Ansible configuration:

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

- [BSD License](LICENSE)

## Contributions

The installation is based on the official [Homebrew installer][homebrew-installer]
script.

[homebrew-installer]: https://github.com/Linuxbrew/install

## Author Information

- [@markosamuli](https://github.com/markosamuli)
