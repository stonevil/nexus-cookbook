class Chef
  module Nexus
    class NexusError < StandardError; end

    class EncryptedDataBagNotFound < NexusError
      def initialize(data_bag_item)
        @data_bag_item = data_bag_item
      end

      def message
        "Unable to locate the Nexus encrypted data bag '#{DEFAULT_DATABAG}' or data bag item #{@data_bag_item}"
      end
    end

    class InvalidDataBagItem < NexusError
      def initialize(data_bag, missing)
        @data_bag = data_bag
        @missing = missing
      end

      def message
        "Your data bag '#{@data_bag}' is missing a #{@missing} element."
      end
    end
  end
end
