module Filegen
  class DataSourceBuilder

    private

    attr_reader :params

    public

    attr_reader :sources

    def initialize(params)
      @params = params

      @sources = []
      order_arguments.each do |o|
        @sources << known_sources[o]
      end
    end

    private

    def known_sources
      sources = {}
      sources[:env]  = DataSources::Environment.new
      sources[:yaml] = DataSources::Yaml.new(params.yaml_file)

      sources
    end

    def order_arguments
      validate_order_arguments
      prepared_order_arguments
    end

    def prepared_order_arguments
      params.order.map(&:to_sym)
    end

    def allowed_order_arguments
      known_sources.keys
    end

    def validate_order_arguments
      invalid_arguments = prepared_order_arguments - allowed_order_arguments
      fail Exceptions::InvalidOrderArgument, "Unknown order argument(s) \"#{invalid_arguments.join(', ')}\" found." unless invalid_arguments.empty?
    end
  end
end
