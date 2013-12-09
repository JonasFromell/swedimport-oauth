module Oauth
  module Error
    class UnauthorizedClient < Base
      def name
        "unauthorized_client"
      end

      def message
        "The client is not authorized to request an authorization code using this method."
      end
    end
  end
end