#!/bin/bash

exec sudo DOCKER_BUILDKIT=1 docker build . -t 'kanna5/httpbin'
