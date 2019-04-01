# Minimal Centos image with Miniconda
A small base image for conda based applications

## Dockerfile
The `Dockerfile` builds the image.

## Buildah
Attempts to create a smaller base image using buildah.

`Dockerfile-buildah` - Dockerfile for creating image contianing `buildah` plus the necessary utilities.

`builda.sh` = buildah script.

NOTE: the buildah images to not yet work. Use the Dokerfile approach for now.

## Adding conda packages
In your images that derrive from this you can install conda packages into the default env like this:
```
conda install --yes -c bioconda --prefix /root/miniconda nextflow
```
Adjust the channel name and the package name accordingly.
