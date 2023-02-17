FROM debian:bullseye

RUN apt-get update && apt-get install -y \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Use HTTPS
RUN sed -i "s~http://~https://~g" /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
  zsh \
  sudo \
  python3-minimal \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

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

ARG ansible_version=">=2.9.22"
ENV ANSIBLE_VERSION="${ansible_version}"
RUN python3 -m pip install ansible${ANSIBLE_VERSION}

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
