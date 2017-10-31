# A container that authenticates to kerberos and runs rhpkg builds

You need to have a directory with a keytab file and mount it to the container like this:

```
docker build -t rhpkg:latest .
docker run -v <full path to keytab folder>:/mnt/keytabs -it rhpkg /bin/bash
```

The name of the keytab file needs to be `rhmap4-build.keytab`
