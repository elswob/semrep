This repository contains docker files created for various projects.
# semrep

The tar.bz2 files get uncompressed automatically during image creation

Get SemRep data - ftp://lhcftp.nlm.nih.gov/Open-Access-Datasets/SKR/SemRep/dist

```
docker-compose build
```

Test metamap

```
docker run --rm -t -p 18066:18066 semrep_metamap
```