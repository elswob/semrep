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
curl -X POST localhost:8067/ -H Content-Type:text/plain --data-binary "modafinil is a novel stimulant that is effective in the treatment of narcolepsy"
```

Test the container

```
docker exec -it semrep ./bin/semrep.v1.8 -L 2018 -Z 2018AA -F user_data/test.txt
```

### Options

MetaMap - https://metamap.nlm.nih.gov/Docs/MM_2016_Usage.pdf

`--threshold 123`

Restricts output to UMLS candidate concepts whose evaluation score equals or exceeds the specified threshold. Judicious use of this option can exclude false positives when some input text has no close matches in the Metathesaurus. An appropriate threshold can usually be determined simply by examining MetaMap output for typical text in a given application.

### Output

API outputs SemRep full fomrat

##### SemRep full format

Modified from here - https://github.com/lhncbc/SemRep/blob/master/doc/SemRep_full_fielded_output.pdf

0. section (title/abstract) - this is custom added in our version of semrep 
1. SE (designates that the output is from SemRep)
2. PMID (the ID of the document)
3. subsection - If the utterance begins with one of a specified set of strings of uppercase letters followed by a colon
4. section (ti if the utterance is from the title of the citation; ab if the utterance is from the abstract of the citation.; tx if from text)
5. Sentence ID: an integer indicating the utterance’s position within the title/abstract.
6. indicates the output type, and will be one of atoms itemized in Section 1: text, entity, relation,or coreference.
7. SubjectMaxDist: The number of potential arguments (i.e., NPs) from the indicator in
the direction of the subject (3)
8. SubjectDist: The number of potential arguments separating the subject from the
indicator (1)
9. * CUI of the subject concept (C0027893)
10. * Preferred name of the subject concept (neuropeptide Y)
1. Semantic Type(s) of the subject concept5 (aapp, gngm, nsba in the example above, gngm is an artificial semantic type)
12. Subject Semantic Type used for the relation (aapp)
13. * Normalized gene ID(s) of the subject from EntrezGene; may contain multiple IDs
delimited by comma or may be empty (4852)
14. * Normalized gene name(s) of the subject from EntrezGene; may contain multiple
names delimited by comma or may be empty (NPY)
15. Text that maps to the subject (neuropeptide y)
16. * Change term (<CHANGE> may appear as placeholder)
17. * Degree term (<DEGREE> may appear as placeholder)
18. * Negation term: 1 if the subject is negated, 0 if it’s not. (0)
19. Confidence score (1000)
20. First character position (in document) of text denoting subject entity (39)
21. Last character position (in document) of text denoting subject entity (59)
22. Indicator Type6 (VERB)
23. Predicate (INHIBITS)
24. negation if the relation (the immediately preceding field) is negative; empty
otherwise
25. First character position (in utterance) of text denoting relation (70)
26. End position (in utterance) of text denoting relation (79)
27. ObjectMaxDist: The number of potential arguments (i.e., NPs) from the indicator in
the direction of the object (4)
28. ObjectDist: The number of potential arguments separating the object from the
indicator (2)
29. * CUI of the object concept (C0021753)
30. Preferred name of the object concept (Interleukin-1 beta)
31. Semantic Type(s) of the object concept (gngm,aapp,imft in the example above,
gngm is an artificial semantic type)
32. Object Semantic Type used for the relation (gngm)
33. * Normalized gene ID(s) of the object from EntrezGene; may contain multiple IDs
delimited by comma or may be empty (3553)
34. * Normalized gene name(s) of the object from EntrezGene; may contain multiple
names delimited by comma or may be empty (IL1B)
35. Text that maps to the object (interleukin-1beta)
36. * Change term (<CHANGE> may appear as placeholder)
37. * Degree term (<DEGREE> may appear as placeholder)
38. * Negation term: 1 if the object is negated, 0 if it’s not. (0)
39. Confidence score (1000)
40. First character position (in document) of text denoting subject entity (129)
41. End position (in document) of text denoting subject entity (136)

### modifications

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