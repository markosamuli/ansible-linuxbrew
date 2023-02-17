# ansible-linuxbrew

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

| Release          | Docker image           | Ansible          |
| ---------------- | ---------------------- | ---------------- |
| Ubuntu 18.04 LTS | [`bionic`][bionic]     | `<2.12,>=2.9.22` |
| Ubuntu 20.04 LTS | [`focal`][focal]       | `>=2.9.22`       |
| Ubuntu 22.04 LTS | [`jammy`][jammy]       | `>=2.9.22`       |
| Debian 10        | [`buster`][buster]     | `<2.12,>=2.9.22` |
| Debian 11        | [`bullseye`][bullseye] | `>=2.9.22`       |
| Fedora 37        | [`fedora37`][fedora37] | `>=2.9.22`       |

If you want to add a new distribution or release version, please create a
Docker image for it under the `tests/` directory and make sure the existing
tests work.

I'm developing this role currently in a black box using the Docker images
included in the repository and not running it on live environments.

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

## Contributing

I'm not actively using or maintaining this role, but welcome bug fixes and
support for missing operating systems.

## Contributions

The installation is based on the official [Homebrew installer][homebrew-installer]
script.

[homebrew-installer]: https://github.com/Linuxbrew/install

## Author information

- [@markosamuli](https://github.com/markosamuli)
