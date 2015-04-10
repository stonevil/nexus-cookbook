def load_current_resource
  @current_resource = Chef::Resource::NexusGroupRepository.new(new_resource.name)

  run_context.include_recipe 'nexus::cli'
  Chef::Nexus.ensure_nexus_available(node)

  @parsed_id = Chef::Nexus.parse_identifier(new_resource.name)
  @parsed_repository = Chef::Nexus.parse_identifier(new_resource.repository) unless new_resource.repository.nil?

  @current_resource.repository @parsed_repository

  @current_resource
end

action :create do
  unless group_repository_exists?(@current_resource.name)
    Chef::Nexus.nexus(node).create_group_repository(new_resource.name, nil, nil)
    new_resource.updated_by_last_action(true)
  end
end

action :delete do
  if group_repository_exists?(@current_resource.name)
    Chef::Nexus.nexus(node).delete_group_repository(@parsed_id)
    new_resource.updated_by_last_action(true)
  end
end

action :add_to do
  unless repository_in_group?(@current_resource.name, @current_resource.repository)
    Chef::Nexus.nexus(node).add_to_group_repository(@parsed_id, @parsed_repository)
    new_resource.updated_by_last_action(true)
  end
end

action :remove_from do
  if repository_in_group?(@current_resource.name, @current_resource.repository)
    Chef::Nexus.nexus(node).remove_from_group_repository(@parsed_id, @parsed_repository)
    new_resource.updated_by_last_action(true)
  end
end

private

def group_repository_exists?(name)
  begin
    Chef::Nexus.nexus(node).get_group_repository(name)
    true
  rescue NexusCli::RepositoryNotFoundException => e
    return false
  end
end

def repository_in_group?(repository_name, repository_to_check)
  Chef::Nexus.nexus(node).repository_in_group?(repository_name, repository_to_check)
end
