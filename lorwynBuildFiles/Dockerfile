FROM pytorch/pytorch:2.9.0-cuda12.8-cudnn9-runtime 
MAINTAINER JC Thomas "jc-thomas@uiowa.edu"  
# Install some basic software 
RUN apt-get clean 
RUN apt-get update -y && \ 
apt-get install -y apt-utils && \ 
apt-get upgrade -y && \ 
apt-get install -y git && \ 
apt-get install -y vim 


#these were put in at the behest of chatgpt, if they cause problems remove
RUN apt-get update && apt-get install -y \
libgl1 \
libglib2.0-0

RUN pip install --no-cache-dir \
pandas \
numpy \
trimesh \
plyfile \
pyvista \
tqdm \
scikit-learn \
open3d
