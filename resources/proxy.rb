actions :enable, :disable, :add_trusted_key, :delete_trusted_key
default_action :enable

attribute :name, :kind_of => String, :name_attribute => true
attribute :id, :kind_of => String
attribute :host, :kind_of => String
attribute :port, :kind_of => Fixnum
attribute :certificate, :kind_of => String
attribute :description, :kind_of => String
