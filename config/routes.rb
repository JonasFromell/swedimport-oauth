Oauth::Engine.routes.draw do
  # Devise
  devise_for :users, {
    class_name: "Oauth::User", module: :devise
  }

  # Users
  get "me", to: "users#show"
  
  # AuthorizationCode flow
  get  "authorize", to: "authorizations#new",     constraints: lambda { |req| req.query_parameters["response_type"] == "code" }
  post "authorize", to: "authorizations#create",  constraints: lambda { |req| req.query_parameters["response_type"] == "code" }
  post "token",     to: "authorizations#token",   constraints: lambda { |req| req.query_parameters["grant_type"] == "authorization_code" }
end
