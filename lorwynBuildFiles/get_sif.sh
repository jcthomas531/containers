#!/bin/bash
podman save lorwyn -o lorwyn.tar
/home/jcthomas531/containers/apptainer/bin/apptainer build lorwyn.sif docker-archive:lorwyn.tar
