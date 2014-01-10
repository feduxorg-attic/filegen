require 'spec_helper'

describe DataSourceBuilder do
  context '#sources' do
    it 'returns data sources' do
      params = double('params')
      allow(params).to receive(:order).and_return(['yaml', 'env'])
      allow(params).to receive(:yaml_file).and_return('')

      expect { DataSourceBuilder.new(params) }.not_to raise_error
    end

    it 'raises an exception on invalid input' do
      params = double('params')
      allow(params).to receive(:order).and_return(['yaml', 'garbage'])
      allow(params).to receive(:yaml_file).and_return('')

      expect { DataSourceBuilder.new(params) }.to raise_error Exceptions::InvalidOrderArgument
    end

    it 'supports order of data sources: env first' do
      params = double('params')
      allow(params).to receive(:order).and_return(['env', 'yaml'])
      allow(params).to receive(:yaml_file).and_return('')

      builder = DataSourceBuilder.new(params)
      expect(builder.sources.first).to be_kind_of DataSources::Environment
    end

    it 'supports order of data sources: yaml first' do
      params = double('params')
      allow(params).to receive(:order).and_return(['yaml', 'env'])
      allow(params).to receive(:yaml_file).and_return('')

      builder = DataSourceBuilder.new(params)
      expect(builder.sources.first).to be_kind_of DataSources::Yaml
    end
  end
end
