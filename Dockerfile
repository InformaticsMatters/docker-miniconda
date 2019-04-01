FROM centos:7
RUN yum -y install --setopt=tsflags=nodocs --setopt=override_install_langs=en_US.utf8\
  wget bzip2 zip unzip gzip gunzip which&&\
  yum clean -y all &&\
  rm -rf /var/cache/yum 
RUN wget https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O ~/miniconda.sh &&\
  bash ~/miniconda.sh -b -p /root/miniconda &&\
  rm ~/miniconda.sh
ENV PATH="root/miniconda/bin:$PATH"
