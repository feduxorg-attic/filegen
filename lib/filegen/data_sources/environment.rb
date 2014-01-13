# encoding: utf-8
module Filegen
  module DataSources
    # Data source which makes environment variables available
    class Environment
      extend Forwardable

      # @!method fetch(key, default_value=nil)
      #    Fetch value for key from data source
      def_delegator :@source, :fetch, :fetch

      # Create data source
      def initialize
        @source = Moneta.build do 
          use :Transformer, :key => :to_s, :value => []
          adapter :Memory, backend: ENV
        end
      end
    end
  end
end
