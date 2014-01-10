# encoding: utf-8
module Filegen
  class Data

    def lookup(variable)
      env_var(variable)
    end

    def instance_binding
      binding
    end

    private

    def env_var(var)
      ENV[var]
    end
  end
end
