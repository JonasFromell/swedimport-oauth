$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "oauth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "swedimport-oauth"
  s.version     = Oauth::VERSION
  s.authors     = ["Jonas Fromell"]
  s.email       = ["jonas.per.fromell@gmail.com"]
  s.homepage    = "http://github.com/JonasFromell/swedimport-oauth"
  s.summary     = "OAuth provider engine."
  s.description = "OAuth provider engine."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 4.0.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "fabrication"
  s.add_development_dependency "devise"
end
