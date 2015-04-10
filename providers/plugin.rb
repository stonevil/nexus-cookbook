def load_current_resource
  @current_resource = Chef::Resource::NexusPlugin.new(new_resource.name)
end

action :install do
  plugin_name = get_plugin(new_resource.name)
  if plugin_name.nil? || plugin_name.empty?
    Chef::Application.fatal! "Could not find a plugin that matches #{new_resource.name} in #{new_resource.plugin_path}."
  end

  unless ::File.exists?("#{nexus_plugins_path}/#{plugin_name}")
    log "Symlinking #{new_resource.plugin_path}/#{plugin_name} to #{nexus_plugins_path}/#{plugin_name}"
    link "#{nexus_plugins_path}/#{plugin_name}" do
      to "#{new_resource.plugin_path}/#{plugin_name}"
    end
    new_resource.updated_by_last_action(true)
  end
end

private

# @return [String] the joined path of the Nexus installation's plugin-repository
def nexus_plugins_path
  ::File.join(new_resource.nexus_path, node['nexus']['bundle_name'], '/nexus/WEB-INF/plugin-repository')
end

# Searches the plugin_path for a plugin that matches the given
# plugin parameter.
#
# @param  plugin [String] the name of the plugin to find
#
# @return [String] the full name of the plugin found
def get_plugin(plugin)
  available_plugins = Dir.entries(new_resource.plugin_path)
  available_plugins.find { |plugin_dir| plugin_dir.match(plugin) }
end
