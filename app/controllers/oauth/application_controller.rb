module Oauth
  class ApplicationController < ActionController::Base
    private
    
    def authenticate_client!
      authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
    end
    
    def authenticate_resource_owner!
      Oauth.authenticate_resource_owner!(self)
    end

    def current_resource_owner
      Oauth.current_resource_owner(self)
    end

    def set_headers
      response.headers["Cache-Control"] = "no-store"
      response.headers["Pragma"] = "no-cache"
    end
  end
end
