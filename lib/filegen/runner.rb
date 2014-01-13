# encoding: utf-8
module Filegen
  # Commandline from end
  class Runner
    private

    attr_reader :options, :generator

    public

    # Create runner
    # @param [Array] argv
    #  Commandline arguments
    # @param [IO] stdin
    #  Stdin
    # @param [IO] stdout
    #  Stdout
    # @param [IO] stderr
    #  Stderr
    # @param [Kernel] kernel
    #  Kernel class
    def initialize(argv, stdin=$stdin, stdout=$stdout, stderr=$stderr, kernel=Kernel)
      $stdin, $stdout, $stderr, @kernel = stdin, stdout, stderr, kernel

      @options   = Options.new(argv)
      @generator = ErbGenerator.new(Data.new(@options.data_sources))
    end

    # Execute runner
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
