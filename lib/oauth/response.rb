module Oauth
  class Response
    attr_reader :request, :options

    def initialize(request, options={})
      @request = request
      @options = options
    end

    def to_json
      @options.to_json
    end

    def to_hash
      @options
    end
  end
end