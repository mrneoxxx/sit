class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tickets, dependent: :restrict_with_error
  has_many :ticket_comments, dependent: :restrict_with_error
  has_many :assignments, dependent: :restrict_with_error
  belongs_to :department
  delegate :name, to: :department, allow_nil: true, prefix: true
  validates :name, :department, :email, presence: true


  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
