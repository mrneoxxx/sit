require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket) { build(:ticket) }
  let(:new_ticket) { create(:ticket) }
  subject { new_ticket }
  before do
    allow(subject).to receive(:save_assignments)
  end

  describe 'after create' do
    it 'reference not blank' do
      expect(subject.reference).to_not be_blank
    end

    it 'status not blank' do
      expect(subject.status_id).to_not be_blank
    end
  end

  describe 'user update' do
    before do
      User.current = nil
    end
    it 'assign is not required for update' do
      subject.valid?
      expect(subject.errors).to_not have_key(:user)
    end

    it 'status set to default' do
      allow(subject).to receive(:get_default_status).and_return(1)
      subject.save!
      expect(subject.reload.status_id).to eq(1)
    end
  end

  describe 'admin update' do
    let(:user) { create(:user) }
    let(:status) { create(:status) }
    before do
      User.current = user
    end

    it 'admin must assign ticket for update' do
      subject.valid?
      expect(subject.errors).to have_key(:user)
    end

    it 'status not change to default' do
      subject.user = user
      allow(subject).to receive(:get_default_status).and_return(1)
      subject.save!
      expect(subject).to_not eq(1)
    end
  end
end
