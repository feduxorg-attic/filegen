# encoding: utf-8
module Filegen
  class Data

    private

    attr_reader :data_sources

    public

    def initialize(data_sources)
      @data_sources = Array(data_sources)
    end

    def lookup(variable)
      try_to_fetch_unless_found_or_end(variable)
    end

    def instance_binding
      binding
    end

    private

    def try_to_fetch_unless_found_or_end(variable)
      result = nil

      data_sources.each do |s|
        (result = s[variable] ) && (return result)
      end

      ''
    end
  end
end
