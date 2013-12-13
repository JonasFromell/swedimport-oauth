Rails.application.routes.draw do
  devise_for :users
  
  mount Oauth::Engine => "/oauth"

  get "callback", to: "oauth#callback"
  get "protected", to: "oauth#new"
end
