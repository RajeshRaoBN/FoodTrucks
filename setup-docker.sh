#!/bin/bash

# build the flask container
docker build -t rbnrao/foodtrucks-web .

# create the network
docker network create foodtrucks-net

# start the ES container
docker run -d --name es --net foodtrucks-net -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.3.2

# start the flask app container
docker run -d --net foodtrucks-net -p 6000:6000 --name foodtrucks-web rbnrao/foodtrucks-web
