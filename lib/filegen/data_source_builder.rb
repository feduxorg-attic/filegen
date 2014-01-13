# encoding: utf-8
module Filegen
  # Build data sources
  class DataSourceBuilder

    private

    attr_reader :params

    public

    # @!attribute [r] sources
    #   Return the sources generated
    attr_reader :sources

    # Create the data source builder
    #
    # @param [OpenStruct] params
    #   the params instance which contains all parameter of the commandline utility
    def initialize(params)
      @params = params

      validate_data_sources

      @sources = []
      chosen_data_sources.each do |o|
        @sources << known_data_source_builders[o]
      end
    end

    private

    def chosen_data_sources
      params.data_sources
    end

    def known_data_source_builders
      params.data_source_builders
    end

    def allowed_data_sources
      known_data_source_builders.keys
    end

    def validate_data_sources
      invalid_data_sources = chosen_data_sources - allowed_data_sources
      fail Exceptions::InvalidDataSources, "Unknown data source#{invalid_data_sources.size > 1 ? 's' : ''} \"#{invalid_data_sources.join(', ')}\" found." unless invalid_data_sources.empty?
    end
  end
end
