module Oauth
  class Authorization < ActiveRecord::Base
    before_validation :set_code, :set_expires_at

    belongs_to :user, class_name: "Oauth::User"

    def to_param
      {
        code: code,
        redirect_uri: redirect_uri
      }
    end

    def client
      Client.find_by(application_id: application_id, redirect_uri: redirect_uri)
    end

    private

    def set_code
      self.code = SecureRandom.urlsafe_base64(16)
    end

    def set_expires_at
      self.expires_at = 10.minutes.from_now
    end
  end
end