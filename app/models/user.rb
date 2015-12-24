class User < ActiveRecord::Base
  # block to execute before .save calls to bring email to lowercase
  before_save { email.downcase! }

  # call validates with attribute and optinos hash requiring presence on name field
  validates :name, presence: true, length: { maximum: 50}
  # valid email REGEX (accepting basic structure email formats)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # validate email field to require presence
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
