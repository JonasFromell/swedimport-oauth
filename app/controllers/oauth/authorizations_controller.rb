module Oauth
  class AuthorizationsController < ApplicationController
    before_filter :authenticate_user!, only: [:new]

    def new
      
    end

    def create
      if user_signed_in?
        @request = Request.new(params).authorization_code
        response = @request.get_code(current_user)

        redirect_to response.to_param
      else
        redirect_to [params[:redirect_uri], Oauth::Error.new("access_denied", "The authorization server denied the request.").to_query].join('?')
      end
    end

    def token
      if authenticate_client!
        @request = Request.new(params).authorization_code
        response = @request.get_access_token

        redirect_to response.to_param
      else
        redirect_to [request.referer, Oauth::Error.new("unauthorized_client", "The client is not authorized to make this request.").to_query].join('?')
      end
    end

    protected

    def authenticate_client!
      authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
    end
  end
end