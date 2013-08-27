require 'spec_helper'

describe 'kickstack::network::agent::l3' do

  setup_required_facts
  setup_required_hiera_data('network')

  it 'should configure l3 agent' do
    should contain_class('kickstack::network::config')
    #should contain_vs_bridge('br-ex').with_ensure('present')
    should contain_class('quantum::agents::l3').with({
      :debug                       => false,
      :interface_driver            => 'quantum.agent.linux.interface.OVSInterfaceDriver',
      :use_namespaces              => true,
      :external_network_bridge     => 'br-ex',
    })
  end

  describe 'when overriding params' do
    let :hiera_data do
      req_params.merge({
        :network_type            => 'single-flat',
        :network_plugin          => 'linuxbridge',
        :debug                   => true,
        :network_external_bridge => 'br-2',
        :network_network_type    => 'per-tenant-router',
      })
    end
    it 'should configure l3 agent' do
      #should contain_vs_bridge('br-2').with_ensure('present')
      should contain_class('quantum::agents::l3').with({
        :debug                   => true,
        :interface_driver        => 'quantum.agent.linux.interface.BridgeInterfaceDriver',
        :use_namespaces          => false,
        :external_network_bridge => 'br-2',
      })
    end

  end
end
