# encoding: utf-8
module Filegen
  class Rubygen

    def run(source, data)
      result = StringIO.new
      source = StringIO.new(source)

      begin
        generator = ErbGenerator.new(Data.new([HashWithIndifferentAccess.new(data)]))
        generator.compile(source, result)
      rescue RuntimeError => e
        Filegen::Ui.error e.message
      rescue Interrupt
        Filegen::Ui.warning 'You told me to stop command execution.'
      rescue Exceptions::ErbTemplateHasSyntaxErrors => e
        Filegen::Ui.error "Syntax error in ERB-Template: \n" + e.message
      end

      result.string
    end
  end
end
