require 'rails_helper'
require 'omniauth-google-oauth2'

RSpec.describe Users::OmniauthController, type: :controller do
  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe "GET #google_oauth2" do
    it "authenticates a user via google_oauth2" do
      stub_google_omniauth
    end
  end
end
