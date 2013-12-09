module Oauth
  module Request
    class AccessToken < Base
      # Class methods
      #
      #
      class << self
        def for(client, params={})
          # New request
          request = new(params.merge(client: client))
        end
      end

      # Instance methods
      #
      #

      # Returns the access token
      #
      # @return [Response]
      def get_access_token
        # Find the authorization for this authorization_code
        raise Oauth::Error::InvalidGrant unless auth = Oauth::Authorization.find_by(code: code)

        # Make sure that this authorization grant really is for this client
        raise Oauth::Error::InvalidGrant unless auth.redirect_uri == client.redirect_uri
        raise Oauth::Error::InvalidGrant unless auth.application_id == client.application_id

        # Generate a new access token
        token = Oauth::Token.create(client: client)

        # This authorization_code is now expired, destroy it! (?)

        # And send it off
        Oauth::Response::AccessToken.new(client.redirect_uri, token.attributes)
      end

      # Default this to true, as client authentication
      # is handled in the controller
      def client?
        true
      end

      def valid?
        [grant_type, code].all?
      end
    end
  end
end