# encoding: utf-8
module Filegen
  module DataSources
    # Data source which makes yaml files available
    class Yaml
      extend Forwardable

      # @!method fetch(key, default_value=nil)
      #    Fetch value for key from data source.
      def_delegator :@source, :fetch, :fetch

      # Create data source
      def initialize(file)
        @source = Moneta.new(:YAML, file: file)
      end
    end
  end
end
