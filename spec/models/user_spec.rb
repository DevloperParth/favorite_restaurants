# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#generate_jwt_token' do
    let(:user) { create(:user) }

    it 'generates a JWT token' do
      token = user.generate_jwt_token
      expect(token).not_to be_empty
    end
  end
end
