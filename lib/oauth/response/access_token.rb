module Oauth
  module Response
    class AccessToken < Base
      def initialize(redirect_uri, params={})
        super(params.merge(redirect_uri: redirect_uri))
      end

      def to_uri
        [
          redirect_uri,
          {
            access_token: token,
            token_type: "Bearer",
            expires_in: expires_at
          }.to_param
        ].join('?')
      end
    end
  end
end