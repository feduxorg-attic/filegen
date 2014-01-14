# encoding: utf-8
require 'erb'
require 'moneta'
require 'optparse'
require 'forwardable'
require 'ostruct'
require 'logger'

require 'filegen/version'
require 'filegen/ui'
require 'filegen/runner'
require 'filegen/options'
require 'filegen/data'
require 'filegen/erb_generator'
require 'filegen/data_source_builder'
require 'filegen/data_sources/environment'
require 'filegen/data_sources/yaml'
require 'filegen/exceptions'

# Main class
module Filegen; end
