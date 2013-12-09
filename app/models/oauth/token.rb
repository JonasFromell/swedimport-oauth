module Oauth
  class Token < ActiveRecord::Base
    before_validation :set_token

    belongs_to :client, class_name: "Oauth::Client"

    private

    def set_token
      self.token ||= SecureRandom.base64(16)
    end

    def set_refresh_token
      self.token ||= SecureRandom.base64(16)
    end
  end
end