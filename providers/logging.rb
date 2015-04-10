def load_current_resource
  @current_resource = Chef::Resource::NexusLogging.new(new_resource.name)

  run_context.include_recipe 'nexus::cli'
  Chef::Nexus.ensure_nexus_available(node)

  @current_resource
end

action :set_level do

  unless same_logging_level?

    Chef::Nexus.nexus(node).set_logger_level(new_resource.level)
    new_resource.updated_by_last_action(true)
  end
end

private

def same_logging_level?
  require 'json'
  logging_info = JSON.parse(Chef::Nexus.nexus(node).get_logging_info)
  logging_info['data']['rootLoggerLevel'] == new_resource.level
end
