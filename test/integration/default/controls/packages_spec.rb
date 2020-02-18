# frozen_string_literal: true

pkg_agent = 'zabbix-agent'
pkg_server = 'zabbix-server-mysql'
pkg_web =
  case platform[:family]
  when 'debian'
    'zabbix-frontend-php'
  else
    'zabbix-web-mysql'
  end
version =
  case platform[:name]
  when 'debian'
    if os[:release].start_with?('10')
      '1:4.4.5-2+buster'
    elsif os[:release].start_with?('9')
      '1:4.4.5-2+stretch'
    elsif os[:release].start_with?('8')
      '1:4.4.5-2+jessie'
    end
  when 'ubuntu'
    if os[:release].start_with?('18')
      '1:4.4.5-2+bionic'
    elsif os[:release].start_with?('16')
      '1:4.4.5-2+xenial'
    end
  when 'centos'
    if os[:release].start_with?('8')
      '4.4.1-1.el8'
    elsif os[:release].start_with?('7')
      '4.4.1-1.el7'
    elsif os[:release].start_with?('6')
      '4.4.1-1.el6'
    end
  when 'fedora'
    if os[:release].start_with?('30')
      '4.0.11-1.fc30'
    elsif os[:release].start_with?('29')
      '3.0.28-1.fc29'
    end
  end

control 'zabbix packages' do
  title 'should be installed'

  [
    pkg_agent,
    pkg_server,
    pkg_web
  ].each do |p|
    describe package(p) do
      it { should be_installed }
      its('version') { should eq version }
    end
  end
end
