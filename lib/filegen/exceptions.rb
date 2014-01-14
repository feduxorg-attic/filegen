# encoding: utf-8
module Filegen
  # Exceptions
  module Exceptions
    # raised if order arguments are invalid
    class InvalidDataSources < Exception; end

    # raised if one forgot to tell the script the template name
    class MissingTemplate < Exception; end
  end
end
