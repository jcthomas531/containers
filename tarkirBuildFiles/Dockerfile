FROM rocker/tidyverse:latest
MAINTAINER JC Thomas "jc-thomas@uiowa.edu"  

#this image from dockerHub contains the tidyverse and devtools among other things

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

RUN apt-get update && apt-get install -y \
libxml2-dev \
libcurl4-openssl-dev \
libssl-dev


#this was all in attempt to get my package working, it will install but i cannot 
#access it once inside of R. something to work on later. I will leave the other 
#dependency packages installed as they are not hurting anything
#all packages in this chunk install correctly
RUN Rscript -e "install.packages('Hmisc'); warnings()"
RUN Rscript -e "install.packages('kableExtra'); warnings()"
RUN Rscript -e "install.packages('arsenal'); warnings()"
RUN Rscript -e "install.packages('vcdExtra'); warnings()"
##ENV R_LIBS_SITE=/usr/local/lib/R/site-library
##RUN mkdir -p /usr/local/lib/R/site-library
##RUN Rscript -e "pak::pkg_install('jcthomas531/mysticOwl', lib = Sys.getenv('R_LIBS_SITE'))"

#installing additional r packages
#all packages in this chunk install correctly
RUN Rscript -e "install.packages(c('here', 'rstan', 'lspline', 'lme4', 'gtsummary', 'emmeans', 'mvtnorm', 'openxlsx', 'car')); warnings()"
