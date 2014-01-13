module Filegen
  module DataSources
    class Environment
      extend Forwardable

      def_delegator :@source, :fetch, :fetch

      def initialize
        @source = Moneta.build do 
          use :Transformer, :key => :to_s, :value => []
          adapter :Memory, backend: ENV
        end
      end
    end
  end
end
