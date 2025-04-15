FROM rockylinux:8.9

# Update system and install basic tools:
# - git and git-lfs for version control operations,
# - sudo to allow non-root users to install additional tools,
# - dnf-plugins-core to enable the use of dnf config-manager (required for adding the Docker repository).
RUN dnf -y update && \
    dnf -y install git git-lfs sudo dnf-plugins-core && \
    dnf clean all && rm -rf /var/cache/dnf

# Add the official Docker CE repository using the CentOS repo URL.
# Then install Docker Community Edition version 26.1.3 along with its command-line tools,
# containerd, and additional plugins for buildx and compose.
RUN dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf -y install docker-ce-26.1.3 docker-ce-cli-26.1.3 containerd.io docker-buildx-plugin docker-compose-plugin && \
    dnf clean all && rm -rf /var/cache/dnf

# Create the "sudo" group (if not already present) and add the gitpod user with UID 33333.
# The gitpod user is configured with a home directory and /bin/bash as its shell.
RUN groupadd sudo && \
    useradd -l -u 33333 -G sudo -m -d /home/gitpod -s /bin/bash -p gitpod gitpod

# Switch to non-root user for subsequent operations.
USER gitpod