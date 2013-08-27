require 'spec_helper'

describe 'kickstack::network::db' do

  setup_required_facts

  let :req_params do
    {
      'network_db_password' => 'c_db_p',
    }
  end

  let :hiera_data do
    req_params
  end

  let :pre_condition do
    'include mysql::server'
  end

  it 'should perform default configuration' do

    should contain_class("quantum::db::mysql").with( {
      :user          => 'network',
      :dbname        => 'network',
      :password      => 'c_db_p',
      :charset       => 'utf8',
      :allowed_hosts => false,
    } )

    should contain_data('network_db_password').with( {
      :value => 'c_db_p',
    })

  end

  describe 'with mysql' do
    let :hiera_data do
      req_params.merge( {
        'network_db_user'   => 'pass2',
        'network_db_name'   => 'pass3',
        :db_host            => '10.0.0.3',
        :db_type            => 'mysql',
        :db_allowed_hosts   => '%',
      } )
    end
    it { should contain_class('quantum::db::mysql').with( {
      :dbname        => 'pass3',
      :user          => 'pass2',
      :password      => 'c_db_p',
      :charset       => 'utf8',
      :allowed_hosts => '%',
    } ) }
  end

  describe 'with postgresql' do
    let :hiera_data do
      req.merge( {
        'network_db_user' => 'pass2',
        'network_db_name' => 'pass3',
        :db_host          => '10.0.0.3',
        :db_type          => 'posgresql',
      } )
      it { should contain_class('quantum::db::postgresql').with( {
        :db_name  => 'pass3',
        :user     => 'pass2',
        :password => 'c_db_p',
      } ) }
    end
  end

end
