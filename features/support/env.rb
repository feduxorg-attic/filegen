# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)

unless ENV['CI'] == 'true'
  if RUBY_VERSION < '2.0.0'
    require 'debugger'
  else
    require 'byebug'
  end

  require 'pry'
end

require 'simplecov'
SimpleCov.command_name 'cucumber'

require 'filegen'
include Filegen

require 'aruba'
require 'aruba/in_process'
require 'aruba/cucumber'

Aruba::InProcess.main_class = Filegen::Runner
Aruba.process = Aruba::InProcess
