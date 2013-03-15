require 'spec_helper'

describe 'motd' do

  it { should include_class('motd') }

  it do
    should contain_file('/etc/motd').with({
      'ensure' => 'present',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0644',
    })
  end
end
