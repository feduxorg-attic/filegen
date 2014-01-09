# encoding: utf-8
require 'spec_helper' 

describe Filegen::Data do
  context '#instance_binding' do
    it 'let you access environment variables' do
      in_environment 'MY_NAME' => 'Karl' do
        data = Filegen::Data.new
        result = eval('my_name', data.instance_binding)
        expect(result).to eq('Karl')
      end
    end
  end

  context '#<var name>' do
    it 'let you access environment variables' do
      in_environment 'MY_NAME' => 'Karl' do
        data = Filegen::Data.new
        expect(data.my_name).to eq('Karl')
      end
    end
  end
end
