control "Firewalld-1.0" do
  impact 1.0
  title "Firewalld"
  desc "Validation that firewalld service is running/enabled/installed"
  describe service('firewalld') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control "Firewalld-1.1" do
  impact 1.0
  title "Firewalld"
  desc "Validate that ssh is allowed through the firewall and no web services are enabled"
  describe command('firewall-cmd --list-all') do
    its('stdout') { should match /ssh/ }
    its('stdout') { should_not match /http/ }
    its('stdout') { should_not match /https/ }
  end
end
