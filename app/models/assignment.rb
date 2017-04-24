class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket_comment
  belongs_to :status
  delegate :name, to: :user, allow_nil: true, prefix: true
  delegate :title, to: :status, allow_nil: true, prefix: true
end
