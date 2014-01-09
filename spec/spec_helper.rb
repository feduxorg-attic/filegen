# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
require 'filegen'

SimpleCov.command_name 'rspec'
Dir.glob(File.expand_path('../support/*.rb', __FILE__)).each { |f| require f }
