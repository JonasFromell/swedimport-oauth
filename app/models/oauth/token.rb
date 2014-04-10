module Oauth
  class Token < ActiveRecord::Base
    before_validation :set_token, :set_expires_at

    belongs_to :client, class_name: "Oauth::Client"

    validate :not_expired

    # Set the client relationship through application_id
    #
    def application_id=(application_id)
      self.client = Oauth::Client.find_by(application_id: application_id)
    end

    # Get the token as a hash
    #
    def to_hash
      {access_token: token, refresh_token: refresh_token, expires_in: (expires_at - Time.now).ceil}
    end

    def to_query
      to_hash().to_param
    end

    private

    def set_token
      self.token ||= SecureRandom.urlsafe_base64(16)
    end

    def set_refresh_token
      self.refresh_token ||= SecureRandom.urlsafe_base64(16)
    end

    def set_expires_at
      self.expires_at ||= 1.hour.from_now
    end

    def not_expired
      self.expires_at > Time.now
    end
  end
end