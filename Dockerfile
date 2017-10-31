FROM fedora:25

RUN curl -Lk -o /etc/yum.repos.d/rcm-tools-fedora.repo  http://download.devel.redhat.com/rel-eng/RCMTOOLS/rcm-tools-fedora.repo 

RUN dnf update -y && dnf install sudo -y && dnf install ansible -y && dnf install python2-simplejson -y && dnf install python2-lxml -y && dnf install npm -y && dnf install krb5-workstation -y && dnf install rhpkg -y && dnf clean all -y

ADD ./krb5.conf /etc/

RUN curl -Lk https://password.corp.redhat.com/cacert.crt -o /etc/pki/ca-trust/source/anchors/Red_Hat_IS_CA.crt && curl -Lk https://password.corp.redhat.com/RH-IT-Root-CA.crt -o /etc/pki/ca-trust/source/anchors/Red_Hat_IT_Root_CA.crt && curl -Lk https://engineering.redhat.com/Eng-CA.crt -o /etc/pki/ca-trust/source/anchors/Eng_Ops_CA.crt && curl -Lk https://password.corp.redhat.com/pki-ca-chain.crt -o /etc/pki/ca-trust/source/anchors/PKI_CA_Chain.crt && ln -sf /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem /etc/pki/tls/certs/ca-bundle.crt && update-ca-trust && update-ca-trust enable

RUN useradd -d /home/pbraun -g wheel -ms /bin/bash pbraun
RUN mkdir -p /mnt/keytabs && mkdir -p /home/pbraun/.ssh
VOLUME ["/mnt/keytabs", "/home/pbraun/.ssh"]
RUN ls -la /home/pbraun/.ssh

# RUN kinit -kt /mnt/keytabs/rhmap4-build.keytab rhmap4-build/mobile-jenkins.rhev-ci-vms.eng.rdu2.redhat.com@REDHAT.COM && klist

RUN echo "1234" | passwd pbraun --stdin
USER pbraun
RUN git config --global user.name "Peter Braun" && git config --global user.email "pbraun@redhat.com" && export USER=pbraun

WORKDIR /home/pbraun
ADD ./productization_playbooks /home/pbraun/productization_playbooks
RUN git clone https://code.engineering.redhat.com/gerrit/jboss-mobile/mobile-platform-tooling && (cd mobile-platform-tooling && curl -kLo `git rev-parse --git-dir`/hooks/commit-msg https://code.engineering.redhat.com/gerrit/tools/hooks/commit-msg; chmod +x `git rev-parse --git-dir`/hooks/commit-msg)


