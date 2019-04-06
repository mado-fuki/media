class Post < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 300 }
  validate :images_number, on: :created_post

  private

    def images_number
      errors.add(:images, "を1枚以上指定して下さい") if images.size < 1
      errors.add(:images, "は8枚までです") if images.size > 8
    end
end