# encoding: utf-8
require 'spec_helper'

describe DataSources::Environment do
  context '#fetch' do
    it 'retrieves environment variables as string' do
      in_environment 'MY_NAME' => 'Karl' do
        source = DataSources::Environment.new
        expect(source.fetch('MY_NAME')).to eq('Karl')
      end
    end

    it 'retrieves environment variables as symbol' do
      in_environment 'MY_NAME' => 'Karl' do
        source = DataSources::Environment.new
        expect(source.fetch(:MY_NAME)).to eq('Karl')
      end
    end

    it 'returns nil if variable cannot be found' do
      in_environment 'MY_NAME' => 'Karl' do
        source = DataSources::Environment.new
        expect(source.fetch('NOT_MY_NAME')).to be_nil
      end
    end
  end
end
