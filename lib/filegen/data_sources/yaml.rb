# encoding: utf-8
module Filegen
  # Data Sources
  module DataSources
    # Data source which makes yaml files available
    class Yaml
      private

      attr_reader :source

      public

      # Create data source
      def initialize(file)
        @source = HashWithIndifferentAccess.new(Psych.load_file(file))
      rescue SystemCallError => e
        # it's bad just silently ignore errors, so we don't
        fail SystemCallError, "File access error, #{e.message}"
      else
        raise
      end

      def fetch(key, default_value = nil)
        source[key.to_sym] || source[key.to_s] || default_value
      end
    end
  end
end
