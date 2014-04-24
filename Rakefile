#!/usr/bin/env rake

#require 'bundler'
#Bundler.require :default, :test, :development

require 'filegen'
require 'fedux_org/stdlib/rake'
require 'active_support/core_ext/string/inflections'
require 'open3'

def software
  gemspec.name
end

def gemspec
  eval File.read(Dir.glob(File.join(File.expand_path('../', __FILE__), '*.gemspec')).first)
end

def version
  require "#{software}/version"
  "#{software.camelcase}::VERSION".constantize
end

def root_directory
  ::File.expand_path('../', __FILE__)
end

def tar_file
  ::File.join(pkg_directory, "#{software}-#{version}.tar.gz")
end

def tmp_directory
  ::File.join(root_directory, 'tmp', "#{software}-#{version}")
end

def archlinux_build_directory
  ::File.join(root_directory, 'share', 'archlinux')
end

def gem_file
  ::File.join(root_directory, 'pkg', "#{software}-#{version}.gem")
end

def pkg_directory
  ::File.join(root_directory, 'pkg')
end

def gem_directory
  ::File.join(root_directory, 'vendor', 'cache')
end

task :default => 'gem:build'

file gem_file => 'gem:build'

file tmp_directory do
  FileUtils.mkdir_p tmp_directory
end

file archlinux_build_directory do
  FileUtils.mkdir_p archlinux_build_directory
end

def extract_sha
  %x[makepkg -g 2>/dev/null].split(/\n/).find { |l| l =~ /sha256/ }
end

namespace :package do
  desc 'build arch linux package'
  task :archlinux => [gem_file, archlinux_build_directory] do
    FileUtils.mv ::File.join(pkg_directory, "#{software}-#{version}.gem"), archlinux_build_directory

    generator = Filegen::Rubygen.new
    template = File.read(File.expand_path('../share/archlinux/PKGBUILD.sh.erb', __FILE__))
    build_file = File.expand_path('../share/archlinux/PKGBUILD', __FILE__)

    data = { 
      sha: nil, 
      version: version,
    }

    Dir.chdir(archlinux_build_directory) do
      File.open(build_file, 'w') do |f|
        f.write generator.run(template, data )
      end

      data = {
        sha: extract_sha,
        version: version,
      }

      File.open(build_file, 'w') do |f|
        f.write generator.run(template, data)
      end

      sh "makepkg -f"
    end
  end
end

require 'coveralls/rake/task'
Coveralls::RakeTask.new

namespace :test do
  desc 'Test with coveralls'
  task :coveralls => ['test:rspec', 'test:cucumber', 'coveralls:push']
end
