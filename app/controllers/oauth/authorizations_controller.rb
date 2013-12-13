module Oauth
  class AuthorizationsController < ApplicationController
    before_filter :authenticate_resource_owner!, only: [:new]
    # Authorize endpoint for `response_type=code`
    #
    # @param params[:application_id]
    # @param params[:redirect_uri]
    def new
      # Nothing to see here, atm
    end

    # @param params[:application_id]
    # @param params[:redirect_uri]
    def create
      @request = Request.new(params)
      
      if current_resource_owner
        response = @request.authorization_code.get_code(current_resource_owner)

        respond_to do |format|
          format.html { redirect_to Http::Uri.build(@request.redirect_uri, response.to_hash) }
          format.json { render json: response.to_json, location: @request.redirect_uri }
        end
      else
        respond_to do |format|
          format.html { redirect_to Http::Uri.build(@request.redirect_uri, Oauth::Error::AccessDenied.to_hash) }
          format.json { render json: Oauth::Error::AccessDenied.to_json, location: @request.redirect_uri }
        end
      end
    end

    # Token endpoint for `grant_type=authorization_code`
    #
    # @param params[:application_id]
    # @param params[:redirect_uri]
    # @param params[:code]
    def token
      @request = Request.new(params)

      if authenticate_client!
        response = @request.authorization_code.get_access_token

        respond_to do |format|
          format.html { redirect_to Http::Uri.build(@request.redirect_uri, response.to_hash) }
          format.json { render json: response.to_json, location: @request.redirect_uri }
        end
      else
        respond_to do |format|
          format.html { redirect_to Http::Uri.build(@request.redirect_uri, Oauth::Error::UnauthorizedClient.to_hash) }
          format.json { render json: Oauth::Error::UnauthorizedClient.to_json, location: @request.redirect_uri }
        end
      end
    end
  end
end