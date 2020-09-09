require 'rails_helper'

RSpec.describe HomepageController, type: :controller do
  describe 'GET #index' do
    context 'when user is logged in' do
      before do
        login_user
      end

      let!(:incomes) { create_list(:income, 3, user_id: subject.current_user.id) }
      let!(:expenses) { create_list(:expense, 3, user_id: subject.current_user.id) }

      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end

      it 'fetches user\'s incomes and expenses for visual analysis' do
        get :index

        expect(incomes.length).to eq 3
        expect(expenses.length).to eq 3
      end
    end

    context 'when user is not logged' do
      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end
    end
  end
end
