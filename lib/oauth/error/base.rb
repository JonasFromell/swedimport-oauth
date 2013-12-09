module Oauth
  module Error
    # Abstract class for application specific errors
    #
    class Base < StandardError
      # Returns the error as URI params
      #
      # @return [String]
      def to_param
        {error: name, description: message}.to_param
      end
    end
  end
end