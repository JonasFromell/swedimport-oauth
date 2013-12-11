module Oauth
  class Request
    attr_accessor :callback_uri
    # Initialize a new request
    #
    # @param  [Hash] params
    # @return [Request] 
    def initialize(params={})
      params.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end

    # Instance methods
    #
    #

    # Return a new response for the options
    #
    def respond_with(options={})
      Oauth::Response.new(self, options)
    end

    # Authorization code strategy
    #
    def authorization_code
      @authorization_code ||= Oauth::Strategy::AuthorizationCode.new(self)
    end

    # Client credentials strategy
    #
    def client_credentials
      @client_credentials ||= Oauth::Strategy::ClientCredentials.new(self)
    end

    # Meta programing
    #
    def method_missing(method_name, *args, &block)
      if instance_variable_names.include?("@#{method_name}")
        instance_variable_get("@#{method_name}")
      else
        super
      end
    end
  end
end