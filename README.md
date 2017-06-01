# Ontology Processor
This repository contains the files required for creating a docker image with required software for ontology processing.

## Prerequisites
Install [docker](https://www.docker.com/)

## Building

Navigate to this repository.

The following command builds the docker image.

`docker build -t <image_name> .`

## Running

`docker run -t -i <image_name> /bin/bash`

Once initialized, run the typical commands for executing the analysis or workflow workflows. The respective repository clones can be found at `${HOME}` (which is `/home/proc`) 