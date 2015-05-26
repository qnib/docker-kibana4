FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

## Kibana
WORKDIR /opt/
ENV KIBANA_VER 4.0.2
RUN curl -s -L -o kibana-${KIBANA_VER}-linux-x64.tar.gz https://download.elasticsearch.org/kibana/kibana/kibana-${KIBANA_VER}-linux-x64.tar.gz && \
    tar xf kibana-${KIBANA_VER}-linux-x64.tar.gz && \
    rm /opt/kibana*.tar.gz
RUN ln -sf /opt/kibana-${KIBANA_VER}-linux-x64 /opt/kibana
ADD etc/supervisord.d/kibana.ini /etc/supervisord.d/
ADD etc/consul.d/check_kibana.json /etc/consul.d/check_kibana.json
# Config kibana
ADD opt/kibana/config/kibana.yml /opt/kibana/config/kibana.yml
