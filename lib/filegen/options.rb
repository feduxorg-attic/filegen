# encoding: utf-8
module Filegen
  class Options
    attr_reader :template

    def initialize(argv)
      @template = argv.first.to_s
    end

    def source
      return File.read(template) if valid_template?

      fail "File \"#{template}\" does not exist" unless exists?
      fail "File \"#{template}\" is not a valid erb template: file ending erb" unless erb_template?
      fail "Unkonwn error"
    end

    def destination
      $stdout
    end

    private

    def exists?
      File.exists?(template)
    end

    def erb_template?
      /.erb$/ === File.basename(template)
    end

    def valid_template?
      exists? && erb_template?
    end
  end
end
