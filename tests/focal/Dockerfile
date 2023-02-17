FROM ubuntu:focal

RUN apt-get update && apt-get install -y \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Use a maintained UK-based mirror with HTTPS support
ARG ubuntu_archive=https://mirror.pulsant.com/sites/ubuntu-archive/
RUN sed -i "s~http://archive.ubuntu.com/ubuntu/~${ubuntu_archive}~g" /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
  zsh \
  sudo \
  python3-minimal \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

ARG ansible_version=">=2.9.22"
ENV ANSIBLE_VERSION="${ansible_version}"
RUN pip install ansible${ANSIBLE_VERSION}

ARG user=test
ARG repository=ansible-linuxbrew

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

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
