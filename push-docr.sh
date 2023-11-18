#!/bin/bash

docker tag computerwtf:localtest registry.digitalocean.com/er-registry/computerwtf:localtest

docker push registry.digitalocean.com/er-registry/computerwtf:localtest
