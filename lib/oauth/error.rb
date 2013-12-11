module Oauth
  class Error < StandardError
    attr_reader :code, :description

    def initialize(code, description)
      @code = code
      @description = description

      super("#{@code}: #{@description}")
    end

    def to_query
      {error: code, error_description: description}.to_param
    end
  end
end