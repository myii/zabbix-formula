# -*- coding: utf-8 -*-
# vim: ft=sls
---
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import zabbix as map with context %}

{%- set output_file = '/tmp/salt_yaml_dump.yaml' %}
{%- set check_for_changes = True if salt['file.file_exists'](output_file) else False %}

yaml-dump-{{ tplroot }}:
  file.managed:
    - name: {{ output_file }}
    - source: salt://{{ tplroot }}/yaml_dump/yaml_dump.jinja
    - template: jinja
    - context:
        map: {{ map | yaml }}
    - show_changes: true

{%- if check_for_changes %}
  test.fail_without_changes:
    - name: 'Map is not identical before and after; check the diff above.'
    - failhard: true
    - onchanges:
      - file: yaml-dump-{{ tplroot }}
{%- endif %}
