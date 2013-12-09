Devise.setup do |config|
  config.router_name = :oauth
  config.parent_controller = 'Oauth::ApplicationController'
end