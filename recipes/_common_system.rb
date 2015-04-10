user_home = ::File.join(node['nexus']['base_dir'], node['nexus']['user'])

group node['nexus']['group'] do
  system true
end

user node['nexus']['group'] do
  gid    node['nexus']['group']
  shell  '/bin/bash'
  home   user_home
  system true
end

directory user_home do
  owner  node['nexus']['user']
  group  node['nexus']['group']
  mode   '0755'
  action :create
end
