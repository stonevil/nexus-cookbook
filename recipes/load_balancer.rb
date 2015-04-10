include_recipe 'nexus::app_server_proxy'

template ::File.join(node['nginx']['dir'], "conf.d", "upstream.conf") do
  source 'upstream.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    :upstream_name => node['nexus']['load_balancer']['upstream_name'],
    :servers => node['nexus']['load_balancer']['upstream_servers']
  )
end
