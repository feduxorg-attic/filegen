# encoding: utf-8
module Filegen
  # Methods for ui
  module Ui
    @logger = ::Logger.new($stderr)
    @logger.formatter = proc { |severity, datetime, _, msg|
      sprintf("%s %s: %s\n", datetime, severity, msg)
    }

    class << self
      attr_reader :logger

      # Output warnings
      def warning(*args)
        logger.warn(*args)
      end

      # Output messages
      def message(*args)
        logger.info(*args)
      end

      # Output errors
      def error(*args)
        logger.error(*args)
      end
    end
  end
end
