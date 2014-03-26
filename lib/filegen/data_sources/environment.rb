# encoding: utf-8
module Filegen
  module DataSources
    # Data source which makes environment variables available
    class Environment

      private

      attr_reader :source

      public

      # Create data source
      def initialize
        @source = HashWithIndifferentAccess.new(ENV.to_hash)
      end

      def fetch(key, default_value = nil)
        source[key.to_sym] || source[key.to_s] || default_value
      end
    end
  end
end
