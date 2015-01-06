#!/bin/bash

# https://registry.hub.docker.com/u/dockerfile/mongodb/
docker run -d -p 27017:27017 -p 28017:28017 -v /Users/chew/coding/PadlyVagrant/mongodb:/data/db --name mongodb dockerfile/mongodb mongod --rest --httpinterface


