require 'rails_helper'

RSpec.describe User, type: :model do
  context "check user associations" do
    it { is_expected.to have_many(:incomes) }
    it { is_expected.to have_many(:expenses) }
    it { is_expected.to have_many(:budgets) }
    it { is_expected.to have_many(:documents) }
  end
end
