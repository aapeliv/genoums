FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get update && apt-get install -y bedtools tabix python3-pip fastqc curl wget tar

WORKDIR /deps/

RUN curl -Lo bbmap.tar.gz https://sourceforge.net/projects/bbmap/files/BBMap_38.96.tar.gz/download \
  && tar xf bbmap.tar.gz

ENV PATH="$PATH:/deps/bbmap"

RUN wget https://github.com/COMBINE-lab/salmon/releases/download/v1.8.0/salmon-1.8.0_linux_x86_64.tar.gz \
  && tar xf salmon-1.8.0_linux_x86_64.tar.gz

ENV PATH="$PATH:/deps/salmon-1.8.0_linux_x86_64/bin"

RUN wget https://raw.githubusercontent.com/s-andrews/FastQC/75df783702eb7a0a27fa2994a885f8a6fe4fa1b9/Configuration/contaminant_list.txt

COPY script.sh /deps
RUN chmod +x script.sh

WORKDIR /app

ENTRYPOINT ["bash", "/deps/script.sh"]
