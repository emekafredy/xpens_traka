require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  before(:each) { login_user }

  describe 'GET #download_incomes' do
    let!(:incomes) { create_list(:income, 3, user_id: subject.current_user.id) }

    context 'when user is logged in' do
      it 'responds with a XLSX file' do
        get :download_incomes, params: { start_date: incomes.first.created_at, end_date:  incomes.first.created_at}

        expect(response.content_type.to_s).to eql 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        expect(response.headers['Content-Disposition']).to eql "attachment; filename=\"incomes_report.xlsx\"; filename*=UTF-8''incomes_report.xlsx"
      end
    end
  end

  describe 'GET #download_expenses' do
    let!(:expenses) { create_list(:expense, 3, user_id: subject.current_user.id) }

    context 'when user is logged in' do
      it 'responds with a XLSX file' do
        get :download_expenses, params: { start_date: expenses.first.created_at, end_date:  expenses.first.created_at}

        expect(response.content_type.to_s).to eql 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        expect(response.headers['Content-Disposition']).to eql "attachment; filename=\"expenses_report.xlsx\"; filename*=UTF-8''expenses_report.xlsx"
      end
    end
  end
end
