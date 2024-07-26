class Order < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :prompt, presence: true
  validates :txhash, presence: true, uniqueness: true

  enum status: [:pending, :creating, :completed]

  scope :not_success, -> { where.not(status: 2).order(created_at: :desc)}

  def file_name
    image.filename
  end

end
