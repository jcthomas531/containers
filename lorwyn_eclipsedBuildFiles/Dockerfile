FROM pytorch/pytorch:2.9.0-cuda12.8-cudnn9-runtime 
MAINTAINER JC Thomas "jc-thomas@uiowa.edu"  
# Install some basic software 
#my previous containers have used a different set up however it was causing some issues
#specifically it was getting stuck on an interactive prompt asking for time zone
#copilot and chatgpt both recommended getting rid of the upgrade line which I was hesitant to
#do because grant uses that line an I trust he knows what hes doing. I have replaced this first
#chunk with the recommended chunk from copilot which appears to do most of the same things
#and additionally sets time zone and forces things to be non interactive
#and most importantly it works
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago


#installs latest version of R
RUN apt-get update && \
    apt-get install -y \
        apt-utils \
        git \
        vim \
	#
	#new
	libosmesa6 \
	libosmesa6-dev \
	#
        libgl1 \
        libglib2.0-0 \
        tzdata \
        software-properties-common \
        dirmngr \
        gnupg \
        ca-certificates \
	libwebp-dev \
        \
        # Common libraries required by CRAN packages
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libuv1-dev \
        libgit2-dev \
	libopenblas0 \
	libopenblas-dev \
        \
        # Graphics and font libraries
        libcairo2-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libharfbuzz-dev \
        libfribidi-dev \
        libpng-dev \
        libjpeg-dev \
        libtiff5-dev \
        libx11-dev \
        \
        # Frequently required by R packages
        libicu-dev \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        libreadline-dev \
	# development tools (originally needed for pygco) 
	build-essential \
	wget \
	unzip && \
    \
    # Add CRAN GPG key and repository
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9 && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" && \
    # Install latest R
    apt-get update && \
    apt-get install -y r-base && \
    # Configure timezone
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    # Cleanup
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


#install various python packages
RUN pip install --no-cache-dir \
pandas \
numpy \
trimesh \
plyfile \
pyvista \
tqdm \
scikit-learn \
open3d \
cython \
setuptools \
wheel \
pyacvd \
pykdtree \
veco 

#visualizations with pyvista
RUN pip install "pyvista[jupyter]"

#other python packages that are cooperating with pip
RUN conda install -y -c conda-forge rtree

#install snakemake
RUN pip install --no-cache-dir snakemake \
    snakemake-executor-plugin-cluster-generic \
    snakemake-storage-plugin-fs \
    graphviz

#install R packages
RUN R -e "install.packages(c('tidyverse','data.table', 'devtools', 'vcdExtra', 'Hmisc', 'kableExtra', 'arsenal', 'gtsummary'), repos='https://cloud.r-project.org')"
