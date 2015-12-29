class Micropost < ActiveRecord::Base
  # associated to user model
  belongs_to :user
  # order microposts in descending order on default scope
  default_scope -> { order(created_at: :desc) }
  # validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
