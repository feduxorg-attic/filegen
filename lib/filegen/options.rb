# encoding: utf-8
module Filegen
  class Options
    attr_reader :template

    def initialize(argv)
      @template = argv.first.to_s
    end

    def source
      validate_source

      File.new(template)
    end

    def destination
      $stdout
    end

    private

    def validate_source
      fail "File \"#{template}\" does not exist" unless exists?
      fail "File \"#{template}\" is not a valid erb template: file ending erb" unless erb_template?
    end

    def exists?
      File.exists?(template)
    end

    def erb_template?
      /.erb$/ === File.basename(template)
    end
  end
end
