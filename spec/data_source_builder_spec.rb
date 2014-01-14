# encoding: utf-8
require 'spec_helper'

describe DataSourceBuilder do
  context '#sources' do
    it 'returns data sources' do
      yaml_builder = double('yaml_builder')
      env_builder = double('env_builder')

      params = double('params')
      allow(params).to receive(:data_sources).and_return([:yaml, :env])
      allow(params).to receive(:data_source_builders).and_return(yaml: yaml_builder, env: env_builder)
      allow(params).to receive(:yaml_file).and_return('')

      expect { DataSourceBuilder.new(params) }.not_to raise_error
    end

    it 'raises an exception on invalid input' do
      params = double('params')
      allow(params).to receive(:data_sources).and_return([:yaml, 'garbage'])
      allow(params).to receive(:data_source_builders).and_return({})
      allow(params).to receive(:yaml_file).and_return('')

      expect { DataSourceBuilder.new(params) }.to raise_error Exceptions::DataSourcesAreInvalid
    end

    it 'supports order of data sources: env first' do
      yaml_builder = double('yaml_builder')
      env_builder = double('env_builder')

      params = double('params')
      allow(params).to receive(:data_sources).and_return([:env, :yaml])
      allow(params).to receive(:data_source_builders).and_return(yaml: yaml_builder, env: env_builder)
      allow(params).to receive(:yaml_file).and_return('')

      builder = DataSourceBuilder.new(params)
      expect(builder.sources.first).to be(env_builder)
    end

    it 'supports order of data sources: yaml first' do
      yaml_builder = double('yaml_builder')
      env_builder = double('env_builder')

      params = double('params')
      allow(params).to receive(:data_sources).and_return([:yaml, :env])
      allow(params).to receive(:data_source_builders).and_return(yaml: yaml_builder, env: env_builder)
      allow(params).to receive(:yaml_file).and_return('')

      builder = DataSourceBuilder.new(params)
      expect(builder.sources.first).to be yaml_builder
    end
  end
end
