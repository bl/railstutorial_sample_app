class Relationship < ActiveRecord::Base
  # belongs to a follower user, and a user being followed
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # validation requiring presence of follower, followed
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
