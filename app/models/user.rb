class User <ApplicationRecord 
  validates_presence_of :email, :name 
  validates_uniqueness_of :email
  validates_presence_of :password
  validates_presence_of :password_digest, presence: true
  has_many :viewing_parties
  validates :password_confirmation, presence: true

  has_secure_password
  enum role: ["default", "registered_user"]
end 