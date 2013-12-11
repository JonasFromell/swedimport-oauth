module Oauth
  class UsersController < ApplicationController
    before_filter :authenticate_user!
    
    def show
      @user = current_user

      respond_to do |format|
        format.json { @user.to_json }
      end
    end
  end
end