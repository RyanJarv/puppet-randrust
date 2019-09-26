# frozen_string_literal: true

require 'spec_helper'

describe 'randrust' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:title) { 'randrust' }
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('randrust::install') }
      it { is_expected.to contain_class('randrust::config') }
      it { is_expected.to contain_class('randrust::service') }

      describe 'randrust::config' do
        conf_path = '/etc/default/randrust'

        describe 'interfaces' do
          context 'when set' do
            let(:params) { { interface: 'a.b.c.d' } }

            it { is_expected.to contain_file(conf_path).with_content(%r{INTERFACE=a.b.c.d}) }
          end

          context 'when not set' do
            it { is_expected.to contain_file(conf_path).with_content(%r{INTERFACE=0.0.0.0}) }
          end
        end

        describe 'listen port' do
          context 'when set' do
            let(:params) { { listen_port: 38_491 } }

            it { is_expected.to contain_file(conf_path).with_content(%r{LISTEN_PORT=38491}) }
          end

          context 'when not set' do
            it { is_expected.to contain_file(conf_path).with_content(%r{LISTEN_PORT=31531}) }
          end
        end

        describe 'allows template to be overridden with epp template' do
          let(:params) { { 'config_epp' => 'my_randrust/my_randrust.epp' } }

          it { is_expected.to contain_file(conf_path).with_content(%r{randrust}) }
        end
      end

      describe 'randrust::install' do
        let(:params) do
          {
            'package_ensure' => 'present',
            'package_name'   => ['randrust'],
            'package_manage' => true,
          }
        end

        it { is_expected.to contain_package('randrust').with_ensure('present') }

        context 'with package_ensure => latest' do
          let(:params) { { package_ensure: 'latest' } }

          it { is_expected.to contain_package('randrust').with_ensure('latest') }
        end

        context 'with package_name => rustyham' do
          let(:params) { { package_name: ['rustyham'] } }

          it { is_expected.to contain_package('rustyham') }
        end

        context 'with package_manage => false' do
          let(:params) { { package_manage: false } }

          it { is_expected.not_to contain_package('randrust') }
        end
      end
    end
  end
end
