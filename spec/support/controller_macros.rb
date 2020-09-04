FactoryBot.define do
  module ControllerMacros
    def login_user
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = stub_omniauth
      # user.confirm! # Or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end
