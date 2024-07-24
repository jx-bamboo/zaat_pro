class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :async
  
  has_many :invited_users, dependent: :destroy
  has_one :token, dependent: :destroy
  has_many :token_changes, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :earns, dependent: :destroy
  
  # validates :email, uniqueness: { scope: :address }
  validates :address, uniqueness: true
  enum role: [:user, :admin]

  before_create :generate_invitation_code

  def admin?
    role == "admin"
  end

  def format_email
    local_email = read_attribute(:email)
    local_email.include?("@address.zaat") ? nil : local_email
  end

  def format_address
    local_address = read_attribute(:address)
    local_address.include?("zaat_") ? nil : local_address
  end

  private 
  
  def generate_invitation_code
    self.invitation_code = SecureRandom.hex(4)
  end
end
