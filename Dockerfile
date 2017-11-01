FROM fedora:25

RUN curl -Lk -o /etc/yum.repos.d/rcm-tools-fedora.repo  http://download.devel.redhat.com/rel-eng/RCMTOOLS/rcm-tools-fedora.repo 

RUN dnf update -y && dnf install sudo -y && dnf install ansible -y && dnf install python2-simplejson -y && dnf install python2-lxml -y && dnf install npm -y && dnf install krb5-workstation -y && dnf install rhpkg -y && dnf clean all -y

ADD ./krb5.conf /etc/

RUN curl -Lk https://password.corp.redhat.com/cacert.crt -o /etc/pki/ca-trust/source/anchors/Red_Hat_IS_CA.crt && curl -Lk https://password.corp.redhat.com/RH-IT-Root-CA.crt -o /etc/pki/ca-trust/source/anchors/Red_Hat_IT_Root_CA.crt && curl -Lk https://engineering.redhat.com/Eng-CA.crt -o /etc/pki/ca-trust/source/anchors/Eng_Ops_CA.crt && curl -Lk https://password.corp.redhat.com/pki-ca-chain.crt -o /etc/pki/ca-trust/source/anchors/PKI_CA_Chain.crt && ln -sf /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem /etc/pki/tls/certs/ca-bundle.crt && update-ca-trust && update-ca-trust enable

RUN useradd -d /home/rhmap4-build -g wheel -ms /bin/bash rhmap4-build

ADD ./rhmap4-build-priv /home/rhmap4-build/.ssh/id_rsa
ADD ./rhmap4-build-pub /home/rhmap4-build/.ssh/id_rsa.pub
ADD ./ssh-config /home/rhmap4-build/.ssh/config
ADD ./known_hosts /home/rhmap4-build/.ssh/known_hosts
ADD ./productization_playbooks /home/rhmap4-build/productization_playbooks
RUN chown rhmap4-build /home/rhmap4-build/.ssh/id_rsa* && chmod 0600 /home/rhmap4-build/.ssh/id_rsa* && chown rhmap4-build /home/rhmap4-build/.ssh/known_hosts && chown rhmap4-build /home/rhmap4-build/productization_playbooks

RUN mkdir -p /mnt/keytabs && mkdir -p /home/rhmap4-build/.ssh
VOLUME ["/mnt/keytabs"]

RUN echo "1234" | passwd rhmap4-build --stdin
USER rhmap4-build
ENV RHUSER rhmap4-build
ENV USER rhmap4-build
RUN git config --global user.name "Peter Braun" && git config --global user.email "pbraun@redhat.com" && export USER=rhmap4-build

WORKDIR /home/rhmap4-build

# RUN git clone https://code.engineering.redhat.com/gerrit/jboss-mobile/mobile-platform-tooling && (cd mobile-platform-tooling && curl -kLo `git rev-parse --git-dir`/hooks/commit-msg https://code.engineering.redhat.com/gerrit/tools/hooks/commit-msg; chmod +x `git rev-parse --git-dir`/hooks/commit-msg)

