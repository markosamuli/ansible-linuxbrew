FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    python-minimal \
    python-pip \
 && rm -rf /var/lib/apt/lists/*

ARG ansible_version="<2.9.0"
ENV ANSIBLE_VERSION="${ansible_version}"
RUN pip install ansible${ANSIBLE_VERSION}

RUN apt-get update && apt-get install -y \
    zsh \
    sudo \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    aptitude \
 && rm -rf /var/lib/apt/lists/*

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
