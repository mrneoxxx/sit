class StatusGroup < ApplicationRecord
  belongs_to :status
  validates :name, presence: true

  scope :for_user, -> { where('id > 1') }

end
