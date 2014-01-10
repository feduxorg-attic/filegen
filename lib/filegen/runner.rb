# encoding: utf-8
module Filegen
  class Runner
    attr_reader :options, :generator

    def initialize(argv, stdin=$stdin, stdout=$stdout, stderr=$stderr, kernel=Kernel)
      $stdin, $stdout, $stderr, @kernel = stdin, stdout, stderr, kernel

      @options   = Options.new(argv)
      @generator = ErbGenerator.new(Data.new(@options.data_sources))
    end

    def execute!
      begin
        generator.compile(options.source, options.destination)
        exitstatus = 0
      rescue RuntimeError => e
        $stderr.puts e.message
        exitstatus = 1
      end

      @kernel.exit(exitstatus)
    end
  end
end
