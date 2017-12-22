class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :reviews
  has_many :images
  has_many :carts

  validates :name, presence: true

  scope :search_by_name, (lambda do |name|
    where('name LIKE ?', "%#{name}%")
  end)

  scope :order_desc, -> {order created_at: :desc}
end
