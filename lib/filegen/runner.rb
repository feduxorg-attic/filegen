# encoding: utf-8
module Filegen
  # Commandline from end
  class Runner
    private

    attr_reader :argv

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
    def initialize(argv, stdin = $stdin, stdout = $stdout, stderr = $stderr, kernel = Kernel)
      @argv, $stdin, $stdout, Ui.logger, @kernel = argv, stdin, stdout, stderr, kernel
    end

    # Execute runner
    def execute!
      begin
        options   = Options.new(argv)

        generator = ErbGenerator.new(Data.new(options.data_sources))
        generator.compile(options.source, options.destination)

        exitstatus = 0
      rescue Interrupt
        Filegen::Ui.warning 'You told me to stop command execution.'
        exitstatus = 2
      rescue Exceptions::ErbTemplateHasSyntaxErrors => e
        Filegen::Ui.error "Syntax error in ERB-Template: \n" + e.message
        exitstatus = 3
      rescue Exceptions::YamlFileNotFound => e
        Filegen::Ui.error "Yaml-file \"#{JSON.parse(e.message)['file']}\" not found."
        exitstatus = 4
      rescue StandardError => e
        Filegen::Ui.error "#{e.class} - #{e.message}"
        exitstatus = 99
      end

      @kernel.exit(exitstatus)
    end
  end
end
