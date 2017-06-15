# Ontology Processor
This repository contains the files required for creating a docker image with required software for ontology processing.

## Prerequisites
Install [docker](https://www.docker.com/)

## Download

[jplimce/gov.nasa.jpl.imce.ontologies.processor](https://hub.docker.com/r/jplimce/gov.nasa.jpl.imce.ontologies.processor/)

## Building

Navigate to this repository.

The following command builds the docker image.

`docker build -t jplimce/gov.nasa.jpl.imce.ontologies.processor:<version> .`
`docker build -t jplimce/gov.nasa.jpl.imce.ontologies.processor .` (latest)

## Preconfigured directories

| docker remote path | Description |
|--------------------|-------------|
|`/imce`             | The root for IMCE-related ontology processing. |
|`/imce/tools`       | IMCE tools included in the docker image |

## Running

`docker run -t -i jplimce/gov.nasa.jpl.imce.ontologies.processor:<version> /bin/bash`
`docker run -t -i jplimce/gov.nasa.jpl.imce.ontologies.processor /bin/bash` (latest)

To mount local volumes, add `-v <absolute local path>:<docker remote path>`

Make sure that `<absolute local path>` is allowed for file sharing from the Docker File Sharing preferences.

Once initialized, run the typical commands for executing the analysis or workflow workflows. 

## Publishing

`docker login -u <username>`
`docker push jplimce/gov.nasa.jpl.imce.ontologies.processor:<version>`
`docker push jplimce/gov.nasa.jpl.imce.ontologies.processor` (latest)
