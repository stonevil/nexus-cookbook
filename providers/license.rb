def load_current_resource
  @current_resource = Chef::Resource::NexusLicense.new(new_resource.name)

  run_context.include_recipe 'nexus::cli'
  Chef::Nexus.ensure_nexus_available(node)

  @current_resource
end

action :install do

  unless licensed? && running_nexus_pro?
    data_bag_item = Chef::Nexus.get_license(node)
    license_data = Chef::Nexus.decode(data_bag_item[:file])
    Chef::Nexus.nexus(node).install_license_bytes(license_data)
    new_resource.updated_by_last_action(true)
  end
end

private

def licensed?
  require 'json'
  json = JSON.parse(Chef::Nexus.nexus(node).get_license_info)
  json['data']['licenseType'] != 'Not licensed'
end

def running_nexus_pro?
  Chef::Nexus.nexus(node).running_nexus_pro?
end
