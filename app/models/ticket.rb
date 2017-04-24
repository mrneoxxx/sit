class Ticket < ApplicationRecord
  include PgSearch

  belongs_to :status
  belongs_to :department
  belongs_to :user
  has_many :ticket_comments
  accepts_nested_attributes_for :ticket_comments
  delegate :name, to: :department, prefix: true
  delegate :title, to: :status, prefix: true, allow_nil: true
  before_create :set_reference
  before_save :set_status
  after_create :send_create_email
  after_update :send_update_email, :save_assignments

  validates :department, :title, presence: true
  validates :customer, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :status, presence: true, on: :update
  validates :user, presence: true, if: :need_assign?
  validates_associated :ticket_comments

  pg_search_scope :text_search, against: [:reference, :title, :customer],
                  associated_against: { ticket_comments: [:body] },
                  using: { tsearch: { any_word: true } }

  scope :status_group, -> (group_id) do
    case group_id.to_i
      when 1
        where(user: nil)
      else
        where(status: Status.where(status_group: group_id)) if group_id.to_i > 1
    end
  end

  scope :query_search, -> (query) { text_search(query.to_s) unless query.to_s.blank? }

  def assigned?
    !self.user.nil?
  end

  def to_param
    reference
  end

  private

    def set_reference
      self.reference = generate_reference
    end

    def generate_reference
      loop do
        ref = 5.times.map do |i|
          i.even? ? [*'A'..'Z'].sample(3).join : SecureRandom.hex(1).upcase
        end.join('-')
        break ref unless Ticket.where(reference: ref).exists?
      end
    end

    def need_assign?
      !User.current.blank? && !self.new_record?
    end

    def send_create_email
      TicketMailer.new_ticket(self.id).deliver
    end

    def send_update_email
      TicketMailer.update_ticket(self.id).deliver
    end

    def set_status
      self.status_id = get_default_status if User.current.blank? || self.new_record?
    end

    def get_default_status
      Status.get_default
    end

    def save_assignments
      new_assignment = nil
      %w(status_id user_id).each do |attr|
        if self.send("#{attr}_changed?")
          new_assignment ||= self.ticket_comments.last.build_assignment
          new_assignment.send("#{attr}=", self.send("#{attr}"))
        end
      end
      new_assignment.save if new_assignment
    end

end
