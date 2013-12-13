class OauthController < ApplicationController
  before_filter :require_access_token, only: [:new]
  def new
    head :ok
  end
  
  def callback
  end
end