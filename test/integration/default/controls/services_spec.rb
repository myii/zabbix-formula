# frozen_string_literal: true

control 'zabbix service (installed + enabled)' do
  impact 0.5
  title 'should be installed and enabled'

  services =
    case platform[:name]
    when 'fedora'
      %w[zabbix-agent zabbix-server-mysql]
    else
      %w[zabbix-agent zabbix-server]
    end

  services.each do |s|
    describe service(s) do
      it { should be_installed }
      it { should be_enabled }
    end
  end
end

control 'zabbix service (running)' do
  impact 0.5
  title 'should be running'

  services = %w[zabbix-agent zabbix-server]

  services.each do |s|
    describe service(s) do
      it { should be_running }
    end
  end
end
