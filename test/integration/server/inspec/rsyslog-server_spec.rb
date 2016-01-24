describe package('rsyslog') do
  it { should be_installed }
end

describe service('rsyslog') do
  it { should be_running }
end

describe port(514) do
  it { should be_listening }
  its('protocols') { should include 'tcp'}
  its('protocols') { should include 'tcp6'}
  its('processes') { should include 'rsyslogd' }
end
