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


# Fixed location for TinyTeX inside the container.
# Keeping this independent of $HOME prevents problems when the
# container is run through Apptainer/Singularity or qsub.
ENV TINYTEX_DIR=/opt/TinyTeX

# Make TinyTeX's Linux binaries available to all users/processes.
ENV PATH="${TINYTEX_DIR}/bin/x86_64-linux:${PATH}"



#installs latest version of R
RUN apt-get update && \
    apt-get install -y \
        apt-utils \
        git \
        vim \
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
	\
	# Required for TinyTeX
        perl \
        wget \
        xz-utils \
        fontconfig \
	\
	# RMarkdown/PDF rendering
        pandoc && \
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
open3d

#install snakemake
RUN pip install --no-cache-dir snakemake \
    snakemake-executor-plugin-cluster-generic \
    snakemake-storage-plugin-fs \
    graphviz

#install R packages
ENV R_LIBS_SITE=/usr/local/lib/R/site-library
RUN R -e "install.packages(c('tidyverse','data.table', 'devtools', 'vcdExtra', 'Hmisc', 'kableExtra', 'arsenal', 'gtsummary', 'rmarkdown', 'knitr', 'tinytex', 'here', 'openxlsx', 'duckdb', 'DBI', 'remotes', 'pak', 'BiocManager', 'stringr', 'emmeans', 'tidyr'), repos='https://cloud.r-project.org')"
RUN R -e "library(rmarkdown); print(pandoc_available()); print(pandoc_version())"
RUN R -e "pak::pak('jcthomas531/mysticOwl')"
RUN R -e "BiocManager::install('Biobase', update = FALSE, ask = FALSE)"



# ------------------------------------------------------------------
# TinyTeX / LaTeX
# ------------------------------------------------------------------

# Install TinyTeX into a fixed system location rather than under
# the user's HOME directory.
#
# tinytex::install_tinytex() normally installs to ~/.TinyTeX on
# Linux. We explicitly override that location here so that the
# installation is independent of whoever runs the container.

#changing to a version of tinytex that comes with all latex packages on CTAN pre-installed in an attempt
#to avoid having to rebuild the container image for every package i have forgotten to install
#the commented out section below is the previous method of installing tinytex and then adding individual packages

#RUN R -e "tinytex::install_tinytex(dir = Sys.getenv('TINYTEX_DIR'), bundle = 'TinyTeX', add_path = FALSE)"
#RUN R -e "tinytex::tlmgr_install(c( \
#'xltabular', \
#'booktabs', \
#'longtable', \
#'array', \
#'multirow', \
#'wrapfig', \
#'float', \
#'colortbl', \
#'pdflscape', \
#'threeparttable', \
#'threeparttablex', \
#'makecell' \
#))"

RUN R -e "tinytex::install_tinytex(dir = Sys.getenv('TINYTEX_DIR'), bundle = 'TinyTeX-2', add_path = FALSE)"


# ------------------------------------------------------------------
# Verify LaTeX installation during the image build
# ------------------------------------------------------------------

RUN echo "PATH=${PATH}" && \
    which pandoc && \
    pandoc --version && \
    test -x "${TINYTEX_DIR}/bin/x86_64-linux/pdflatex" && \
    "${TINYTEX_DIR}/bin/x86_64-linux/pdflatex" --version && \
    which pdflatex


RUN Rscript -e " \
    print(Sys.getenv('PATH')); \
    print(Sys.which('pandoc')); \
    print(Sys.which('pdflatex')); \
    print(tinytex::tinytex_root()); \
    print(tinytex::is_tinytex()); \
    stopifnot(Sys.which('pdflatex') != '') \
"


# ------------------------------------------------------------------
# Make sure the container's R environment also sees TinyTeX
# ------------------------------------------------------------------

RUN Rscript -e "stopifnot(Sys.which('pdflatex') != '')"


#final check
RUN R -e "print(tinytex::is_tinytex())"

# ------------------------------------------------------------------
# Final cleanup
# ------------------------------------------------------------------

RUN apt-get clean && \
    rm -rf /tmp/* /var/tmp/*




