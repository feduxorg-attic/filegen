# encoding: utf-8
module Filegen
  class Data

    def initialize
      define_methods_for_env_vars
    end

    def instance_binding
      binding
    end

    private

    def define_methods_for_env_vars
      ENV.to_hash.each do |name,value|
        self.class.send(:define_method, sanitize_method_name(name)) do
          value
        end
      end
    end

    def sanitize_method_name(name)
      name.downcase.gsub(/[^a-z0-9]/, '_').to_sym
    end
  end
end
