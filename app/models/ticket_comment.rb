class TicketComment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  has_one :assignment
  before_create :set_user
  validates :body, presence: true
  delegate :name, to: :user, allow_nil: true, prefix: true

  def self.last_comment
    self.last.try(:body)
  end

  private

    def set_user
      self.user_id = User.current.id if User.current
    end

end
