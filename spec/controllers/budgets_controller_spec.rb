require 'rails_helper'

RSpec.describe BudgetsController, type: :controller do
  before(:each) { login_user }

  let(:valid_budget_attributes) { { start_date: Time.now, end_date: Time.now + 29.days, income_estimate: 350000, expense_estimate: 150000 } }
  let(:invalid_budget_attributes) { { start_date: Time.now, end_date: Time.now + 29.days, income_estimate: nil, expense_estimate: 150000 } }
  let(:overlapping_date_attributes) { { start_date: Time.now, end_date: Time.now + 29.days, income_estimate: 500000, expense_estimate: 250000 } }
  let(:invalid_date_attributes) { { start_date: Time.now + 29.days, end_date: Time.now, income_estimate: 500000, expense_estimate: 250000 } }
  
  describe 'GET #index' do
    let!(:budgets) { create_list(:budget, 1, user_id: subject.current_user.id) }

    context 'when user is logged in' do
      it 'renders the index page for budgets' do
        get :index

        expect(response).to render_template('index')
        expect(response).to be_successful
      end

      it 'gets the list of user\'s budget' do
        get :index

        expect(response).to be_successful
        expect(budgets.length).to eq 1
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
    it 'renders a page to create new budget' do
      get :new
      
      expect(response).to render_template('new')
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new budget' do
        expect(Budget.count).to eq 0

        post :create, params: { budget: valid_budget_attributes }

        expect(Budget.count).to eq 1
        expect(Budget.first.income_estimate).to eq 350000
      end

      it "redirects to the budgets page" do
        post :create, params: { budget: valid_budget_attributes }

        expect(response).to redirect_to budgets_path
      end
    end

    context 'with missing required attribute(s)' do
      it 'does not save the new budget' do
        expect { post :create, params: { budget: invalid_budget_attributes } }
          .not_to change { Budget.count }
      end

      it 're-renders #new' do
        post :create, params: { budget: invalid_budget_attributes }

        expect(response).to render_template('new')
      end 
    end

    context 'when a new budget start date is later than the end date' do
      let!(:budget) { create(:budget, user_id: subject.current_user.id) }

      it 'does not save the new budget' do
        expect { post :create, params: { budget: invalid_date_attributes } }
          .not_to change { Budget.count }
      end 
    end

    context 'when a new budget start and end date overlaps that of an existing budget for a user' do
      let!(:budget) { create(:budget, user_id: subject.current_user.id) }

      it 'does not save the new budget' do
        expect { post :create, params: { budget: overlapping_date_attributes } }
          .not_to change { Budget.count }
      end 
    end
  end

  describe 'GET #edit' do
    let!(:budget) { create(:budget, user_id: subject.current_user.id) }

    it 'renders the edit page for a budget' do
      get :edit, params: { id: budget.to_param }

      expect(response).to render_template('edit')
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    let!(:budget) { create(:budget, user_id: subject.current_user.id) }

    context 'with valid attributes' do
      let(:update_value) { { income_estimate: 500000, expense_estimate: 200000 } }

      it 'successfully updates budget' do
        put :update, params: { id: budget.to_param, budget: update_value }
        budget.reload

        expect(response).to redirect_to budgets_path
        expect(budget.income_estimate).to eql(500000)
        expect(budget.expense_estimate).to eql(200000)
      end
    end

    context 'with invalid attributes' do
      it 'does not update budget' do
        expect { put :update, params: { id: budget.to_param, budget: invalid_budget_attributes } }
          .not_to change { Budget.find(budget.id).income_estimate }
      end

      it 're-renders #edit' do
        put :update, params: { id: budget.to_param, budget: invalid_budget_attributes }
        budget.reload

        expect(response).to render_template('edit')
      end
    end

    context 'when the start_date update value is later than the end date' do
      it 'does not update budget' do
        expect { put :update, params: { id: budget.to_param, budget: invalid_date_attributes } }
          .not_to change { Budget.find(budget.id).start_date }
      end 
    end

    context 'when start or end date update value overlaps with that of an existing budget' do
      let!(:budget_2) { create(:second_budget, user_id: subject.current_user.id) }
      
      it 'does not update budget' do
        expect { put :update, params: { id: budget_2.to_param, budget: overlapping_date_attributes } }
          .not_to change { Budget.find(budget_2.id).start_date }
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:budget) { create(:budget, user_id: subject.current_user.id) }

    it "destroys the selected budget" do
      expect {
        delete :destroy, params: {id: budget.to_param}
      }.to change(Budget, :count).by(-1)
      expect(response).to redirect_to budgets_path
    end
  end
end
