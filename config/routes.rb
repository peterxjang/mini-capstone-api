Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/all_products", controller: "products", action: "all_products"
  get "/first_product", controller: "products", action: "first_product"
  get "/second_product", controller: "products", action: "second_product"
end
