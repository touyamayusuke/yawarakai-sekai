class Board < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
end
