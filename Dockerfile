FROM registry.fedoraproject.org/f33/fedora-toolbox:33

LABEL maintainer="Joakim Nohlgård <joakim@nohlgard.se>"

# Download and unpack CLion
#RUN curl -f -L -o /clion.tar.gz https://download.jetbrains.com/cpp/CLion-2020.3.tar.gz && \
#    echo 'ffc862511bf80debb80f9d60d2999b02e32b7c3cbb8ac25a4c0efc5b9850124f *clion.tar.gz' | sha256sum -c && \
#    tar zxvf clion.tar.gz -C /opt

# Locally downloaded CLion
ADD CLion-2020.3.tar.gz /opt/

# Add Amazon Corretto repo
RUN rpm --import https://yum.corretto.aws/corretto.key 
RUN curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo

# Add any packages for the dev environment to the my-dev-packages file
COPY my-dev-packages /
RUN dnf -y install $(</my-dev-packages)
RUN rm /my-dev-packages

# Manual override for vim
RUN dnf remove -y vim-minimal && dnf install -y vim-enhanced

RUN dnf clean all
