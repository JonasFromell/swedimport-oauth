require "devise"

require "oauth/engine"

require "oauth/request"
require "oauth/strategy/authorization_code"

require "oauth/response"

require "oauth/error"

require "oauth/http/uri"

module Oauth
  autoload :Request, 'oauth/request'
  autoload :Response, 'oauth/response'

  module Strategy
    autoload :AuthorizationCode, 'oauth/strategy/authorization_code'
  end

  module Error
    autoload :OauthError, 'oauth/error/oauth_error'
    autoload :AccessDenied, 'oauth/error/access_denied'
    autoload :UnauthorizedClient, 'oauth/error/unauthorized_client'
  end

  module Http
    autoload :Uri, 'oauth/http/uri'
  end

  module Controller
    autoload :Helper, 'oauth/controller/helper'
  end
end
