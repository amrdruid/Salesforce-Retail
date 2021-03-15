require 'rails_helper'

RSpec.describe Dealer, type: :model do
  describe 'associations' do
    it { should have_one(:contact_info) }
  end
end
