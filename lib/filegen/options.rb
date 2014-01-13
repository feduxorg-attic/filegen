# encoding: utf-8
module Filegen
  class Options

    private

    attr_reader :params

    public

    def initialize(argv)
      @params = parse_options(argv)
    end

    def source
      validate_source

      File.new(params.template)
    end

    def destination
      $stdout
    end

    def data_sources
      DataSourceBuilder.new(params).sources
    end

    private

    def parse_options(argv)
      params = OpenStruct.new
      parser = OptionParser.new 

      params.data_sources = [:env]
      params.data_source_builders = {}
      params.data_source_builders[:env]  = DataSources::Environment.new

      parser.on('-y', '--yaml-file FILE', 'YAML-file to look for variables') do |f|
        params.yaml_file = f 
        params.data_sources << :yaml
        params.data_source_builders[:yaml] = DataSources::Yaml.new(params.yaml_file)
      end

      parser.on('-d', '--data-sources a,b', Array,  'Order for variable lookup: yaml, env (default: env or env,yaml if yaml-file-option is given)') do |l| 
        params.data_sources = l.map(&:to_sym)
      end

      parser.on_tail('-h', '--help', 'Show this message') do
        $stderr.puts parser
        exit
      end

      parser.on_tail('-v', '--version', 'Show version') do
        $stderr.puts Filegen::VERSION
        exit
      end

      params.template = parser.parse(argv).first

      params
    end

    def validate_source
      fail "File \"#{params.template}\" does not exist" unless exists?
      fail "File \"#{params.template}\" is not a valid erb template: file ending erb" unless erb_template?
    end

    def exists?
      File.exists?(params.template)
    end

    def erb_template?
      /.erb$/ === File.basename(params.template)
    end
  end
end
