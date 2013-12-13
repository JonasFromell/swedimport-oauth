require "oauth/engine"

module Oauth
  autoload :Request, 'oauth/request'
  autoload :Response, 'oauth/response'

  module Authenticator
    autoload :Devise, 'oauth/authenticator/devise'
  end

  module Strategy
    autoload :AuthorizationCode, 'oauth/strategy/authorization_code'
    autoload :ClientCredentials, 'oauth/strategy/client_credentials'
  end

  module Error
    autoload :OauthError, 'oauth/error/oauth_error'
    autoload :AccessDenied, 'oauth/error/access_denied'
    autoload :UnauthorizedClient, 'oauth/error/unauthorized_client'
    autoload :Unauthorized, 'oauth/error/unauthorized'
  end

  module Http
    autoload :Uri, 'oauth/http/uri'
  end

  module Controller
    autoload :Helper, 'oauth/controller/helper'
  end

  ## Configuration
  #
  #

  # The class name to use as the resource owner, defaults to User
  mattr_accessor :resource_owner_class_name
  @@resource_owner_class_name = "User"

  # The strategy to use to authenticate the resource owner, defaults to Devise
  mattr_accessor :resource_owner_authentication_strategy
  @@resource_owner_authentication_strategy = "Devise"

  # The default way to setup Oauth
  def self.setup
    yield self
  end

  # Include helpers in controllers
  def self.include_helpers
    ActiveSupport.on_load(:action_controller) do
      include Oauth::Controller::Helper
    end
  end

  # Proxy for the authentication strategy `sign_in` method
  def self.sign_in(controller, current_resource_owner)
    klass = Oauth::Authenticator.const_get("#{@@resource_owner_authentication_strategy.constantize}")
    klass.new(controller).sign_in(current_resource_owner)
  end

  def self.sign_out(controller, current_resource_owner)
    klass = Oauth::Authenticator.const_get("#{@@resource_owner_authentication_strategy.constantize}")
    klass.new(controller).sign_out(current_resource_owner)
  end

  def self.current_resource_owner(controller)
    klass = Oauth::Authenticator.const_get("#{@@resource_owner_authentication_strategy.constantize}")
    klass.new(controller).current_resource_owner
  end

  def self.authenticate_resource_owner!(controller)
    klass = Oauth::Authenticator.const_get("#{@@resource_owner_authentication_strategy.constantize}")
    klass.new(controller).authenticate_resource_owner!
  end
end
