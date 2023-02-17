# ansible-linuxbrew

[![Test and release](https://github.com/markosamuli/ansible-linuxbrew/actions/workflows/pipeline.yml/badge.svg?branch=master)](https://github.com/markosamuli/ansible-linuxbrew/actions/workflows/pipeline.yml)
[![Ansible Quality Score](https://img.shields.io/ansible/quality/42044.svg)](https://galaxy.ansible.com/markosamuli/linuxbrew)
[![Ansible Role](https://img.shields.io/ansible/role/42044.svg)](https://galaxy.ansible.com/markosamuli/linuxbrew)
[![GitHub release](https://img.shields.io/github/release/markosamuli/ansible-linuxbrew.svg)](https://github.com/markosamuli/ansible-linuxbrew/releases)
[![License](https://img.shields.io/github/license/markosamuli/ansible-linuxbrew.svg)](https://github.com/markosamuli/ansible-linuxbrew/blob/master/LICENSE)

Ansible role to install [Linuxbrew](http://linuxbrew.sh/) on Ubuntu.

## Compatibility

Run tests with a supported Docker image, for example with `bionic`:

```bash
make bionic
```

| Release          | Docker image                         | Ansible          |
| ---------------- | ------------------------------------ | ---------------- |
| Debian 10        | [`debian-buster`][debian-buster]     | `<2.12,>=2.9.22` |
| Debian 11        | [`debian-bullseye`][debian-bullseye] | `>=2.9.22`       |
| Fedora 37        | [`fedora-37`][fedora-37]             | `>=2.9.22`       |
| Ubuntu 18.04 LTS | [`ubuntu-bionic`][ubuntu-bionic]     | `<2.12,>=2.9.22` |
| Ubuntu 20.04 LTS | [`ubuntu-focal`][ubuntu-focal]       | `>=2.9.22`       |
| Ubuntu 22.04 LTS | [`ubuntu-jammy`][ubuntu-jammy]       | `>=2.9.22`       |

If you want to add a new distribution or release version, please create a
Docker image for it under the `tests/` directory and make sure the existing
tests work.

I'm developing this role currently in a black box using the Docker images
included in the repository and not running it on live environments.

[ubuntu-bionic]: tests/ubuntu-bionic/Dockerfile
[ubuntu-focal]: tests/ubuntu-focal/Dockerfile
[ubuntu-jammy]: tests/ubuntu-jammy/Dockerfile
[debian-buster]: tests/debian-buster/Dockerfile
[debian-bullseye]: tests/debian-bullseye/Dockerfile
[fedora-37]: tests/fedora-37/Dockerfile

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

## Contributing

I'm not actively using or maintaining this role, but welcome bug fixes and
support for missing operating systems.

## Contributions

The installation is based on the official [Homebrew installer][homebrew-installer]
script.

[homebrew-installer]: https://github.com/Linuxbrew/install

## Author information

- [@markosamuli](https://github.com/markosamuli)
