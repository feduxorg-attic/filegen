# encoding: utf-8
module Filegen
  class Options
    attr_reader :template

    def initialize(argv)
      @template = argv.first.to_s
    end

    def source
      return File.read(template) if valid_template?

      fail "File does not exist or is not a erb file!"
    end

    def destination
      $stdout
    end

    def valid_template?
      File.exists?(template) && /.erb$/ === File.basename(template)
    end
  end
end
