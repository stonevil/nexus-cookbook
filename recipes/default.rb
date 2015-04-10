include_recipe "nexus::_#{node['platform_family']}"

if node['nexus']['use_chef_vault']
  chef_gem 'chef-vault'
  require 'chef-vault'
end

include_recipe 'nexus::cli'
include_recipe 'nexus::app'
include_recipe 'nexus::app_server_proxy'
