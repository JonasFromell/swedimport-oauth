Oauth::Engine.routes.draw do
  # AuthorizationCode flow
  get  "authorize", to: "authorizations#new",     constraints: lambda { |req| req.query_parameters["response_type"] == "code" }
  post "authorize", to: "authorizations#create",  constraints: lambda { |req| req.query_parameters["response_type"] == "code" }
  post "token",     to: "authorizations#token",   constraints: lambda { |req| req.query_parameters["grant_type"] == "authorization_code" }
end
