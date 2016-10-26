control "NTP-1.0" do
  impact 1.0
  title "NTP"
  desc "Testing the NTP file contains correct time server values from chef recipe"
  describe file('/etc/ntp.conf') do
    its('content') { should match 'server t42svidm.linux.tec.org' }
    its('content') { should match 'server t42svidm2.linux.tec.org' }
  end
end

control "NTP-1.1" do
  impact 1.0
  title "NTP"
  desc "Testing ownership of the /etc/ntp.conf configuration file"
  describe file('/etc/ntp.conf') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control "NTP-1.2" do
  impact 1.0
  title "NTP"
  desc "Testing for correct file permissions on the /etc/ntp.conf"
  describe file('/etc/ntp.conf') do
    it { should_not be_executable.by "group" }
    it { should_not be_writable.by "group" }
    it { should_not be_executable.by "other" }
    it { should_not be_writable.by "other" }
    it { should_not be_executable }
  end
end

control "NTP-1.3" do
  impact 1.0
  title "NTP"
  desc "Testing the NTPD service to ensure it is enabled, running, and installed"
  describe service 'ntpd' do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end
