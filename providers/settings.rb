def load_current_resource
  @current_resource = Chef::Resource::NexusSettings.new(new_resource.path)
  @current_resource.value new_resource.value

  run_context.include_recipe 'nexus::cli'
  Chef::Nexus.ensure_nexus_available(node)

  @current_resource
end

action :update do
  unless path_value_equals?(@current_resource.value)
    update_nexus_settings_json
    new_resource.updated_by_last_action(true)
  end
end

private

def path_value_equals?(value)
  require 'jsonpath'
  json = JSON.parse(get_nexus_settings_json)
  path_value = JsonPath.new("$..#{new_resource.path}").on(json).first
  path_value == value
end

def get_nexus_settings_json
  Chef::Nexus.nexus(node).get_global_settings_json
end

def update_nexus_settings_json
  require 'json'
  json = JSON.parse(get_nexus_settings_json)
  edited_json = JsonPath.for(json).gsub("$..#{new_resource.path}") { |value| new_resource.value }.to_hash
  Chef::Nexus.nexus(node).upload_global_settings(JSON.dump(edited_json))
end
