# encoding: utf-8
module Filegen
  # Exceptions
  module Exceptions
    # raised if order arguments are invalid
    class DataSourcesAreInvalid < RuntimeError; end

    # raised if one forgot to tell the script the template name
    class TemplateNameIsMissing < RuntimeError; end

    # raised if template given on commandline does not exist
    class TemplateDoesNotExist < RuntimeError; end

    # raised if one uses an invalid template name (missing erb)
    class TemplateNameIsInvalid < RuntimeError; end

    # raised if a given erb template has syntax errors in it
    class ErbTemplateHasSyntaxErrors < Exception; end
  end
end
