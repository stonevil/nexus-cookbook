actions :set_level
default_action :set_level

attribute :level, :kind_of => String, :name_attribute => true, :equal_to => ['debug', 'error', 'info'], :default => 'info'
