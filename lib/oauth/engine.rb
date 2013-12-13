module Oauth
  class Engine < ::Rails::Engine
    isolate_namespace Oauth

    # No need for `oauth:install:migrations` if we do this
    initializer 'oauth.append_migrations' do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |path|
          app.config.paths["db/migrate"] << path
        end
      end
    end

    # Include helpers in application controller
    initializer 'oauth.helpers' do
      Oauth.include_helpers
    end
  end
end
