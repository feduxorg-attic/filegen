# encoding: utf-8
module Filegen
  # Generator for ruby code
  class Rubygen
    # Generate text
    #
    # @param [String] source
    #   The template used
    # @param [Hash] data
    #   The data used within template evaluation
    # @return [String]
    #   The evaluated template
    def run(source, data)
      result = StringIO.new
      source = StringIO.new(source)

      begin
        generator = ErbGenerator.new(Data.new([HashWithIndifferentAccess.new(data)]))
        generator.compile(source, result)
      rescue RuntimeError => e
        Filegen::Ui.error e.message
      rescue Exceptions::ErbTemplateHasSyntaxErrors => e
        Filegen::Ui.error "Syntax error in ERB-Template: \n" + e.message
      end

      result.string
    end
  end
end
