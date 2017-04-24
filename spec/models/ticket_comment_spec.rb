require 'rails_helper'

RSpec.describe TicketComment, type: :model do
  let(:ticket_comment) { create(:ticket_comment) }
  let(:user) { create(:user) }
  subject { ticket_comment }

  describe 'user saved correctly' do
    it 'for user' do
      expect(subject.user_id).to be_nil
    end

    it 'for admin' do
      User.current = user
      expect(subject.user_id).to eq(user.id)
    end
  end

end
