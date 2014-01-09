# Filegen

Have you ever felt the need to generate files based on environment variables or
some other data sources? If your answer is yes, then `filegen` can be quite
helpful for you. If your answer is no, than sorry Ma'am, you can browse on.

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

### Generate a file

Please make sure you have an ERB-template available. It needs to end with `.erb`!


*Source*

```
Hello my name is: <%= name %>
```

```bash
NAME=Karl filegen template.erb > file
```

*Result*

```
Hello my name is: Karl
```

## Future

* Add support for other backends via `moneta` (https://github.com/minad/moneta)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
