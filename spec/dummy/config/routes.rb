Rails.application.routes.draw do

  mount Oauth::Engine => "/oauth"
end
