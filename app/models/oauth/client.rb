module Oauth
  class Client < ActiveRecord::Base
    before_validation :set_application_id, :set_application_secret

    class << self
      def authenticate(application_id, application_secret)
        where("application_id = ? AND set_application_secret = ?", application_id, application_secret)
      end
    end

    private

    def set_application_id
      self.application_id ||= SecureRandom.urlsafe_base64(16)
    end

    def set_application_secret
      self.application_secret ||= SecureRandom.urlsafe_base64(16)
    end
  end
end