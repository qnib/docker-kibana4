FROM qnib/syslog

ENV KIBANA_SERVER_PORT=5601
    
## Dashboard
RUN dnf install -y npm nmap \
 && npm install -g n \
 && n stable \
 && npm install elasticdump -g
## Kibana
ENV KIBANA_VER=4.5.4
RUN dnf install -y jq bc https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VER}-1.x86_64.rpm
ADD opt/qnib/kibana4/bin/restore.sh \
    opt/qnib/kibana4/bin/backup.sh \
    opt/qnib/kibana4/bin/start.sh \
    /opt/qnib/kibana4/bin/
ADD etc/supervisord.d/kibana4.ini /etc/supervisord.d/
ADD etc/consul.d/kibana4.json /etc/consul.d/
# Config kibana
ADD etc/consul-templates/kibana/kibana.yml.ctmpl /etc/consul-templates/kibana/
ADD opt/qnib/kibana4/dumps/ /opt/qnib/kibana4/dumps/
