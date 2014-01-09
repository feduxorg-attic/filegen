# encoding: utf-8
require 'spec_helper'

describe Options do
  context '#destination' do
    it 'returns an io handle' do
      options = Options.new([])
      expect(options.destination).to respond_to(:puts)
    end
  end

  context '#source' do
    it 'returns an io handle' do
      template_file = create_file('template.erb')

      options = Options.new([template_file])
      expect(options.source).to respond_to(:read)
    end

    it 'raises an exception if file does not exist' do
      options = Options.new(['template_file'])
      expect { options.source }.to raise_error RuntimeError
    end

    it 'raises an exception if file does not have a erb-extension' do
      template_file = create_file('template')

      options = Options.new([template_file])
      expect { options.source }.to raise_error RuntimeError
    end
  end
end
