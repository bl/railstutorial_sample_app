class Micropost < ActiveRecord::Base
  # associated to user model
  belongs_to :user
  # order microposts in descending order on default scope
  default_scope -> { order(created_at: :desc) }
  # associate PictureUploader image model to micropost
  mount_uploader :picture, PictureUploader
  # validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  private
    # validates the size of an uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
