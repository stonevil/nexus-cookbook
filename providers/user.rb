def load_current_resource
  @current_resource = Chef::Resource::NexusUser.new(new_resource.username)
  @current_resource.old_password new_resource.old_password

  run_context.include_recipe 'nexus::cli'
  Chef::Nexus.ensure_nexus_available(node)

  @current_resource
end

action :create do
  unless user_exists?(@current_resource.username)
    create_user
    new_resource.updated_by_last_action(true)
  end
end

action :update do
  if user_exists?(@current_resource.username)
    update_user
    new_resource.updated_by_last_action(true)
  end
end

action :delete do
  if user_exists?(@current_resource.username)
    delete_user
    new_resource.updated_by_last_action(true)
  end
end

action :change_password do
  if old_credentials_equals?(@current_resource.username, @current_resource.old_password)
    change_password
    new_resource.updated_by_last_action(true)
  end
end

private

def user_exists?(username)
  begin
    Chef::Nexus.nexus(node).get_user(username)
    true
  rescue NexusCli::UserNotFoundException => e
    return false
  end
end

def old_credentials_equals?(username, password)
  Chef::Nexus.check_old_credentials(username, password, node)
end

def create_user
  validate_create_user
  Chef::Nexus.nexus(node).create_user(get_params)
end

def update_user
  Chef::Nexus.nexus(node).update_user(get_params(true))
end

def delete_user
  Chef::Nexus.nexus(node).delete_user(new_resource.username)
end

def change_password
  validate_change_password
  Chef::Nexus.nexus(node).change_password(get_password_params)
end

def validate_create_user
  Chef::Application.fatal!('nexus_user create requires an email address.', 1) if new_resource.email.nil?
  Chef::Application.fatal!('nexus_user create requires a enabled.', 1) if new_resource.enabled.nil?
  Chef::Application.fatal!('nexus_user create requires at least one role.', 1) if new_resource.roles.nil? || new_resource.roles.empty?
end

def validate_change_password
  Chef::Application.fatal!('nexus_user change_password requires your old password') if new_resource.old_password.nil?
  Chef::Application.fatal!('nexus_user change_password requires a new password') if new_resource.password.nil?
end

def get_params(update=false)
  params = { :userId => new_resource.username }
  params[:firstName] = new_resource.first_name
  params[:lastName] = new_resource.last_name
  params[:email] = new_resource.email
  if new_resource.enabled.nil? && update
    params[:status] = nil
  else
    params[:status] = new_resource.enabled == true ? 'active' : 'disabled'
  end
  params[:password] = new_resource.password
  params[:roles] = new_resource.roles
  params
end

def get_password_params
  params = { :userId => new_resource.username }
  params[:oldPassword] = new_resource.old_password
  params[:newPassword] = new_resource.password
  params
end
