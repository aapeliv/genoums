# "genoums" docker image

Given a `.bam` file, produces a fastqc report and a salmon quantification on it.

## Running it

You need to first install [docker](https://docs.docker.com/engine/install/).

Make a new empty folder, and put the file you want to process, e.g. `genoums.bam` in that folder. Then run the following command:

```sh
docker run -v $(pwd):/app aapeliv/genoums genoums.bam
```

The program will run and put all the output in the current folder.
