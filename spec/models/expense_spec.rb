require 'rails_helper'

RSpec.describe Expense, type: :model do
  context "check expense association" do
    it { is_expected.to belong_to(:user) }
  end
end
