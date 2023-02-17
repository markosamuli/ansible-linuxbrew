FROM fedora:37

RUN dnf -y update && dnf clean all

# Python 3.11
RUN dnf -y install \
  zsh \
  sudo \
  python3 \
  python3-pip \
  && dnf clean all

ARG ansible_version=">=2.9.22"
ENV ANSIBLE_VERSION="${ansible_version}"
RUN pip install ansible${ANSIBLE_VERSION}

ARG user=test
ARG repository=ansible-linuxbrew

# Create test user
RUN useradd -m -s /bin/bash ${user} \
  && echo "${user}:${user}" | chpasswd \
  && usermod -aG wheel ${user} \
  && echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN touch /home/${user}/.zshrc \
  && chown -R ${user}:${user} /home/${user}

# Create directory for code
RUN mkdir -p /home/${user}/${repository} ; \
  chown -R ${user}:${user} /home/${user}/${repository}
VOLUME ["/home/${user}/${repository}"]

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
