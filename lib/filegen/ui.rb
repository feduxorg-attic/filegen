# encoding: utf-8
module Filegen
  # Methods for ui
  module Ui
    @logger = ::Logger.new($stderr)

    class << self
      attr_reader :logger

      def formated_logger
        logger.formatter = proc { |severity, datetime, _, msg|
          sprintf("%s %s: %s\n", datetime, severity, msg)
        }

        logger
      end

      def logger=(output = $stderr)
        @logger = ::Logger.new(output)
      end

      # Output warnings
      def warning(*args)
        formated_logger.warn(*args)
      end

      # Output messages
      def message(*args)
        formated_logger.info(*args)
      end

      # Output errors
      def error(*args)
        formated_logger.error(*args)
      end
    end
  end
end
