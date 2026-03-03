# Overview

Containers that I have made for running code on the University of Iowa HPC. These are just the files that are needed to build the containers because the containers themselves are very large files. I made two containers before setting up this repo and have since lost the build files because they were saved on an Ubuntu installation and I had to delete it. The containers (pytorch1.sif and pytorch2.sif) are still on my argon profile. 

Because you need root access to build containers, all of the work to make and build these files is done on wsl via Ubuntu. However, I am hardly a linux expert and have not bothered to link github to my Ubuntu installation. The main directory that this repo is updated from is: H:\schoolFiles\containers. My plan is that whenever I update one of my containers, I will copy the files from wsl to this directory, replace the existing files, and then push them to github. When I make a new container I will do something similar. Is this the best way to do it? Not by a long shot but that the way I'm going to do it.


# Container details

## Lorwyn - lorwynBuildFiles

I am hope that I can keep this container as a sort of general catch all for many needs. I built it off of a container on docker: https://hub.docker.com/r/pytorch/pytorch and then added some python packages with 3d mesh tools on top of that.
