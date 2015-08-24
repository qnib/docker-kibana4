#!/bin/bash

cnt=0
function wait_es {
    cnt=$(echo cnt+1|bc)
    if [ $cnt -eq 180 ];then
        echo "ES startup took to long..."
        exit 42
    fi
    if [ "x$(curl -s http://172.17.42.1:9200/ |jq .status)" != "x200" ];then
        sleep 1
        wait_es
    else
        echo "ES.status = 200!"
    fi
}

wait_es
sleep 5

kibana_size=$(curl -s http://172.17.42.1:9200/.kibana/_status|jq '.indices[".kibana"].index.size_in_bytes')

if [ "Xnull" == "X$kibana_size" ];then

    if [ -f /opt/kibana4_dumps/mapping.json ];then
        elasticdump \
         --bulk=true \
         --input=/opt/kibana4_dumps/mapping.json \
         --output=http://elasticsearch.service.consul:9200/
    fi

    if [ -f /opt/kibana4_dumps/data.json ];then
        elasticdump \
         --bulk=true \
         --input=/opt/kibana4_dumps/data.json \
         --output=http://elasticsearch.service.consul:9200/
    fi
fi

exit 0
