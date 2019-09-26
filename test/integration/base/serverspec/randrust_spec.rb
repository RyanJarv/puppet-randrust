
if !ENV['w_ssh'].nil? && ENV['w_ssh'] == 'true'
  begin
    require 'spec_helper.rb'
  end
else
  begin
    require 'spec_helper.rb'
    set :backend, :exec
  end
end

#----------------------------------------------------------------------

#  http://serverspec.org/resource_types.html

#----------------------------------------------------------------------

describe 'randrust' do
  describe package('randrust') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/default/randrust') do
    its(:content) { is_expected.to match %r{LISTEN_PORT=31531} }
    it { is_expected.to be_owned_by 'root' }
  end

  describe file('/etc/init.d/randrust') do
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
  end

  describe file('/usr/local/bin/randrust') do
    it { is_expected.to be_mode 755 }
    it { is_expected.to be_owned_by 'root' }
  end

  describe user('randrust') do
    it { is_expected.to exist }
    it { is_expected.to belong_to_primary_group 'randrust' }
    it { is_expected.not_to have_home_directory '/root' }
  end

  describe group('randrust') do
    it { is_expected.to exist }
  end

  describe service('randrust') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end

  describe process('randrust') do
    its(:user) { is_expected.to eq 'randrust' }
    its(:args) { is_expected.to match %r{ 31531\b} }
    its(:count) { is_expected.to eq 1 }
  end

  describe port(31_531) do
    it { is_expected.to be_listening.on('0.0.0.0').with('tcp') }
  end

  describe command('curl http://127.0.0.1:31531/key/32') do
    its(:stdout) { is_expected.to match(%r{^[A-Za-z0-9+/=]{44}$}) }
  end
end
