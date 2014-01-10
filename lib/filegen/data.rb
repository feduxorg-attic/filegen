# encoding: utf-8
module Filegen
  class Data

    def initialize(options = {})
      @environment = Moneta.new(:Environment)

      if options[:yaml_file]
        @yaml        = Moneta.new(:YAML, file: options[:yaml_file]) 
      else
        @yaml        = Moneta.new(:Null)
      end
    end

    def lookup(variable)
      @environment.fetch(variable, @yaml.fetch(variable, ''))
    end

    def instance_binding
      binding
    end
  end
end
