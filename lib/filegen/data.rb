# encoding: utf-8
# Main Class
module Filegen
  # This class is used as context for the erb-template
  class Data
    private

    attr_reader :data_sources

    public

    # Create context class
    #
    # @param [Array,DataSource] data_sources
    #   The data sources which should be available for variable lookup
    def initialize(data_sources)
      @data_sources = Array(data_sources)
    end

    # Lookup a variable within the data sources
    #
    # @param [String] variable
    #   The variable to lookup
    # @return [String]
    #   The value of the variable
    def lookup(variable)
      try_to_fetch_unless_found_or_end(variable)
    end

    # Make the binding of the class available
    # @return [Binding]
    def instance_binding
      binding
    end

    private

    def try_to_fetch_unless_found_or_end(variable)
      result = nil

      data_sources.each do |s|
        (result = s.fetch(variable)) && (return result)
      end

      ''
    end
  end
end
