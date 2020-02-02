FROM opensuse/tumbleweed

# Install base packages
RUN zypper --non-interactive up &&\
    zypper install -y gcc \
    make \
    cmake \
    rpm-build \
    rpmdevtools \
    lsb-release \
    pkg-config \
    wget
