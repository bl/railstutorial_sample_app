class User < ActiveRecord::Base
  # block to execute before .save calls to bring email to lowercase
  before_save { self.email = email.downwcase }

  # call validates with attribute and optinos hash requiring presence on name field
  validates :name, presence: true, length: { maximum: 50}
  # valid email REGEX (accepting basic structure email formats)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validate email field to require presence
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }

  has_secure_password
end
