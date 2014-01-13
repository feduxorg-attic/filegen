$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'debugger'
require 'pry'

require 'simplecov'
SimpleCov.command_name 'cucumber'

require 'filegen'
include Filegen

require 'aruba'
require 'aruba/in_process'
require 'aruba/cucumber'

Aruba::InProcess.main_class = Filegen::Runner
Aruba.process = Aruba::InProcess
