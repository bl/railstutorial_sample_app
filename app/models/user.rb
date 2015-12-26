class User < ActiveRecord::Base
  # virtual (non-ActiveRecord) attribute to store remember token
  attr_accessor :remember_token, :activation_token
  # block to execute before .save calls to bring email to lowercase
  before_save   :downcase_email
  before_create :create_activation_digest

  # call validates with attribute and optinos hash requiring presence on name field
  validates :name, presence: true, length: { maximum: 50}
  # valid email REGEX (accepting basic structure email formats)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # validate email field to require presence
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # returns a random token (used as cookie token)
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  private
    # converts email to all lover-case
    def downcase_email
      self.email = email.downcase
    end

    # creates and assigns the activation token and digest
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
