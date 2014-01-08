# encoding: utf-8
module Filegen
  class ErbGenerator
    attr_reader :template_binding

    def initialize(template_binding)
      @template_binding = template_binding
    end

    def compile(source,destination)
      destination.puts ERB.new(source).result(template_binding)
    end
  end

end
