# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.command_name 'rspec'

require 'filegen'
include Filegen

Dir.glob(File.expand_path('../support/*.rb', __FILE__)).each { |f| require f }
