# Changelog

## [Unreased] - 2019-07-20

### Fixes

* Updated `install.sh` checksum for the 2019-07-18 updated version.

## [1.1.0] - 2019-07-14

### Changes

* Use Ansible tasks to clone the Homebrew Git repositories, create directories
  and set permissions where possible instead of using the official installer
  bash script.

### Fixes

* Install installation dependencies.
* Update both `.bashrc` and `.zshrc` shell scripts.

## [1.0.0] - 2019-01-13

Initial release using the official Homebrew installer.

[1.1.0]: https://github.com/markosamuli/ansible-linuxbrew/releases/tag/v1.1.0
[1.0.0]: https://github.com/markosamuli/ansible-linuxbrew/releases/tag/v1.0.0
