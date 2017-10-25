FROM fedora:25

RUN curl -L -o /etc/yum.repos.d/rcm-tools-fedora.repo  http://download.devel.redhat.com/rel-eng/RCMTOOLS/rcm-tools-fedora.repo 

RUN dnf update -y && dnf install krb5-workstation -y && dnf install rhpkg -y && dnf clean all -y

ADD ./krb5.conf /etc/
ADD ./rhmap4-build.keytab ./

RUN kinit -kt ./rhmap4-build.keytab rhmap4-build/mobile-jenkins.rhev-ci-vms.eng.rdu2.redhat.com@REDHAT.COM && klist

RUN git clone git://pkgs.devel.redhat.com/rpms/rhmap-fh-aaa-docker && cd rhmap-fh-aaa-docker && git checkout -b rhmap-4.5-rhel-7 remotes/origin/rhmap-4.5-rhel-7 && ls -la

RUN rhpkg container-build --scratch --target=rhmap-4.5-rhel-7-docker-candidate --repo-url http://download-node-02.eng.bos.redhat.com/rcm-guest/puddles/RHMAP/4.5/2017-08-22.1/external-rhmap-4.5.repo http://download-node-02.eng.bos.redhat.com/rcm-guest/puddles/RHMAP/4.5/2017-08-22.1/rhmap-4.5.repo
