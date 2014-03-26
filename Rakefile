#!/usr/bin/env rake

require 'bundler'
Bundler.require :default, :test, :development

require 'fedux_org/stdlib/rake'
require 'filegen/version'

def software
  'filegen'
end

def version
  Filegen::VERSION
end

def root_directory
  File.expand_path('../', __FILE__)
end

def tar_file
  File.join(pkg_directory, "#{software}-#{version}.tar.gz")
end

def tmp_directory
  File.join(root_directory, 'tmp', "#{software}-#{version}")
end

def gem_file
  File.join(root_directory, 'pkg', "#{software}-#{version}.gem")
end

def pkg_directory
  File.join(root_directory, 'pkg')
end

def gem_directory
  File.join(root_directory, 'vendor', 'cache')
end

task :default => 'gem:build'

file gem_file => 'gem:build'

file tmp_directory do
  FileUtils.mkdir_p tmp_directory
end

namespace :gem do
  desc 'build tar file'
  task :package => [gem_file, tmp_directory] do
    FileUtils.mv File.join(pkg_directory, "#{software}-#{version}.gem"), tmp_directory 
    FileUtils.mv File.join(gem_directory, "moneta-0.7.20.gem"), tmp_directory 

    Dir.chdir('tmp') do
      sh "tar -czf #{tar_file} #{File.basename tmp_directory}"
    end
  end
end

require 'coveralls/rake/task'
Coveralls::RakeTask.new

namespace :test do
  desc 'Test with coveralls'
  task :coveralls => ['test:rspec', 'test:cucumber', 'coveralls:push']
end
