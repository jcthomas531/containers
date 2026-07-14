#!/bin/bash
podman save lorwyn_eclipsed -o lorwyn_eclipsed.tar
/home/jcthomas531/containers/apptainer/bin/apptainer build lorwyn_eclipsed.sif docker-archive:lorwyn_eclipsed.tar
