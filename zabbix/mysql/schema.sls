{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/macros.jinja" import files_switch with context -%}

{% set sql_file = '/usr/share/zabbix-server-mysql/salt-provided-create-34.sql' -%}
{{ sql_file }}:
  file.managed:
    - makedirs: True
    - source: {{ files_switch('zabbix', [ sql_file ]) }}
