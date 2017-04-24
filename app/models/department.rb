class Department < ApplicationRecord
  validates :name, presence: true

  has_many :ticket
  has_many :user
end
