json.id order.id
json.subtotal order.subtotal
json.tax order.tax
json.total order.total
json.carted_products order.carted_products do |carted_product|
  json.id carted_product.id
  json.quantity carted_product.quantity
  json.status carted_product.status
  json.product carted_product.product
end
json.created_at order.created_at
json.updated_at order.updated_at
