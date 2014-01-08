# encoding: utf-8
module Filegen
  class Runner
    attr_reader :options, :generator

    def initialize(argv)
      @options = Options.new(argv)
      @generator = ErbGenerator.new(Env.new.my_binding)
    end

    def run
      generator.compile(options.source,options.destination)
      exit 0
    end
  end
end
