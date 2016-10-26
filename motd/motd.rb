control "MOTD-1.0" do
  impact 1.0
  title "MOTD"
  desc "Testing the MOTD file contains values from chef recipe"
  describe file('/etc/motd') do
    its('content') { should match 'hostname:' }
    its('content') { should match 'fqdn:' }
    its('content') { should match 'domain:' }
    its('content') { should match 'platform:' }
    its('content') { should match 'platform version:' }
    its('content') { should match 'memory:' }
    its('content') { should match 'cpu count:' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
  end
end
