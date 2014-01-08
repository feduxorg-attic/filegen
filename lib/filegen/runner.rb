# encoding: utf-8
module Filegen
  class Runner
    attr_reader :options, :generator

    def initialize(argv)
      @options = Options.new(argv)
      @generator = ErbGenerator.new(Env.new.my_binding)
    end

    def run
      begin
        generator.compile(options.source,options.destination)
      rescue Exception => e
        puts e.message
        exit 1
      end

      exit 0
    end
  end
end
