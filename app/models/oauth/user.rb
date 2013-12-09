module Oauth
  class User < ActiveRecord::Base
    devise :database_authenticatable, :rememberable, :trackable, :validatable

    has_many :authorizations, class_name: "Oauth::Authorization"
  end
end