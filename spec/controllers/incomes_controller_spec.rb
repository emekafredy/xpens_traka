require 'rails_helper'

RSpec.describe IncomesController, type: :controller do
  before(:each) { login_user }

  let(:valid_income_attributes) { { category: :Salary, amount: 150000, date: Time.now } }
  let(:invalid_income_attributes) { { category: :Others, amount: 150000, date: '' } }
  
  describe 'GET #index' do
    let!(:incomes) { create_list(:income, 3, user_id: subject.current_user.id) }

    context 'when user is logged in' do
      it 'renders the index page for incomes' do
        get :index

        expect(response).to render_template('index')
        expect(response).to be_successful
      end

      it 'gets the list of user\'s incomes' do
        get :index

        expect(response).to be_successful
        expect(incomes.length).to eq 3
      end
    end

    context 'when user is logged out' do
      before do
        logout_user
      end

      it 'redirects user to the login page' do
        get :index
        
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #new' do
    it 'renders a page to create new income' do
      get :new
      
      expect(response).to render_template('new')
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new income' do
        expect(Income.count).to eq 0

        post :create, params: { income: valid_income_attributes }

        expect(Income.count).to eq 1
        expect(Income.first.category).to eq 'Salary'
      end

      it "redirects to the incomes page" do
        post :create, params: { income: valid_income_attributes }

        expect(response).to redirect_to incomes_path
      end
    end

    context 'with missing required attribute(s)' do
      it 'does not save the new income' do
        expect { post :create, params: { income: invalid_income_attributes } }
          .not_to change { Income.count }
      end

      it 're-renders #new' do
        post :create, params: { income: invalid_income_attributes }

        expect(response).to render_template('new')
      end 
    end
  end

  describe 'GET #edit' do
    let!(:income) { create(:income, user_id: subject.current_user.id) }

    it 'renders the edit page for an income' do

      get :edit, params: { id: income.to_param }

      expect(response).to render_template('edit')
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let!(:income) { create(:income, user_id: subject.current_user.id) }

    context 'with valid attributes' do
      let(:update_value) { { category: :Others, amount: 200000 } }

      it 'successfully updates income' do
        put :update, params: { id: income.to_param, income: update_value }
        income.reload

        expect(response).to redirect_to incomes_path
        expect(income.category).to eql('Others')
        expect(income.amount).to eql(200000)
      end
    end

    context 'with invalid attributes' do
      it 'does not update income' do
        expect { put :update, params: { id: income.to_param, income: invalid_income_attributes } }
          .not_to change { Income.find(income.id).category }
      end

      it 're-renders #edit' do
        put :update, params: { id: income.to_param, income: invalid_income_attributes }
        income.reload

        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:income) { create(:income, user_id: subject.current_user.id) }

    it "destroys the selected income" do
      expect {
        delete :destroy, params: {id: income.to_param}
      }.to change(Income, :count).by(-1)
      expect(response).to redirect_to incomes_path
    end
  end
end
