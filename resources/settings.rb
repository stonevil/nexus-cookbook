actions :update
default_action :update

attribute :path, :kind_of  => String, :name_attribute => true
attribute :value, :kind_of => [String, TrueClass, FalseClass], :required => true
