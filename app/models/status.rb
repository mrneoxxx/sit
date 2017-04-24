class Status < ApplicationRecord
  has_many :tickets, dependent: :restrict_with_error
  has_many :assignments, dependent: :restrict_with_error
  belongs_to :status_group
  delegate :name, to: :status_group, allow_nil: true, prefix: true
  validates :title, :status_group, presence: true
  validates_numericality_of :sorter, only_integer: true

  def self.get_default
    self.order(:sorter).first.try(:id)
  end
end
