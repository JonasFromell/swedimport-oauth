module Oauth
  module Authenticator
    class Devise
      attr_reader :controller

      def initialize(controller)
        @controller = controller
      end

      def sign_in(resource_owner)
        controller.sign_in(resource_owner, bypass: true)
      end

      def sign_out
        controller.sign_out(current_resource_owner)
      end

      def current_resource_owner
        controller.send("current_#{Oauth.resource_owner_class_name.downcase}")
      end

      def authenticate_resource_owner!
        current_resource_owner || controller.send("authenticate_#{Oauth.resource_owner_class_name.downcase}!")
      end
    end
  end
end