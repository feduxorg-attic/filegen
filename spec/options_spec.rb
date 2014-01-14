# encoding: utf-8
require 'spec_helper'

describe Options do
  context '#destination' do
    it 'returns an io handle' do
      template_file = create_file('template.erb')
      options = Options.new([template_file])
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
      expect { Options.new(['template_file']) }.to raise_error Exceptions::TemplateDoesNotExist
    end

    it 'raises an exception if file does not have a erb-extension' do
      template_file = create_file('template')
      expect { Options.new([template_file]) }.to raise_error Exceptions::TemplateNameIsInvalid
    end
  end
end
