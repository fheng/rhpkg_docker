# A container that authenticates to kerberos and runs rhpkg builds

This docker image can be used for the RHMAP productization process. It logs you in as the `rhmap4-build`. Run `./bootstrap.sh` to set up the environment. Tools like `rhpkg` and `brew` are installed in the container. The bootstrap script will clone all required repositories and set up the directory structure used for productization.

## Prerequisites

A file named `.password` containing the password for the ansible vault needs to be in the same directory as the Dockerfile.

## Building

```
docker build -t rhpkg:latest .
docker run -it rhpkg /bin/bash
```

## Usage

Once logged into the container run `./bootstrap.sh` to start the ansible playbook. It will set up the directory structure, clone all repositories and authenticate you using the `rhmap4-build` principal.
