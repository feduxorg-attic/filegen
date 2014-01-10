# encoding: utf-8
require 'spec_helper' 

describe Filegen::Data do
  context '#instance_binding' do
    it 'let you access environment variables' do
      in_environment 'MY_NAME' => 'Karl' do
        data = Filegen::Data.new
        result = eval('lookup("MY_NAME")', data.instance_binding)
        expect(result).to eq('Karl')
      end
    end
  end

  context '#lookup' do
    it 'let you access environment variables' do
      in_environment 'MY_NAME' => 'Karl' do
        data = Filegen::Data.new
        expect(data.lookup('MY_NAME')).to eq('Karl')
      end
    end

    it 'let you access yaml data' do
      yaml_file = create_file('yaml_file.yaml', <<-EOF.strip_heredoc
        ---
        yaml_name: Karl
      EOF
                 )

      data = Filegen::Data.new(yaml_file: yaml_file)
      expect(data.lookup('yaml_name')).to eq('Karl')
    end

    it 'takes env var first' do
      yaml_file = create_file('yaml_file.yaml', <<-EOF.strip_heredoc
        ---
        MY_NAME: Egon
      EOF
                 )

      in_environment 'MY_NAME' => 'Karl' do
      data = Filegen::Data.new(yaml_file: yaml_file)
        expect(data.lookup('MY_NAME')).to eq('Karl')
      end

      in_environment 'NO' => 'NO' do
        data = Filegen::Data.new(yaml_file: yaml_file)
        expect(data.lookup('MY_NAME')).to eq('Egon')
      end
    end
  end
end
