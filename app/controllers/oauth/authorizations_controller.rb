module Oauth
  class AuthorizationsController < ApplicationController
    before_filter :authenticate_user!, only: [:new]

    def new
      
    end

    def create
      @request = Request.new(params)

      if user_signed_in?
        response = @request.authorization_code.get_code(current_user)

        redirect_to Http::Uri.build(@request.redirect_uri, response.options)
      else
        redirect_to Http::Uri.build(@request.redirect_uri, Oauth::Error::AccessDenied.to_hash)
      end
    end

    def token
      @request = Request.new(params)

      if authenticate_client!
        response = @request.authorization_code.get_access_token

        redirect_to Http::Uri.build(@request.redirect_uri, response.options)
      else
        redirect_to Http::Uri.build(@request.redirect_uri, Oauth::Error::UnauthorizedClient.to_hash)
      end
    end

    protected

    def authenticate_client!
      authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
    end
  end
end