include:
  - services.oracle-jdk

elasticsearch_pkgrepo:
  pkgrepo.managed:
    - humanname: elasticsearch
    - name: deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main
    - dist: stable
    - key_url: http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - require_in:
      - pkg: elasticsearch

elasticsearch:
  pkg:
    - installed
    - require:
      - pkg: oracle-java7-installer
    - require_in:
      - service: elasticsearch-service

elasticsearch-service:
  service.running:
    - name: elasticsearch
    - running: True
    - enable: True
