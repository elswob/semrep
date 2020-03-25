# Background

Based on this repo - https://github.com/ncats/docker/tree/master/semrep

Added docker-compose to combine the metamap and semrep images/containers.

For more info on setup see metamap and semrep README.md


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

Test the API

```
curl -X POST localhost:8067/ -H Content-Type:text/plain      --data-binary "modafinil is a novel stimulant that is effective in the treatment of narcolepsy"
```

Test the container

```
docker exec -it semrep ./bin/semrep.v1.8 -L 2018 -Z 2018AA -F user_data/test.txt
```

### Options

MetaMap - https://metamap.nlm.nih.gov/Docs/MM_2016_Usage.pdf

`--threshold 123`

Restricts output to UMLS candidate concepts whose evaluation score equals or exceeds the specified threshold. Judicious use of this option can exclude false positives when some input text has no close matches in the Metathesaurus. An appropriate threshold can usually be determined simply by examining MetaMap output for typical text in a given application.



### modify

To let connections in outside of localhost


```
#semrep-rest-api/conf/application.conf
play.filters.hosts {
  allowed = ["."]
}
```

### Issues

First tests gave this error

```
! System error
! 'dlopen("/metamap/public_semrep/bin/abgenemod.so") failed in load_foreign_resource/1: libpcre.so.1: cannot open shared object file: No such file or directory'

```

Fixed this:

```
cp lib/libpcre.so.0.0.1 lib/libpcre.so.1
```