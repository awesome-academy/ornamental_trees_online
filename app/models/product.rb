class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :reviews
  has_many :images
  has_many :carts
end
