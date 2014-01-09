$LOAD_PATH.unshift File.expand_path('../lib', __FILE__ )

require "bundler/gem_tasks"
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

task :default => :build

desc 'build tar file'
task :package => [gem_file, tmp_directory] do
  FileUtils.mv File.join(pkg_directory,"#{software}-#{version}.gem"), tmp_directory 

  Dir.chdir('tmp') do
    sh "tar -czf #{tar_file} #{File.basename tmp_directory}"
  end
end

file gem_file => :build

file tmp_directory do
  FileUtils.mkdir_p tmp_directory
end
