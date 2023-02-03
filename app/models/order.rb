class Order < ApplicationRecord
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
end
