require 'rails_helper'

RSpec.describe HomepageController, type: :controller do
  describe 'GET #index' do
    context 'when user opens the homepage' do
      before do
        login_user
      end
      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end
    end
  end
end
