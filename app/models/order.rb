class Order < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :prompt, presence: true
  validates :txhash, presence: true, uniqueness: true

  enum status: [:pending, :creating, :completed, :admin]

  scope :not_success, -> { where(status: [0, 1]).order(created_at: :desc).limit(3) }
  scope :not_admin, -> { where.not(status: 3).order(created_at: :desc)}
  scope :all_admin, -> { where(status: 3).order(created_at: :desc)}

  before_create :generate_order_number

  def file_name
    image.filename
  end

  def generate_order_number
    self.order_number = Time.now.strftime("%Y%m%d%H%M%S%L")
  end

end
