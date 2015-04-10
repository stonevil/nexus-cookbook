actions :create, :delete, :add_to, :remove_from
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :repository, :kind_of => String
