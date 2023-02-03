class Order < ApplicationRecord
  validate :validate_carted_products

  belongs_to :user
  has_many :carted_products
  has_many :products, through: :carted_products

  def update_totals
    calculated_subtotal = 0
    index = 0
    while index < carted_products.length
      carted_product = carted_products[index]
      calculated_subtotal += carted_product.quantity * carted_product.product.price
      index += 1
    end
    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax
    update(subtotal: calculated_subtotal, tax: calculated_tax, total: calculated_total)
  end

  def validate_carted_products
    carted_products_count = User.find_by(id: user_id).carted_products.where(status: "carted").size
    errors.add(:carted_products, "can't be empty") if carted_products_count == 0
  end
end
