module Oauth
  class Response
    attr_reader :request, :options

    def initialize(request, options={})
      @request = request
      @options = options
    end

    def to_param
      [request.redirect_uri, options.to_param].join('?')
    end
  end
end