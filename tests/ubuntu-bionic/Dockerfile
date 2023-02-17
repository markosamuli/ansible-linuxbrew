FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Use a maintained UK-based mirror with HTTPS support
ARG ubuntu_archive=https://mirror.pulsant.com/sites/ubuntu-archive/
RUN sed -i "s~http://archive.ubuntu.com/ubuntu/~${ubuntu_archive}~g" /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y \
  && rm -rf /var/lib/apt/lists/*

# Python 3.6.9
RUN apt-get update && apt-get install -y \
  zsh \
  sudo \
  python3-minimal \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

# Fixed in Python 3.7
# https://github.com/pypa/pip/issues/10219
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ARG user=test
ARG repository=markosamuli.linuxbrew

# Create test user
RUN useradd -m ${user} -s /bin/bash \
  && echo "${user}:${user}" | chpasswd \
  && adduser ${user} sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN touch /home/${user}/.zshrc \
  && chown -R ${user}:${user} /home/${user}

# Create directory for code
RUN mkdir -p /home/${user}/${repository} ; \
  chown -R ${user}:${user} /home/${user}/${repository}
VOLUME ["/home/${user}/${repository}"]

# Make sure we have the latest packages
RUN apt-get update

USER ${user}

# Upgrade pip to fix installation issues
RUN python3 -m pip install --upgrade pip

# Ansible will require Python 3.8 or newer on the controller starting
# with Ansible 2.12.
ARG ansible_version=">=2.9.22"
ENV ANSIBLE_VERSION="<2.12,${ansible_version}"
RUN python3 -m pip install ansible${ANSIBLE_VERSION}

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
