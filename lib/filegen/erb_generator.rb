# encoding: utf-8
module Filegen
  class ErbGenerator

    private

    attr_reader :data

    public

    def initialize(data)
      @data = data
    end

    def compile(source, destination)
      erb = ERB.new(source.read)
      destination.puts erb.result(data.instance_binding)
    end
  end
end
