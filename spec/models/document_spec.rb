require 'rails_helper'

RSpec.describe Document, type: :model do
  context "check document association" do
    it { is_expected.to belong_to(:user) }
  end
end
