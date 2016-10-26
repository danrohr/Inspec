control "STIG-1.0-Pwquality" do
  impact 1.0
  title "Pwquality.conf"
  desc "Testing the /etc/security/pwquality.conf file for applicable configurations"
  describe file('/etc/security/pwquality.conf') do
    its('content') { should match '/^difok = 15/' }
    its('content') { should match '/^minlen = 15/' }
    its('content') { should match '/^[dulo]credit = -1/' }
    its('content') { should match '/^minclass = 4/' }
    its('content') { should match '/^maxrepeat = 2/' }
    its('content') { should match '/^maxclassrepeat = 2/'}
  end
end

control "STIG-1.1-SELinux" do
  impact 1.0
  title "SELinux"
  desc "Testing to see if /etc/selinux/config is immutable"
  describe file('/etc/selinux/config') do
    it { should be_immutable }
  end
end

control "STIG-1.2-DisableCTRLALTDEL" do
  impact 1.0
  title "DisableCTRLALTDEL"
  desc "Disable CTRL ALT Delete"
  describe file('/etc/systemd/system/ctrl-alt-del.target') do
    it { should be_symlink }
  end
end

control "STIG-1.3-Disable-Interactive-Shell-sh" do
  impact 1.0
  title "Disable Interactive Shell SH"
  desc "Disable interactive shell and set timeout"
  describe file('/etc/profile.d/autologout.sh') do
    it { should be_file }
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    it { should_not be_writable.by "group" }
    it { should_not be_writable.by "other" }
    its('content') { should match /^TMOUT=900/ }
    its('content') { should match /^readonly TMOUT/ }
    its('content') { should match /^export TMOUT/ }
  end
end

control "STIG-1.4-Disable-Interactive-Shell-csh" do
  impact 1.0
  title "Disable Interactive Shell CSH"
  desc "Disable interactive shell and set timeout"
  describe file('/etc/profile.d/autologout.csh') do
    it { should be_file }
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    it { should_not be_writable.by "group" }
    it { should_not be_writable.by "other" }
    its('content') { should match /^set autologout=15/ }
    its('content') { should match /^set -r autologout/ }
  end
end

control "STIG-1.5-VLock-Alias-sh" do
  impact 1.0
  title "Vlock Alias SH"
  desc "Ensure vlock alias is configured"
  describe file('/etc/profile.d/vlock-alias.sh') do
    it { should be_file }
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    it { should_not be_writable.by "group" }
    it { should_not be_writable.by "other" }
    its('content') { should match /^alias vlock='clear;vlock -a'/ }
  end
end

control "STIG-1.6-VLock-Alias-csh" do
  impact 1.0
  title "Vlock Alias CSH"
  desc "Ensure vlock alias is configured"
  describe file('/etc/profile.d/vlock-alias.csh') do
    it { should be_file }
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    it { should_not be_writable.by "group" }
    it { should_not be_writable.by "other" }
    its('content') { should match /^alias vlock 'clear;vlock -a'/ }
  end
end

control "STIG-1.7-SSHD-Configurations" do
  impact 1.0
  title "SSHD Configurations"
  desc "Ensure SSHD secure configurations are set"
  describe sshd_config do
    its('Protocol') { should cmp 2 }
    its('UsePAM') { should eq 'yes' }
    its('KerberosAuthentication') { should eq 'no' }
    its('PubkeyAuthentication') { should eq 'yes' }
    its('GSSAPIAuthentication') { should eq 'yes' }
    its('MACs') { should cmp('hmac-sha2-512,hmac-sha2-256,hmac-sha1') }
    its('Banner') { should eq '/etc/issue' }
    its('Ciphers') { should cmp('aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc') }
  end
end 

control "STIG-1.7-Disable-Kernel-Dump-Service" do
  impact 1.0
  title "Disable Kernel Dump Service"
  desc "Disable the kernel dump service and ensure it is masked"
  describe service('kdump') do
    it { should be_disabled }
    it { should_not be_running }
  end
end
