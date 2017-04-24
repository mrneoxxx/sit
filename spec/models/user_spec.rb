require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  subject { user }

  it 'cannot delete user if user tickets exist' do
    expect(user.destroy).to be_falsey
  end
end
