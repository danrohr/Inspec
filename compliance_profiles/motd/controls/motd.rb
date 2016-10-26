control "MOTD-1.0" do
  impact 1.0
  title "MOTD File Contents"
  desc "Testing the MOTD file contains required values from chef recipe"
  describe file('/etc/motd') do
    its('content') { should match 'hostname:' }
    its('content') { should match 'fqdn:' }
    its('content') { should match 'domain:' }
    its('content') { should match 'platform:' }
    its('content') { should match 'platform version:' }
    its('content') { should match 'memory:' }
    its('content') { should match 'cpu count:' }
  end
end

control "MOTD-1.1" do
  impact 1.0
  title "MOTD File Ownership"
  desc "Testing to ensure file ownership of MOTD is properly set"
  describe file('/etc/motd') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control "MOTD-1.2" do
  impact 1.0
  title "MOTD File Mode Permissions"
  desc "Testing the MOTD file has proper file mode permissions set"
  describe file('/etc/motd') do
    it { should_not be_executable.by "group" }
    it { should_not be_writable.by "group" }
    it { should_not be_executable.by "other" }
    it { should_not be_writable.by "other" }
    it { should_not be_executable }
  end
end
