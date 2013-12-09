module Oauth
  module Response
    # Abstract class for handling responses
    #
    #
    class Base
      # Initialize a response
      #
      # @param  [Hash] params
      # @return [Response]
      def initialize(params={})
        params.each do |k, v|
          instance_variable_set("@#{k}", v)
        end
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