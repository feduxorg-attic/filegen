# encoding: utf-8
module Filegen
  module DataSources
    # Data source which makes yaml files available
    class Yaml

      private

      attr_reader :source

      public

      # Create data source
      def initialize(file)
        @source = HashWithIndifferentAccess.new(Psych.load_file(file))
      rescue
        @source = HashWithIndifferentAccess.new
      end

      def fetch(key, default_value = nil)
        source[key.to_sym] || source[key.to_s] || default_value
      end
    end
  end
end
