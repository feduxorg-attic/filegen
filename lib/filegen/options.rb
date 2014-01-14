# encoding: utf-8
module Filegen
  # Commandline parser
  class Options
    private

    attr_reader :params

    public

    # Create commandline parser
    #
    # @param [Array] argv
    #   The array which contains the commandline arguments
    def initialize(argv)
      @params = parse_options(argv)

      validate_params
    end

    # Source template
    #
    # @return [File]
    #   Returns a file handle for the template
    def source
      File.new(params.template)
    end

    # Destination for output
    #
    # @return [IO]
    #   Returns a file handle for the output
    def destination
      $stdout
    end

    # The data sources which can be used
    #
    # @return [Array]
    #   An array of data sources which can be used
    def data_sources
      DataSourceBuilder.new(params).sources
    end

    private

    def validate_params
      validate_source
    end

    # rubocop:disable MethodLength
    def parse_options(argv)
      params = OpenStruct.new
      parser = OptionParser.new

      parser.banner = 'Usage: filegen [options] <template>'

      parser.separator ''
      parser.separator 'Specific options:'

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

      parser.separator ''
      parser.separator 'Common options:'

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
    # rubocop:enable MethodLength

    def validate_source
      fail 'Template file name is missing.' if empty?
      fail "File \"#{params.template}\" does not exist" unless exists?
      fail "File \"#{params.template}\" is not a valid erb template: file ending erb" unless erb_template?
    end

    def empty?
      params.template.nil?
    end

    def exists?
      File.exists?(params.template)
    end

    def erb_template?
      # rubocop:disable CaseEquality
      /.erb$/ === File.basename(params.template)
      # rubocop:enable CaseEquality
    end
  end
end
