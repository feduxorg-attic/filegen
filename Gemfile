source 'https://rubygems.org'

# use gem spec 
gemspec

group :development, :test do
  if RUBY_VERSION < '2.0.0'
    gem 'pry-debugger', require: false
    gem 'debugger'
    gem 'debugger-completion', require: false
  else
    gem 'pry-byebug', require: false
    gem 'byebug'
  end

  gem 'activesupport', require: false
  gem 'aruba', require: false
  gem 'awesome_print', require: 'ap'
  gem 'bundler', '~> 1.3', require: false
  gem 'coveralls', require: false
  gem 'cucumber', require: false
  gem 'erubis'
  gem 'fedux_org-stdlib', require: false
  gem 'fuubar'
  gem 'github-markup'
  gem 'pry', require: false
  gem 'pry-doc', require: false
  gem 'rake', require: false
  gem 'redcarpet'
  gem 'rspec', require: false
  gem 'rspec-legacy_formatters', require: false
  gem 'rubocop', require: false
  gem 'simplecov'
  gem 'tmrb', require: false
  gem 'versionomy'
  gem 'yard', require: false
end
