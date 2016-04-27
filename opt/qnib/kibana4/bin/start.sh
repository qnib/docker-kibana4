#!/bin/bash

source /opt/qnib/consul/etc/bash_functions.sh
wait_for_srv elasticsearch

consul-template -consul localhost:8500 -once -template "/etc/consul-templates/kibana/kibana.yml.ctmpl:/opt/kibana/config/kibana.yml"

/opt/kibana/bin/kibana --config /opt/kibana/config/kibana.yml
