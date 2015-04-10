actions :create, :delete, :update
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :url, :kind_of  => String, :required => true
attribute :policy, :kind_of  => String, :default => nil
attribute :publisher, :kind_of => [TrueClass, FalseClass], :default => nil
attribute :subscriber, :kind_of => [TrueClass, FalseClass], :default => nil
attribute :preemptive_fetch, :kind_of => [TrueClass, FalseClass], :default => false
