module Filegen
  module DataSources
    class Environment
      extend Forwardable

      def_delegator :@source, :fetch, :fetch

      def initialize
        @source = Moneta.new(:Environment)
      end
    end
  end
end
