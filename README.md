# Filegen

[![Build Status](https://travis-ci.org/dg-vrnetze/filegen.png?branch=master)](https://travis-ci.org/dg-vrnetze/filegen)
[![Code Climate](https://codeclimate.com/github/dg-vrnetze/filegen.png)](https://codeclimate.com/github/dg-vrnetze/filegen)
[![Coverage Status](https://coveralls.io/repos/dg-vrnetze/filegen/badge.png?branch=master)](https://coveralls.io/r/dg-vrnetze/filegen?branch=master)
[![Gem Version](https://badge.fury.io/rb/filegen.png)](http://badge.fury.io/rb/filegen)

Have you ever felt the need to generate files based on environment variables or
yaml files? If your answer is yes, then `filegen` can be quite helpful for
you. If your answer is no, than sorry Ma'am, this gem is not for you.

## Installation

Add this line to your application's Gemfile:

    gem 'filegen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filegen

This gem ships with an executable called `filegen`. It makes the power of ERB
available on the commandline.

## Usage on Commandline

### General advice

Please make sure you have an ERB-template available. It needs to end with
`.erb`! Place in anywhere you like. It's important that the name of variable in
the template matches the name of environment variable or yaml-key: wording,
case. The lookup is case-sensitive. If you want to write the output to a file
you need to redirect stdout with `>`. Otherwise it will output the content on
`$stdout`.

### Variable lookup

If you want to get access to the variable, you need to use the `lookup`-method.

```ruby
# look up variable
lookup(<variable>)
```

The `lookup`-method will return an empty string '' if a variable cannot be
looked up. If a default value is given it will return the default value instead
of the empty string.

```ruby
# look up variable and use default value if variable is undefined
lookup(<variable>, <default_value>)
```

The default order of data sources to lookup a variable, is: 1st environment
variable and 2nd yaml file. The yaml file needs be given as command line argument
see below at [Generate a file based on YAML file](#yaml).

The order of data sources can be changed by using:

```
--data-sources env,yaml
--data-sources yaml,env
```

A short cut for `--data-sources` is `-d`. This option can also be used to ommit
a data source. But it makes sense only for the enviroment data source today,
because the yaml data source is only added if a yaml file name is given on the
commandline

```
--data-sources yaml
```

### Generate a file based on Environment Variables

The content of `template.erb`:

```erb
Hello my name is: <%= lookup('NAME') %>
```

After that you can use it with filegen.

```bash
NAME=Karl filegen template.erb > file
```

And get the following result.

```text
Hello my name is: Karl
```

### Generate a file based on YAML file
<a id="yaml"></a>

The content of `template.erb`:

```erb
Hello my name is: <%= lookup('NAME') %>
```

Additionally you need to create a `YAML`-file - e.g. `names.yaml`.

```yaml
---
NAME: Karl
```

After that you can use it with filegen.

```bash
#short format
filegen -y names.yaml template.erb > file

#long format
filegen --yaml-file names.yaml template.erb > file
```

And get the following result. 

```text
Hello my name is: Karl
```

## Usage within ruby

### Hash with Symbol-Keys

```ruby
require 'filegen'
require 'stringio'

template = <<-EOS
Hi <%= lookup('name') %>
EOS

data = {
  name: 'Karl'
}

generator = Filegen::Rubygen.new
puts generator.run(template, data)

# => Hi Karl
```

### Hash with String-Keys

```ruby
require 'filegen'
require 'stringio'

template = <<-EOS
Hi <%= lookup('name') %>
EOS

data = {
  'name' => 'Karl'
}

generator = Filegen::Rubygen.new
puts generator.run(template, data)

# => Hi Karl
```

## Use Cases

### RPM packaging

Say you would like to package a ruby-based application for a rpm-based
distribution. You can build a rpm package for each gem it depends on or build
one rpm for the whole application containing all needed gems. After using the
first approach at first I switched to the second one at last: No need to care
about different version of one rubygem as dependency of different applications.

To make this possible I decided to use a small wrapper which sets all
neccessary paths: `GEM_PATH`, `GEM_ROOT` and `GEM_HOME`. After that it executes
the ruby application. Because every application resists below a different path,
I needed to generate a different wrapper for each application. For this I use
this small template:

```erb
#!/usr/bin/env bash

export GEM_ROOT='<%= lookup('SOFTWARE_LIB') %>'
export GEM_PATH='<%= lookup('SOFTWARE_LIB') %>'
export GEM_HOME='<%= lookup('SOFTWARE_LIB') %>'

exec <%= lookup('SOFTWARE_BINARY') %> $*
```

The wrapper is then generated within the rpm spec:

```
SOFTWARE_BINARY=<path to rubygems bin> SOFTWARE_LIB=<library_path> filegen gem.erb > <wrapper>
chmod +x <wrapper>
```

## Future

* Maybe I will add additional data sources.

## Contributing

Please have a look at the {file:README.DEVELOPER.md developer readme}
