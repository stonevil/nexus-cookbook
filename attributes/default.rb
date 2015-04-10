default['apt']['compile_time_update'] = true
default['apt']['periodic_update_min_delay'] = '60'

default['java']['jdk_version'] = '7'

# this duplicates logic from the java cookbook's attributes because we can't work around the attribute file load ordering
case node['platform_family']
when 'rhel', 'fedora'
  default['java']['java_home'] = '/usr/lib/jvm/java'
  default['java']['openjdk_packages'] = ["java-1.#{node['java']['jdk_version']}.0-openjdk", "java-1.#{node['java']['jdk_version']}.0-openjdk-devel"]
when 'debian'
  default['java']['java_home'] = '/usr/lib/jvm/default-java'
  default['java']['openjdk_packages'] = ["openjdk-#{node['java']['jdk_version']}-jdk", 'default-jre-headless']
else
  default['java']['java_home'] = '/usr/lib/jvm/default-java'
  default['java']['openjdk_packages'] = ["openjdk-#{node['java']['jdk_version']}-jdk"]
end

default['nexus']['version'] = '2.11.2-06'
default['nexus']['base_dir'] = '/'
default['nexus']['user'] = 'nexus'
default['nexus']['group'] = 'nexus'
default['nexus']['external_version'] = '2.11.2'
default['nexus']['url'] = "http://www.sonatype.org/downloads/nexus-#{node['nexus']['external_version']}-bundle.tar.gz"
default['nexus']['checksum'] = 'e3fe7811d932ef449fafc4287a27fae62127154297d073f594ca5cba4721f59e'

default['nexus']['port'] = '8081'
default['nexus']['host'] = '0.0.0.0'
default['nexus']['context_path'] = '/nexus'

default['nexus']['name'] = 'nexus'
default['nexus']['bundle_name'] = "#{node['nexus']['name']}-#{node['nexus']['version']}"
default['nexus']['home'] = "/opt/#{node['nexus']['name']}"
default['nexus']['pid_dir'] = "#{node['nexus']['home']}/shared/pids"
default['nexus']['work_dir'] = '/opt/sonatype-work/nexus'

default['nexus']['app_server']['jetty']['loopback'] = false

default['nexus']['app_server_proxy']['ssl']['port'] = 8443
default['nexus']['app_server_proxy']['ssl']['key'] = node['fqdn']

default['nexus']['app_server_proxy']['use_self_signed'] = false
default['nexus']['app_server_proxy']['server_name'] = node['fqdn']
default['nexus']['app_server_proxy']['port'] = "http://127.0.0.1:#{node['nexus']['port']}"
default['nexus']['app_server_proxy']['server']['options'] = [
  'client_max_body_size 200M',
  'client_body_buffer_size 512k',
  'keepalive_timeout 0'
]
default['nexus']['app_server_proxy']['proxy']['options'] = []

default['nexus']['load_balancer']['upstream_name'] = 'nexii'
default['nexus']['load_balancer']['upstream_servers'] = []

default['nexus']['cli']['ssl']['verify'] = true
default['nexus']['cli']['repository'] = 'releases'
default['nexus']['cli']['default_admin_credentials_updated'] = false
default['nexus']['cli']['retries'] = 3
default['nexus']['cli']['retry_delay'] = 10

default['nexus']['use_chef_vault'] = false
