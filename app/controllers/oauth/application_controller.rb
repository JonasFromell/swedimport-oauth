module Oauth
  class ApplicationController < ActionController::Base
    after_filter :store_location

    def after_sign_in_path_for(resource)
      session[:previous_url] || "/oauth/#{account_path}" # For some reason Devise doesn't execute the routes in the context of the engine
    end

    private

    def store_location
      if (!request.fullpath.match("/users/") && !request.xhr?)
        session[:previous_url] = request.fullpath
      end
    end
  end
end
