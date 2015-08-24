FROM qnib/terminal

## Kibana
WORKDIR /opt/
ENV KIBANA_VER 4.1.1
RUN curl -s -L -o kibana-${KIBANA_VER}-linux-x64.tar.gz https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VER}-linux-x64.tar.gz &&\
    tar xf kibana-${KIBANA_VER}-linux-x64.tar.gz && \
    rm /opt/kibana*.tar.gz
RUN ln -sf /opt/kibana-${KIBANA_VER}-linux-x64 /opt/kibana
ADD etc/supervisord.d/kibana.ini /etc/supervisord.d/
ADD opt/qnib/kibana/bin/start_kibana.sh /opt/qnib/kibana/bin/
ADD etc/consul.d/check_kibana.json /etc/consul.d/check_kibana.json
# Config kibana
ADD opt/kibana/config/kibana.yml /opt/kibana/config/kibana.yml
## Dashboard
RUN yum install -y jq bc 
#RUN yum install -y npm && \
#    npm install elasticdump -g
#ADD etc/supervisord.d/kibana_restore.ini /etc/supervisord.d/
#ADD opt/qnib/bin/kibana_restore.sh /opt/qnib/bin/
#ADD dumps/ /opt/kibana4_dumps/
