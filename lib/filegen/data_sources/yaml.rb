module Filegen
  module DataSources
    class Yaml
      extend Forwardable

      def_delegator :@source, :fetch, :fetch

      def initialize(file)
        @source = Moneta.new(:YAML, file: file)
      end
    end
  end
end
