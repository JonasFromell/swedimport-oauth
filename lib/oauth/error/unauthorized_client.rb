module Oauth
  module Error
    class UnauthorizedClient < OauthError
      def self.to_hash
        new("unauthorized_client", "The client is not authorized to make this request.").to_hash
      end
    end
  end
end