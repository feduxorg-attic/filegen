# encoding: utf-8
require 'spec_helper'

describe ErbGenerator do
  context '#compile' do
    it 'needs a source and a target' do
      data = double('binding')
      allow(data).to receive(:instance_binding) do
        Class.new do
          def name
            'Karl'
          end

          def instance_binding
            binding
          end
        end.new.instance_binding
      end

      source = double('source')
      allow(source).to receive(:encoding)
      allow(source).to receive(:read).and_return('Hello <%= name %>')

      destination = double('destination')
      expect(destination).to receive(:puts).with('Hello Karl')

      gen = ErbGenerator.new(data)
      gen.compile(source, destination)
    end
  end
end

