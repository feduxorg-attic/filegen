# encoding: utf-8
require 'fedux_org/stdlib/filesystem'
include FeduxOrg::Stdlib::Filesystem

def root_directory
  File.expand_path( '../../../', __FILE__ )
end

RSpec.configure do |c|
  c.before(:each) { cleanup_working_directory }
end

