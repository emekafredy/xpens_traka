require 'rails_helper'

RSpec.describe Income, type: :model do
  context "check income association" do
    it { is_expected.to belong_to(:user) }
  end
end
