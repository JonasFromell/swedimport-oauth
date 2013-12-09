module Oauth
  module Error
    class AccessDenied < Base
      def name
        "access_denied"
      end

      def message
        "The resource owner or authorization server denied the request."
      end
    end
  end
end