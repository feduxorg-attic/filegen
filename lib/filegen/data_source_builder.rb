module Filegen
  class DataSourceBuilder

    attr_reader :sources

    def initialize(params)
      @sources = []
      @sources << DataSources::Environment.new
      @sources << DataSources::Yaml.new(params.yaml_file) if params.yaml_file
    end
  end
end
