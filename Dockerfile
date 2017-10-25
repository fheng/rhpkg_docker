FROM fedora:25

RUN curl -Lk -o /etc/yum.repos.d/rcm-tools-fedora.repo  http://download.devel.redhat.com/rel-eng/RCMTOOLS/rcm-tools-fedora.repo 

RUN dnf update -y && dnf install krb5-workstation -y && dnf install rhpkg -y && dnf clean all -y

ADD ./krb5.conf /etc/

RUN curl -Lk https://password.corp.redhat.com/cacert.crt -o /etc/pki/ca-trust/source/anchors/Red_Hat_IS_CA.crt && curl -Lk https://password.corp.redhat.com/RH-IT-Root-CA.crt -o /etc/pki/ca-trust/source/anchors/Red_Hat_IT_Root_CA.crt && curl -Lk https://engineering.redhat.com/Eng-CA.crt -o /etc/pki/ca-trust/source/anchors/Eng_Ops_CA.crt && curl -Lk https://password.corp.redhat.com/pki-ca-chain.crt -o /etc/pki/ca-trust/source/anchors/PKI_CA_Chain.crt && ln -sf /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem /etc/pki/tls/certs/ca-bundle.crt && update-ca-trust && update-ca-trust enable

RUN mkdir -p /mnt/keytabs
VOLUME ["/mnt/keytabs"]
ENTRYPOINT kinit -kt /mnt/keytabs/rhmap4-build.keytab rhmap4-build/mobile-jenkins.rhev-ci-vms.eng.rdu2.redhat.com@REDHAT.COM && klist

