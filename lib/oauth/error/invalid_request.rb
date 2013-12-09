module Oauth
  module Error
    class InvalidRequest < Base
      def name
        "invalid_request"
      end

      def message
        "The request is missing a required parameter, includes an invalid parameter value, includes a parameter more than once, or is otherwise malformed."
      end
    end
  end
end