require "fabrication"

Fabrication.configure do |config|
  config.path_prefix = Oauth::Engine.root
end