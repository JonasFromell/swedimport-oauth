module Oauth
  class ApplicationController < ActionController::Base
    def authenticate_resource_owner!
      Oauth.authenticate_resource_owner!(self)
    end

    def current_resource_owner
      Oauth.current_resource_owner(self)
    end
  end
end
