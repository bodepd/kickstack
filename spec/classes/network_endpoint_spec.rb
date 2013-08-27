require 'spec_helper'

describe 'kickstack::network::endpoint' do

  let :facts do
    {
      :osfamily       => 'Debian',
      :ipaddress_eth2 => '13.0.0.4',
    }
  end

  let :req_param do
    {
      'network_service_password'  => 'network_service_pass',
      'network_public_address'    => '10.10.0.2',
      'network_admin_address'     => '10.11.0.2',
      'network_internal_address'  => '10.12.0.2',
    }
  end

  let :hiera_data do
    req_param
  end

  describe 'with only required parameters' do

    it 'should configure the endpoint and data' do
      should contain_class('quantum::keystone::auth').with( {
        :password         => 'network_service_pass',
        :public_address   => '10.10.0.2',
        :admin_address    => '10.11.0.2',
        :internal_address => '10.12.0.2',
        :region           => 'RegionOne',
        :tenant           => 'services',
        :require          => 'Class[Keystone]',
      } )
      should contain_data('network_service_password').with( {
        :value => 'network_service_pass'
      } )
    end
  end

  describe 'when overriding defaults' do

    let :hiera_data do
      req_param.merge( {
        :region         => 'dans_region',
        :service_tenant => 'services2',
      } )
    end
    it {  should contain_class('quantum::keystone::auth').with( {
        :region           => 'dans_region',
        :tenant           => 'services2',
    } ) }

  end

end
