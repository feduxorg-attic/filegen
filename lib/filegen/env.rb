# encoding: utf-8
module Filegen
  class Env
    ENV.to_hash.each do |name,value|
      define_method name.downcase.gsub(/[^a-z0-9]/, '_').to_sym do
        value
      end
    end

    def my_binding
      binding
    end
  end
end
