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
ADD ./rhmap4-build.keytab /home/rhmap4-build/rhmap4-build.keytab
ADD ./.password /home/rhmap4-build/.password
ADD ./motd /etc/motd
ADD ./bootstrap.sh /home/rhmap4-build/bootstrap.sh
ADD ./productization_playbooks /home/rhmap4-build/productization_playbooks

RUN chown -R rhmap4-build /home/rhmap4-build/.ssh && chown rhmap4-build /home/rhmap4-build/productization_playbooks && echo "alias vim='vi'" >> /home/rhmap4-build/.bashrc && echo "cat /etc/motd" >> /home/rhmap4-build/.bashrc && chmod +x /home/rhmap4-build/bootstrap.sh

RUN echo "1234" | passwd rhmap4-build --stdin
USER rhmap4-build

ENV RHUSER rhmap4-build
ENV USER rhmap4-build

RUN git config --global user.name "rhmap4-build" && git config --global user.email "mobile-qe-team@redhat.com"

WORKDIR /home/rhmap4-build
