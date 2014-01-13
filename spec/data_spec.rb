# encoding: utf-8
require 'spec_helper'

describe Filegen::Data do
  context '#instance_binding' do
    it 'let you variables' do
      source = double('DataSource')
      expect(source).to receive(:fetch).with('MY_NAME').and_return('Karl')

      data = Filegen::Data.new(source)
      # rubocop:disable Eval
      result = eval('lookup("MY_NAME")', data.instance_binding)
      # rubocop:enable Eval
      expect(result).to eq('Karl')
    end
  end

  context '#lookup' do
    it 'provides access to variables' do
      source = double('DataSource')
      expect(source).to receive(:fetch).with('MY_NAME').and_return('Karl')

      data = Filegen::Data.new(source)
      expect(data.lookup('MY_NAME')).to eq('Karl')
    end

    it 'supports multiple data sources: first has match' do
      source1 = double('DataSource1')
      expect(source1).to receive(:fetch).with('MY_NAME').and_return('Egon')

      source2 = double('DataSource2')
      expect(source2).not_to receive(:fetch)

      data = Filegen::Data.new([source1, source2])
      expect(data.lookup('MY_NAME')).to eq('Egon')
    end

    it 'supports multiple data sources: last has match' do
      source1 = double('DataSource1')
      expect(source1).to receive(:fetch).with('MY_NAME').and_return(nil)

      source2 = double('DataSource2')
      expect(source2).to receive(:fetch).with('MY_NAME').and_return('Egon')

      data = Filegen::Data.new([source1, source2])
      expect(data.lookup('MY_NAME')).to eq('Egon')
    end

    it 'returns "" if none matches' do
      source1 = double('DataSource1')
      expect(source1).to receive(:fetch).with('MY_NAME').and_return(nil)

      source2 = double('DataSource2')
      expect(source2).to receive(:fetch).with('MY_NAME').and_return(nil)

      data = Filegen::Data.new([source1, source2])
      expect(data.lookup('MY_NAME')).to eq('')
    end
  end
end
