module ControllerHelper
  def sign_in(user=double("user"))
    if user.nil?
      request.env['warden'].stub(:authenticate!).and_throw(:warden, {scope: :user})
      controller.stub current_user: nil
    else
      request.env['warden'].stub :authenticate! => user
      controller.stub current_user: user
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelper, type: :controller
end