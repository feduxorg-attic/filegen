# encoding: utf-8
module Filegen
  # Used to generate the template
  class ErbGenerator
    private

    attr_reader :data

    public

    # Create erb generator
    #
    # @param [Data] data
    #   The data class to be used within the template
    def initialize(data)
      @data = data
    end

    # Compile the template
    #
    # @param [IO] source
    #   The source template to be used
    # @param [IO] destination
    #   The output io handle
    def compile(source, destination)
      erb = ERB.new(source.read)
      destination.puts erb.result(data.instance_binding)
    end
  end
end
