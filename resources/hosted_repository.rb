actions :create, :delete, :update
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :publisher, :kind_of => [TrueClass, FalseClass], :default => nil
attribute :policy, :kind_of => String, :default => nil
