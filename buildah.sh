#!/bin/bash

set -e

IMAGE_NAME="informaticsmatters/centos-miniconda"
IMAGE_TAG=latest

export newcontainer=$(buildah from scratch)
export scratchmnt=$(buildah mount $newcontainer)
echo "Creating container $newcontainer using $scratchmnt"

yum -y install\
  bash\
  coreutils\
  wget\
  zip\
  unzip\
  gzip\
  --installroot $scratchmnt --releasever 7\
  --setopt install_weak_deps=false --setopt=tsflags=nodocs\
  --setopt=override_install_langs=en_US.utf8 -y
yum clean all -y --installroot $scratchmnt --releasever 7
rm -rf $scratchmnt/var/cache/yum

wget https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O /tmp/miniconda.sh
bash /tmp/miniconda.sh -b -p $scratchmnt/root/miniconda
rm /tmp/miniconda.sh

# set some config info
buildah config\
  --label name=miniconda\
  --env PATH="root/miniconda/bin:$PATH"\
  $newcontainer

# commit the image
buildah unmount $newcontainer
buildah commit $newcontainer $IMAGE_NAME:$IMAGE_TAG
echo "Committed container $newcontainer as $IMAGE_NAME:$IMAGE_TAG"

echo "The built image can be pushed to docker using:"
echo "sudo buildah push $IMAGE_NAME:$IMAGE_TAG docker-daemon:$IMAGE_NAME:$IMAGE_TAG"
echo "Note: that needs to be done outside of the build container"
