#!/bin/bash

docker build -t computerwtf:localtest .

docker rm computerwtf-localtest
docker run --name computerwtf-localtest -p 8080:8080 computerwtf:localtest
