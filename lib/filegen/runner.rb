# encoding: utf-8
module Filegen
  class Runner
    attr_reader :options, :generator

    def initialize(argv, stdin=$stdin, stdout=$stdout, stderr=$stderr, kernel=Kernel)
      $stdin, $stdout, $stderr, @kernel = stdin, stdout, stderr, kernel

      @options = Options.new(argv)
      @generator = ErbGenerator.new(Data.new)
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

    private

    def parse_options
      params = {}
      parser = OptionParser.new 

      parser.on("-n") { params[:line_numbering_style] ||= :all_lines         }
      parser.on("-b") { params[:line_numbering_style]   = :significant_lines }
      parser.on("-s") { params[:squeeze_extra_newlines] = true               }

      files = parser.parse(argv)

      [params, files]
    end

  end
end
