#!/bin/bash

ES_HOST=${ES_HOST-elasticsearch.service.consul}

if [ ! -f /opt/qnib/kibana4/dumps/new_mapping.json ];then
    elasticdump \
        --type=mapping \
        --output=/opt/qnib/kibana4/dumps/new_mapping.json \
        --input=http://${ES_HOST}:9200/.kibana
else
    echo "/opt/qnib/kibana4/dumps/new_mapping.json already there..."
fi
if [ ! -f /opt/qnib/kibana4/dumps/new_data.json ];then
    elasticdump \
        --type=data \
        --output=/opt/qnib/kibana4/dumps/new_data.json \
        --input=http://${ES_HOST}:9200/.kibana
else
    echo "/opt/qnib/kibana4/dumps/new_data.json already there..."
fi

exit 0
