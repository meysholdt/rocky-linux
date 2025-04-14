FROM rockylinux:9.3.20231119

RUN dnf -y update && \
    dnf -y install git git-lfs sudo && \
    dnf clean all && \
    rm -rf /var/cache/dnf

RUN groupadd sudo && \
    useradd -l -u 33333 -G sudo -m -d /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod
