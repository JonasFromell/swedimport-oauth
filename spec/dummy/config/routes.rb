Rails.application.routes.draw do

  devise_for :users
  mount Oauth::Engine => "/oauth"
end
