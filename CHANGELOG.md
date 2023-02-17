# Changelog

## [2.0.0] - 2023-02-17

### Ansible compatibility

- Require Ansible 2.9.22
- Support Ansible 7.2.0
- Use fully qualified collection names (FQCN) with builtin modules

### Fixes

- Use `become_user` instead of `become` when installing with Git by [@Hunsu] in [#6]
- Remove installer script checksum that causes issues [#10]

[@hunsu]: https://github.com/Hunsu
[#6]: https://github.com/markosamuli/ansible-linuxbrew/pull/6
[#10]: https://github.com/markosamuli/ansible-linuxbrew/issues/10

### Python compatibility

- Use Python 3 on all test Docker images
- Drop support for EOL Python 2.7

### OS compatibility

- Add support for Ubuntu 20.04 LTS and 22.04 LTS
- Add support for Debian 11
- Add support for Fedora 37 and RedHat based-systems by [@aarey] in [#9]
- Drop support for Debian 11
- Drop support for Ubuntu 16.04 LTS

[@aarey]: https://github.com/aairey
[#9]: https://github.com/markosamuli/ansible-linuxbrew/pull/9

### Testing

- Run tests with supported Docker images on GitHub Actions

## [1.2.2] - 2020-09-06

### Fixed

- Update `install.sh` checksum
- Create missing `var/homebrew/linked` directory
- Update `linuxbrew-core` repository URL

## [1.2.1] - 2020-09-05

### Fixed

- Migrate to the new `install.sh` script

## [1.2.0] - 2019-10-25

### Changes

- Add `linuxbrew_init_shell` variable to allow shell file modification to be
  disabled. Fixes [#1]

## [1.1.1] - 2019-07-20

### Fixes

- Updated `install.sh` checksum for the 2019-07-18 updated version.

## [1.1.0] - 2019-07-14

### Changes

- Use Ansible tasks to clone the Homebrew Git repositories, create directories
  and set permissions where possible instead of using the official installer
  bash script.

### Fixes

- Install installation dependencies.
- Update both `.bashrc` and `.zshrc` shell scripts.

## [1.0.0] - 2019-01-13

Initial release using the official Homebrew installer.

[1.2.2]: https://github.com/markosamuli/ansible-linuxbrew/releases/tag/v1.2.2
[1.2.1]: https://github.com/markosamuli/ansible-linuxbrew/releases/tag/v1.2.1
[1.2.0]: https://github.com/markosamuli/ansible-linuxbrew/releases/tag/v1.2.0
[1.1.1]: https://github.com/markosamuli/ansible-linuxbrew/releases/tag/v1.1.1
[1.1.0]: https://github.com/markosamuli/ansible-linuxbrew/releases/tag/v1.1.0
[1.0.0]: https://github.com/markosamuli/ansible-linuxbrew/releases/tag/v1.0.0
[#1]: https://github.com/markosamuli/ansible-linuxbrew/issues/1
