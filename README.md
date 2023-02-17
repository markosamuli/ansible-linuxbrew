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

I've tested the role up to Ansible 2.8 using local installation.

## Compatibility

Run tests with a supported Docker image, for example with `bionic`:

```bash
make bionic
```

| Release          | Docker image           | Ansible          |
| ---------------- | ---------------------- | ---------------- |
| Ubuntu 18.04 LTS | [`bionic`][bionic]     | `<2.12,>=2.9.22` |
| Ubuntu 20.04 LTS | [`focal`][focal]       | `>=2.9.22`       |
| Ubuntu 22.04 LTS | [`jammy`][jammy]       | `>=2.9.22`       |
| Debian 10        | [`buster`][buster]     | `<2.12,>=2.9.22` |
| Debian 11        | [`bullseye`][bullseye] | `>=2.9.22`       |
| Fedora 37        | [`fedora37`][fedora37] | `>=2.9.22`       |

[bionic]: tests/bionic/Dockerfile
[focal]: tests/focal/Dockerfile
[jammy]: tests/jammy/Dockerfile
[buster]: tests/buster/Dockerfile
[bullseye]: tests/buster/Dockerfile
[fedora37]: tests/fedora37/Dockerfile

## Configuration

By default, the role uses Ansible to clone the Homebrew Git repository and
create all relevant directories.

To use the official [Homebrew installer][homebrew-installer] script instead,
you need to enable this in the Ansible configuration:

```yaml
linuxbrew_use_installer: true
```

The installer seems to be faster than the default Ansible installation method.

## Role Variables

Set `linuxbrew_init_shell` to `false` if you're for example managing your shell
init files using your own `.dotfiles` repository.

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
