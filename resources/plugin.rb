actions :install
default_action :install

attribute :name, :kind_of => String, :required => true, :name_attribute => true
attribute :plugin_path, :kind_of => String, :required => true
attribute :nexus_path, :kind_of => String, :required => true
