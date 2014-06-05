# encoding: utf-8
unless ENV['CI'] == 'true'
  if RUBY_VERSION < '2.0.0'
    require 'debugger'
  else
    require 'byebug'
  end

  require 'pry'
end
