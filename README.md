# Filegen

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

## Usage

### General advice

Please make sure you have an ERB-template available. It needs to end with
`.erb`! Place in anywhere you like. It's important that the name of variable in
the template matches the name of environment variable or yaml-key: wording,
case. The lookup is case-sensitive. If you want to get access to the variable,
you need to use the `lookup`-method.

```
lookup(<variable>)
```

If you want to write the output to a file you need
to redirect stdout with `>`. Otherwise it will output the content on `$stdout`.

### Variable lookup

The default order of data sources to lookup a variable,  is: 1st environment
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

## Future

* Maybe I will add additional data sources. Please see the
  [Moneta](https://github.com/minad/moneta)-gem for possible candidates.

## Contributing

Please have a look at the {file:README.DEVELOPER.md developer readme}
