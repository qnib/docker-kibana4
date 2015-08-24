#!/bin/bash

if [ "X${ES_DC}" != "X" ];then
   sed -i'' -e "s#elasticsearch_url:.*#elasticsearch_url: \"http://elasticsearch.service.${ES_DC}.consul:9200\"#" /opt/kibana/config/kibana.yml
fi

/opt/kibana/bin/kibana --config /opt/kibana/config/kibana.yml
