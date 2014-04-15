# encoding: utf-8
require 'erb'
require 'optparse'
require 'forwardable'
require 'ostruct'
require 'logger'
require 'active_support/hash_with_indifferent_access'
require 'stringio'
require 'psych'

require 'filegen/version'
require 'filegen/ui'
require 'filegen/runner'
require 'filegen/options'
require 'filegen/data'
require 'filegen/erb_generator'
require 'filegen/data_source_builder'
require 'filegen/data_sources/environment'
require 'filegen/data_sources/yaml'
require 'filegen/rubygen'
require 'filegen/exceptions'

# Main class
module Filegen; end
