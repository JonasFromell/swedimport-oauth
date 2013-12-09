module Oauth
  module Response
    class AuthorizationCode < Base
      def to_uri
        [redirect_uri, {code: code}.to_param].join('?')
      end
    end
  end
end