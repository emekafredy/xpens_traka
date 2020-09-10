require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  before(:each) { login_user }

  let(:valid_expense_attributes) { { category: :Utility, amount: 3000, date: Time.now, file: 'expense-receipt.jpg' } }
  let(:invalid_expense_attributes) { { category: :Food, amount: 3000, date: '' } }
  let(:secure_url) { 'secure-expense-receipt.jpg' }
  
  describe 'GET #index' do
    let!(:expenses) { create_list(:expense, 4, user_id: subject.current_user.id) }

    context 'when user is logged in' do
      it 'renders the index page for expenses' do
        get :index

        expect(response).to render_template('index')
        expect(response).to be_successful
      end

      it 'gets the list of user\'s expenses' do
        get :index

        expect(response).to be_successful
        expect(expenses.length).to eq 4
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
    it 'renders a page to create new expense' do
      get :new
      
      expect(response).to render_template('new')
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    before do
      allow(Cloudinary::Uploader).to receive(:upload).with('expense-receipt.jpg') { secure_url }
    end

    context 'with valid attributes' do
      it 'saves a new expense' do
        expect(Expense.count).to eq 0

        post :create, params: { expense: valid_expense_attributes }

        expect(Expense.count).to eq 1
        expect(Expense.first.category).to eq 'Utility'
      end

      it "redirects to the expenses page" do
        post :create, params: { expense: valid_expense_attributes }

        expect(response).to redirect_to expenses_path
      end
    end

    context 'with missing required attribute(s)' do
      it 'does not save the new expense' do
        expect { post :create, params: { expense: invalid_expense_attributes } }
          .not_to change { Expense.count }
      end

      it 're-renders #new' do
        post :create, params: { expense: invalid_expense_attributes }

        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
    let!(:expense) { create(:expense, user_id: subject.current_user.id) }

    it 'renders the edit page for an expense' do

      get :edit, params: { id: expense.to_param }

      expect(response).to render_template('edit')
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let!(:expense) { create(:expense, user_id: subject.current_user.id) }

    context 'with valid attributes' do
      let(:update_value) { { category: :Food } }

      it 'successfully updates expense' do
        put :update, params: { id: expense.to_param, expense: update_value }
        expense.reload

        expect(response).to redirect_to expenses_path
        expect(expense.category).to eql('Food')
      end
    end

    context 'with invalid attributes' do
      it 'does not update expense' do
        expect { put :update, params: { id: expense.to_param, expense: invalid_expense_attributes } }
          .not_to change { Expense.find(expense.id).category }
      end

      it 're-renders #edit' do
        put :update, params: { id: expense.to_param, expense: invalid_expense_attributes }
        expense.reload

        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:expense) { create(:expense, user_id: subject.current_user.id) }

    it "destroys the selected expense" do
      expect {
        delete :destroy, params: {id: expense.to_param}
      }.to change(Expense, :count).by(-1)
      expect(response).to redirect_to expenses_path
    end
  end
end
