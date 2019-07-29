#!/bin/bash

# Can pass in a suffix to be attached to the container name (for multiple notebooks)
CONTAINERNAME=notebook-tf-gpu$1

## See all tag variants at https://hub.docker.com/r/tensorflow/tensorflow/tags/
export IMAGENAME=pocketprotectors/datascience-ml-notebook-tf-gpu:latest 

# make sure we have the latest container image
docker pull $IMAGENAME

HERE="$( cd "$( dirname "$0" )" && pwd )"
CONVERTPATH="$(dirname $HERE)/$(basename $HERE)"
docker run --runtime=nvidia --rm --name ${CONTAINERNAME} --privileged -d -p 127.0.0.1:8888:8888 -v ${CONVERTPATH}/..:/home/jupyter/work ${IMAGENAME}

sleep 3
# Get the notebook token (paste into token prompt in browser)
tokenstr=$(docker exec ${CONTAINERNAME} jupyter notebook list | grep token | cut -d' ' -f1)
echo "To access genctl charting notebook:"
echo "Visit: ${tokenstr[0]}"
echo "  and navigate to work/*.ipynb"
