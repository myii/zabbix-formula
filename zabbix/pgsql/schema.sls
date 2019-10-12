{% from "zabbix/map.jinja" import zabbix with context -%}
{% from "zabbix/libtofs.jinja" import files_switch with context -%}

{% set sql_file = '/usr/share/doc/zabbix-server-pgsql/custom.sql.gz' -%}
upload_sql_dump:
  file.managed:
    - makedirs: True
    - source: {{ files_switch([sql_file],
                              lookup='zabbix-server-pgsql'
                 )
              }}
    - require_in:
      - import_sql
