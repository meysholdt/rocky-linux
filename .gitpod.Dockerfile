FROM rockylinux/rockylinux:9.5

RUN dnf -y update && \
    dnf -y install git git-lfs sudo dnf-plugins-core && \
    dnf clean all && rm -rf /var/cache/dnf

RUN dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf -y install docker-ce-28.0.4 docker-ce-cli-28.0.4 containerd.io docker-buildx-plugin docker-compose-plugin && \
    dnf clean all && rm -rf /var/cache/dnf

RUN groupadd sudo && \
    useradd -l -u 33333 -G sudo -m -d /home/gitpod -s /bin/bash -p gitpod gitpod

# Switch to non-root user for subsequent operations.
USER gitpod
