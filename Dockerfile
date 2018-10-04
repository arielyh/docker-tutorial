# use ubuntu as base image
FROM ubuntu

# update and install the required packages
RUN apt-get -y update
RUN apt-get install -y wget gzip zip bzip2 python

# create working directory in the image
RUN mkdir /usr/tools && cd /usr/tools
RUN mkdir /usr/tools/bin
WORKDIR /usr/tools

# download miniconda installer
RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh

# create input for miniconda installer's prompt
RUN echo "yes\nyes\n" > conda_inst_stdin.txt

# install conda
RUN bash Miniconda2-latest-Linux-x86_64.sh < conda_inst_stdin.txt

# add conda's executable path to environment
ENV PATH /root/miniconda2/bin:$PATH

# add bioconda channel
RUN conda config --add channels r
RUN conda config --add channels bioconda
RUN conda list

# add current directory to the container at '/data'
# and change container's working directory to '/data'
ADD . /data
WORKDIR /data

# install bowtie to the image
RUN conda install -y bowtie
