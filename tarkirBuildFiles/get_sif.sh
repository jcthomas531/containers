#!/bin/bash
podman save tarkir -o tarkir.tar
/home/jcthomas531/containers/apptainer/bin/apptainer build tarkir.sif docker-archive:tarkir.tar
