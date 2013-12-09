module Oauth
  module Request
    # Abstract base class for handling requests
    #
    # Should always return a [Response] object
    class Base
      # Initialize a request
      #
      # @param  [Hash] params A Hash of request params
      # @return [Request]
      def initialize(params={})
        params.each do |k, v|
          instance_variable_set("@#{k}", v)
        end

        # Raise error if valid? check returns false
        raise Oauth::Error::InvalidRequest unless valid?

        # Raise error if client is non-existing
        raise Oauth::Error::UnauthorizedClient unless client?
      end
      # Check to see if the request is valid
      #
      # @return [Boolean]
      def valid?
        false
      end
      # Check to see if client is authorized for this request
      #
      # @return [Boolean]
      def client?
        false
      end
      # Some meta programing
      #
      def method_missing(method_name, *args, &block)
        if instance_variable_names.include? "@#{method_name}"
          instance_variable_get "@#{method_name}"
        else
          super
        end
      end
    end
  end
end