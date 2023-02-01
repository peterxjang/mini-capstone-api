class Category < ApplicationRecord
  has_many :category_products

  has_many :products, through: :category_products
  # def products
  #   result = []
  #   index = 0
  #   while index < category_products.length
  #     result << category_products[index].product
  #     index += 1
  #   end
  #   result
  # end
end
