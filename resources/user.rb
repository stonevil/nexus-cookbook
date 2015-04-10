actions :create, :update, :delete, :change_password
default_action :create

attribute :username, :kind_of => String, :name_attribute => true
attribute :first_name, :kind_of => String
attribute :last_name, :kind_of => String
attribute :email, :kind_of => String
attribute :enabled, :kind_of => [TrueClass, FalseClass]
attribute :password, :kind_of => String
attribute :old_password, :kind_of => String
attribute :roles, :kind_of => Array, :default => []
